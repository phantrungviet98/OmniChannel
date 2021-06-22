import 'package:omnichannel_flutter/data/modals/CreateOneStockImportExportInput.dart';
import 'package:provider/provider.dart';

abstract class CreateImportExportEvent {
  const CreateImportExportEvent();
}

class LookupProduct extends CreateImportExportEvent {
  const LookupProduct(this.text);
  final String text;
}

class ChangeStock extends CreateImportExportEvent {
  const ChangeStock(this.id);
  final String id;
}

class AddProduct extends CreateImportExportEvent {
  const AddProduct(this.product, this.callback);
  final StockImportExportItemInput product;
  final Function(bool) callback;
}

class UpdatePayload extends CreateImportExportEvent {
  const UpdatePayload(this.payload);
  final CreateOneStockImportExportInput payload;
}

class EditQuantity extends CreateImportExportEvent {
  const EditQuantity(this.index);
  final int index;
}

class MinusQuantity extends EditQuantity {
  const MinusQuantity({this.index}): super(index);
  final int index;
}

class AddQuantity extends EditQuantity {
  const AddQuantity({this.index}): super(index);
  final int index;
}

class ChangeNote extends CreateImportExportEvent {
  const ChangeNote(this.note);
  final String note;
}

abstract class TriggerCreate extends CreateImportExportEvent {
  const TriggerCreate(this.callback);
  final Function(bool) callback;
}

class TriggerCreateImport extends TriggerCreate {
  const TriggerCreateImport({callback}): super(callback);
}

class TriggerCreateExport extends TriggerCreate {
  const TriggerCreateExport({callback}): super(callback);
}