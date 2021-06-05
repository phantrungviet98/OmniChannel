import 'package:omnichannel_flutter/data/modals/CreateOneProductInput.dart';
import 'package:omnichannel_flutter/data/modals/GetAllCateResponse.dart';

abstract class CreateProductEvent {
  const CreateProductEvent();
}

class CreateProductEventChangeCategory extends CreateProductEvent  {
  const CreateProductEventChangeCategory({this.cate});
  final Cats cate;
}

class CreateProductEventChangeName extends CreateProductEvent {
  const CreateProductEventChangeName({this.name});
  final String name;
}

class CreateProductEventChangePrice extends CreateProductEvent {
  const CreateProductEventChangePrice({this.price});
  final double price;
}

class CreateProductEventChangeWeight extends CreateProductEvent {
  const CreateProductEventChangeWeight({this.weight});
  final double weight;
}

class CreateProductEventChangeInPrice extends CreateProductEvent {
  const CreateProductEventChangeInPrice({this.inPrice});
  final double inPrice;
}

class CreateProductEventChangeSalePrice extends CreateProductEvent {
  const CreateProductEventChangeSalePrice({this.salePrice});
  final double salePrice;
}

class CreateProductEventChangeBranch extends CreateProductEvent {
  const CreateProductEventChangeBranch({this.branch});
  final String branch;
}

class CreateProductEventChangeTags extends CreateProductEvent {
  const CreateProductEventChangeTags({this.tags});
  final List<String> tags;
}

class CreateProductEventAddTag extends CreateProductEvent {
  const CreateProductEventAddTag({this.tag});
  final String tag;
}

class CreateProductEventRemoveTag extends CreateProductEvent {
  const CreateProductEventRemoveTag({this.index});
  final int index;
}

class CreateProductEventChangeIsMen extends CreateProductEvent {
  const CreateProductEventChangeIsMen({this.isMen});
  final bool isMen;
}

class CreateProductEventChangeIsWomen extends CreateProductEvent {
  const CreateProductEventChangeIsWomen({this.isWomen});
  final bool isWomen;
}

class CreateProductEventChangeIsBoy extends CreateProductEvent {
  const CreateProductEventChangeIsBoy({this.isBoy});
  final bool isBoy;
}

class CreateProductEventChangeIsGirl extends CreateProductEvent {
  const CreateProductEventChangeIsGirl({this.isGirl});
  final bool isGirl;
}

class CreateProductEventChangePhotoUrls extends CreateProductEvent {
  const CreateProductEventChangePhotoUrls({this.photoUrls});
  final List<String> photoUrls;
}

class CreateProductEventAddPhotoUrls extends CreateProductEvent {
  const CreateProductEventAddPhotoUrls(this.url);
  final String url;
}

class CreateProductEventRemovePhotoUrls extends CreateProductEvent {
  const CreateProductEventRemovePhotoUrls(this.index);
  final int index;
}

class CreateProductEventChangeDescription extends CreateProductEvent {
  const CreateProductEventChangeDescription({this.des});
  final String des;
}

class CreateProductEventChangeVariants extends CreateProductEvent {
  const CreateProductEventChangeVariants({this.variants});
  final List<Variants> variants;
}

class CreateProductEventChangeAttributes extends CreateProductEvent {
  const CreateProductEventChangeAttributes({this.attributes});
  final List<ProductAttributesInput> attributes;
}

class CreateProductEventRequest extends CreateProductEvent {
  const CreateProductEventRequest();
}

class CreateProductEventClear extends CreateProductEvent {
  const CreateProductEventClear();
}