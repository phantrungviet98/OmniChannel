import 'package:equatable/equatable.dart';

class GetAllCateResponse {
  List<Cats> cats = [];

  GetAllCateResponse({this.cats});

  GetAllCateResponse.fromJson(Map<String, dynamic> json) {
    if (json['cats'] != null) {
      json['cats'].forEach((v) {
        cats.add(new Cats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cats != null) {
      data['cats'] = this.cats.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cats extends Equatable {
  final String name;
  final Null parentId;
  final String sId;
  final List<String> ancestorIds;

  const Cats({this.name, this.parentId, this.sId, this.ancestorIds});

  factory Cats.fromJson(Map<String, dynamic> json) {
    List<String> ancestorIds = [];
    if (json['ancestor_ids'] != null) {
      json['ancestor_ids'].forEach((v) {
        ancestorIds.add(v.toString());
      });
    }
    return Cats(
        name: json['name'],
        parentId: json['parent_id'],
        sId: json['_id'],
        ancestorIds: ancestorIds);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['_id'] = this.sId;
    if (this.ancestorIds != null) {
      data['ancestor_ids'] = this.ancestorIds.toList();
    }
    return data;
  }

  @override
  List<Object> get props => [name, parentId, sId, ancestorIds];

  @override
  bool get stringify => true;
}
