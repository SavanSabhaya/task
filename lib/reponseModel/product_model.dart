class ProductListModel {
  bool? success;
  List<Data>? data;

  ProductListModel({this.success, this.data});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? date;
  String? orderID;
  double? paidAmount;
  double? discountAmount;
  int? redeemedRewards;
  String? coolerId;
  String? paymentStatus;
  int? amountDeductedByRewardPoint;
  double? amountDeductedByPaymentGateway;
  List<Product>? product;

  Data(
      {this.date,
      this.orderID,
      this.paidAmount,
      this.discountAmount,
      this.redeemedRewards,
      this.coolerId,
      this.paymentStatus,
      this.amountDeductedByRewardPoint,
      this.amountDeductedByPaymentGateway,
      this.product});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    orderID = json['orderID'];
    paidAmount = json['paidAmount'];
    discountAmount = json['discountAmount'];
    redeemedRewards = json['redeemedRewards'];
    coolerId = json['coolerId'];
    paymentStatus = json['paymentStatus'];
    amountDeductedByRewardPoint = json['amountDeductedByRewardPoint'];
    amountDeductedByPaymentGateway = json['amountDeductedByPaymentGateway'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['orderID'] = this.orderID;
    data['paidAmount'] = this.paidAmount;
    data['discountAmount'] = this.discountAmount;
    data['redeemedRewards'] = this.redeemedRewards;
    data['coolerId'] = this.coolerId;
    data['paymentStatus'] = this.paymentStatus;
    data['amountDeductedByRewardPoint'] = this.amountDeductedByRewardPoint;
    data['amountDeductedByPaymentGateway'] =
        this.amountDeductedByPaymentGateway;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? productName;
  int? productId;
  dynamic? perProductPrice;
  int? productCount;
  String? productOtherUrl;
  String? productLocalName;
  String? currencyCode;
  String? currencyName;
  String? shortName;
  String? flavourName;
  String? packagingType;

  Product(
      {this.productName,
      this.productId,
      this.perProductPrice,
      this.productCount,
      this.productOtherUrl,
      this.productLocalName,
      this.currencyCode,
      this.currencyName,
      this.shortName,
      this.flavourName,
      this.packagingType});

  Product.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    productId = json['productId'];
    perProductPrice = json['perProductPrice'];
    productCount = json['productCount'];
    productOtherUrl = json['productOtherUrl'];
    productLocalName = json['productLocalName'];
    currencyCode = json['currencyCode'];
    currencyName = json['currencyName'];
    shortName = json['shortName'];
    flavourName = json['flavourName'];
    packagingType = json['packagingType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['productId'] = this.productId;
    data['perProductPrice'] = this.perProductPrice;
    data['productCount'] = this.productCount;
    data['productOtherUrl'] = this.productOtherUrl;
    data['productLocalName'] = this.productLocalName;
    data['currencyCode'] = this.currencyCode;
    data['currencyName'] = this.currencyName;
    data['shortName'] = this.shortName;
    data['flavourName'] = this.flavourName;
    data['packagingType'] = this.packagingType;
    return data;
  }
}
