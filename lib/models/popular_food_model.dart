
class Products{
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createAt;
  String? updatedAt;
  int? typeId;

  Products({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stars,
    this.img,
    this.location,
    this.createAt,
    this.updatedAt,
    this.typeId
});
  Products.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }


}