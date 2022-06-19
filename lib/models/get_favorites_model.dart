class GetFavorites {
  bool? status;
  Data? data;
  GetFavorites.froJson(Map<String, dynamic> json) {
    status = json['status'];

    data = Data.fromJson(json['data']);
  }
}

class Data {
  List<DataProducts> data = [];
  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
    json['data'].forEach((element) {
      data.add(DataProducts.fromJson(element));
    });
  }
}

class DataProducts {
  FavoritesProducts? data;
  dynamic id;

  DataProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = FavoritesProducts.fromJson(json['product']);
  }
}

class FavoritesProducts {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  FavoritesProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
