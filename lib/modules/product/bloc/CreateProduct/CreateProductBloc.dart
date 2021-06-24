import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:omnichannel_flutter/constant/Status.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneProductInput.dart';
import 'package:omnichannel_flutter/data/modals/CreateOneStockInput.dart';
import 'package:omnichannel_flutter/data/repository/remote_repository.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateProduct/CreateProductEvent.dart';
import 'package:omnichannel_flutter/modules/product/bloc/CreateProduct/CreateProductState.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  CreateProductBloc()
      : super(CreateProductState(
            status: Status.initial,
            createProductInput: CreateOneProductInput.empty()));

  @override
  Stream<CreateProductState> mapEventToState(CreateProductEvent event) async* {
    log(event.toString());

    if (event is CreateProductEventRequest) {
      yield state.copyWith(status: Status.loading);
      final data =
          await RemoteRepository.createProduct(state.createProductInput);
      if (data.isRight) {
        yield state.copyWith(status: Status.success);
      } else {
        yield state.copyWith(status: Status.fail);
      }
    }

    if (event is CreateProductEventClear) {
      yield state.copyWith(
        createProductInput: CreateOneProductInput.empty(),
        status: Status.initial,
      );
    }

    if (event is CreateProductEventChangeCategory) {
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(catIds: [event.cate.sId], cats: [event.cate]));
    } else if (event is CreateProductEventChangeName) {
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(name: event.name));
    } else if (event is CreateProductEventChangePrice) {
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(price: event.price));
    } else if (event is CreateProductEventChangeWeight) {
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(weight: event.weight));
    } else if (event is CreateProductEventChangeInPrice) {
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(inPrice: event.inPrice));
    } else if (event is CreateProductEventChangeSalePrice) {
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(salePrice: event.salePrice));
    } else if (event is CreateProductEventChangeBranch) {
    } else if (event is CreateProductEventChangeTags) {
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(tagNames: event.tags));
    } else if (event is CreateProductEventAddTag) {
      List<String> tags = List.from(state.createProductInput.tagNames);
      tags.add(event.tag);
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(tagNames: tags));
    } else if (event is CreateProductEventRemoveTag) {
      List<String> tags = List.from(state.createProductInput.tagNames);
      tags.removeAt(event.index);
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(tagNames: tags));
    } else if (event is CreateProductEventChangeIsMen) {
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(men: event.isMen));
    } else if (event is CreateProductEventChangeIsWomen) {
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(women: event.isWomen));
    } else if (event is CreateProductEventChangeIsBoy) {
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(boy: event.isBoy));
    } else if (event is CreateProductEventChangeIsGirl) {
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(girl: event.isGirl));
    } else if (event is CreateProductEventChangePhotoUrls) {
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(photoUrls: event.photoUrls));
    } else if (event is CreateProductEventAddPhotoUrls) {
      List<String> urls = List.from(state.createProductInput.photoUrls);
      urls.add(event.url);
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(photoUrls: urls));
    } else if (event is CreateProductEventRemovePhotoUrls) {
      List<String> urls = List.from(state.createProductInput.photoUrls);
      urls.removeAt(event.index);
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(photoUrls: urls));
    } else if (event is CreateProductEventChangeDescription) {
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(desc: event.des));
    } else if (event is CreateProductEventChangeVariants) {
      yield state.copyWith(
          createProductInput:
              state.createProductInput.copyWith(variants: event.variants));
    } else if (event is CreateProductEventChangeAttributes) {
      yield state.copyWith(
          createProductInput: state.createProductInput.copyWith(
              attributes: event.attributes
                  .where((element) => element.values.isNotEmpty)
                  .toList()));
    }

    if (event is GetProductDetail) {
      yield state.copyWith(
          productDetail: ProductDetail(status: Status.loading));
      try {
        final product = await RemoteRepository.getProductDetail(event.id);
        yield state.copyWith(
            createProductInput: CreateOneProductInput(
              variants: product.variants
                  ?.map((e) => Variants(
                      weight: e.weight?.toDouble(),
                      id: e.id,
                      salePrice: e.salePrice?.toDouble(),
                      inPrice: e.inPrice?.toDouble(),
                      price: e.price?.toDouble(),
                      attributes: e.attributes?.map((e) => ProductVariantsAttributesInput(name: e.name, value: e.value))?.toList() ?? [],
              ))
                  ?.toList(),
              attributes: product.attributes?.map((e) => ProductAttributesInput(name: e.name, values: e.values))?.toList() ?? [],
              price: product.price,
              name: product.name,
              boy: product.boy,
              girl: product.girl,
              catIds: product.catIds,
              desc: product.desc,
              inPrice: product.inPrice?.toDouble(),
              men: product.men,
              photoIds: product.photoIds,
              photoUrls: product.photos?.map((e) => e.url)?.toList() ?? [],
              salePrice: product.salePrice?.toDouble(),
              tagNames: product.tags?.map((e) => e['name'])?.toList()?.cast<String>() ?? [],
              weight: product.weight?.toDouble(),
              women: product.women,
              cats: product.cats,
              brandName: product?.brand?.name
            ),
            productDetail: ProductDetail(status: Status.success));
      } catch (e) {
        state.copyWith(productDetail: ProductDetail(status: Status.fail));
      }
    }

    if (event is UpdateProductRequest) {
      yield state.copyWith(status: Status.loading);
      final success = await RemoteRepository.updateProduct(event.id, state.createProductInput);
      event.callback(success);
      yield state.copyWith(status: Status.initial);
    }
  }
}
