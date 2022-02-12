class HomeModel {
  bool? status;
  HomeData? homeData;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? false;
    homeData = json['data'] != null ? HomeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final _HomeData = <String, dynamic>{};
    _HomeData['status'] = status;
    _HomeData['data'] = _HomeData['data'] != null ? homeData!.toJson() : null;
    return _HomeData;
  }
}

class HomeData {
  HomeData({
    required this.banners,
    required this.products,
  });
  late final List<Banners>? banners;
  late final List<Products>? products;

  HomeData.fromJson(Map<String, dynamic> json) {
    banners =
        List.from(json['banners']).map((e) => Banners.fromJson(e)).toList();
    products =
        List.from(json['products']).map((e) => Products.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _HomeData = <String, dynamic>{};
    _HomeData['banners'] = banners!.map((e) => e.toJson()).toList();
    _HomeData['products'] = products!.map((e) => e.toJson()).toList();
    return _HomeData;
  }
}

class Banners {
  Banners({
    required this.id,
    required this.image,
  });
  late final int id;
  late final String image;
  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    image = json['image'] ?? "";
  }
  Map<String, dynamic> toJson() {
    final _HomeData = <String, dynamic>{};
    _HomeData['id'] = id;
    _HomeData['image'] = image;
    return _HomeData;
  }
}

class Products {
  Products({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.inFavorites,
    required this.inCart,
  });
  late final int id;
  late final dynamic price;
  late final dynamic oldPrice;
  late final dynamic discount;
  late final String image;
  late final String name;
  late final bool inFavorites;
  late final bool inCart;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    price = json['price'] ?? "";
    oldPrice = json['old_price'] ?? "";
    discount = json['discount'] ?? "";
    image = json['image'] ?? "";
    name = json['name'] ?? "";
    inFavorites = json['in_favorites'] ?? "";
    inCart = json['in_cart'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _HomeData = <String, dynamic>{};
    _HomeData['id'] = id;
    _HomeData['price'] = price;
    _HomeData['old_price'] = oldPrice;
    _HomeData['discount'] = discount;
    _HomeData['image'] = image;
    _HomeData['name'] = name;
    _HomeData['in_favorites'] = inFavorites;
    _HomeData['in_cart'] = inCart;
    return _HomeData;
  }
}
