class Category {
  String id;
  String name;
  String icon;
  Category({required this.id, required this.name , required this.icon});
  Category.fromJson(Map<String, dynamic> json)
      : this(id: json['id'], name: json['name'] , icon: json['icon']);

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
