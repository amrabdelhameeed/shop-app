class FavouriteItemModel {
  FavouriteItemModel({
    required this.status,
    required this.data,
  });
  bool? status;
  FavouriteItemModelData? data;

  FavouriteItemModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? false;
    data = json['data'] != null
        ? FavouriteItemModelData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class FavouriteItemModelData {
  FavouriteItemModelData({
    required this.currentPage,
    required this.favouriteData,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });
  late final int currentPage;
  late final List<FavouriteData> favouriteData;
  late final String firstPageUrl;
  late final int from;
  late final int lastPage;
  late final String lastPageUrl;
  late final String path;
  late final int perPage;
  late final int to;
  late final int total;

  FavouriteItemModelData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    favouriteData =
        List.from(json['data']).map((e) => FavouriteData.fromJson(e)).toList();
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = currentPage;
    _data['data'] = favouriteData.map((e) => e.toJson()).toList();
    _data['first_page_url'] = firstPageUrl;
    _data['from'] = from;
    _data['last_page'] = lastPage;
    _data['last_page_url'] = lastPageUrl;
    _data['path'] = path;
    _data['per_page'] = perPage;
    _data['to'] = to;
    _data['total'] = total;
    return _data;
  }
}

class FavouriteData {
  int? id;
  Product? product;

  FavouriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    product = Product.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product'] = product!.toJson();
    return _data;
  }
}

class Product {
  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });
  late final int? id;
  late final int? price;
  late final int? oldPrice;
  late final int discount;
  late final String image;
  late final String name;
  late final String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? -1;
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['price'] = price;
    _data['old_price'] = oldPrice;
    _data['discount'] = discount;
    _data['image'] = image;
    _data['name'] = name;
    _data['description'] = description;
    return _data;
  }
}
