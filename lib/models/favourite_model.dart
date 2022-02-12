class FavouriteModel {
  FavouriteModel({
    required this.status,
    required this.message,
  });
  bool? status;
  String? message;

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? false;
    message = json['message'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}
