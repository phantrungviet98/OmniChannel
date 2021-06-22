import 'package:bloc/bloc.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneStockImportExportInput.dart';
import 'package:omnichannel_flutter/data/modals/LookupProduct.dart';
import 'package:omnichannel_flutter/data/repository/remote_repository.dart';
import 'package:omnichannel_flutter/modules/home/bloc/CreateImportExport/CreateImportExportEvent.dart';
import 'package:omnichannel_flutter/modules/home/bloc/CreateImportExport/CreateImportExportState.dart';

class CreateImportExportBloc
    extends Bloc<CreateImportExportEvent, CreateImportExportState> {
  CreateImportExportBloc()
      : super(CreateImportExportState(
            lookup: LookupProducts(data: [], status: Status.initial),
            payload: CreateOneStockImportExportInput(items: [])));

  @override
  Stream<CreateImportExportState> mapEventToState(
      CreateImportExportEvent event) async* {
    if (event is LookupProduct) {
      yield state.copyWith(
          lookup: this.state.lookup.copyWith(status: Status.loading, data: []));

      try {
        final result = await RemoteRepository.lookupProduct(event.text);
        List<LookupProductModal> data = [];
        result.forEach((element) {
          element.variants.forEach((variant) {
            data.add(LookupProductModal(
              name: element.name,
              price: variant.price,
              attributes: variant.attributes,
              variantId: variant.id,
              productIdRef: element.id,
            ));
          });
        });

        yield state.copyWith(
            lookup:
                this.state.lookup.copyWith(status: Status.success, data: data));
      } catch (e) {
        yield state.copyWith(
            lookup: this.state.lookup.copyWith(status: Status.fail, data: []));
      }
    }

    if (event is UpdatePayload) {
      yield state.copyWith(payload: event.payload);
    }

    if (event is ChangeStock) {
      yield state.copyWith(payload: state.payload.copyWith(stockId: event.id));
    }

    if (event is AddProduct) {
      final findIfExist = state.payload.items
          .indexWhere((element) => element.productIdRef == event.product.productIdRef &&
              element.variantId == event.product.variantId);
      if (findIfExist == -1) {
        List<StockImportExportItemInput> items = List.from(state.payload.items);
        items.add(event.product);
        yield state.copyWith(payload: state.payload.copyWith(items: items));
        event.callback.call(false);
      } else {
        this.add(AddQuantity(index: findIfExist));
        event.callback.call(true);
      }
    }

    if (event is EditQuantity) {
      List<StockImportExportItemInput> items = List.from(state.payload.items);
      int qty = items[event.index].qty + ((event is AddQuantity) ? 1 : -1);

      if (qty == 0) {
        items.removeAt(event.index);
      } else {
        var newItem = items[event.index].copyWith(qty: qty);
        items.removeAt(event.index);
        items.insert(event.index, newItem);
      }
      yield state.copyWith(payload: state.payload.copyWith(items: items));
    }

    if (event is ChangeNote) {
      yield state.copyWith(payload: state.payload.copyWith(note: event.note));
    }

    if (event is TriggerCreate) {
      yield state.copyWith(isCreating: true);
      try {
        final success = await ((event is TriggerCreateImport)
            ? RemoteRepository.createImport(state.payload)
            : RemoteRepository.createExport(state.payload));
        event.callback(success);
      } catch (e) {
      } finally {
        yield state.copyWith(isCreating: false);
      }
    }
  }
}
