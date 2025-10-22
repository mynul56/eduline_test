// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductDataModel {
  final int? total;
  final int? skip;
  final int? limit;
  final List<Product>? products;
  ProductDataModel({this.total, this.skip, this.limit, this.products});

  ProductDataModel copyWith({
    int? total,
    int? skip,
    int? limit,
    List<Product>? products,
  }) {
    return ProductDataModel(
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'skip': skip,
      'limit': limit,
      'products': products?.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductDataModel.fromMap(Map<String, dynamic> map) {
    return ProductDataModel(
      total: map['total'] != null ? map['total'] as int : null,
      skip: map['skip'] != null ? map['skip'] as int : null,
      limit: map['limit'] != null ? map['limit'] as int : null,
      products: map['products'] != null
          ? List<Product>.from(
              (map['products'] as List).map<Product?>(
                (x) => Product.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDataModel.fromJson(String source) =>
      ProductDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductDataModel(total: $total, skip: $skip, limit: $limit, products: $products)';
  }

  @override
  bool operator ==(covariant ProductDataModel other) {
    if (identical(this, other)) return true;

    return other.total == total &&
        other.skip == skip &&
        other.limit == limit &&
        listEquals(other.products, products);
  }

  @override
  int get hashCode {
    return total.hashCode ^ skip.hashCode ^ limit.hashCode ^ products.hashCode;
  }
}

class Product {
  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final List<String>? tags;
  final String? brand;
  final String? sku;
  final int? weight;
  final Dimensions? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<Review>? reviews;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final Meta? meta;
  final List<String>? images;
  final String? thumbnail;
  Product({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.images,
    this.thumbnail,
  });

  Product copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    double? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    List<String>? tags,
    String? brand,
    String? sku,
    int? weight,
    Dimensions? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    List<Review>? reviews,
    String? returnPolicy,
    int? minimumOrderQuantity,
    Meta? meta,
    List<String>? images,
    String? thumbnail,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      rating: rating ?? this.rating,
      stock: stock ?? this.stock,
      tags: tags ?? this.tags,
      brand: brand ?? this.brand,
      sku: sku ?? this.sku,
      weight: weight ?? this.weight,
      dimensions: dimensions ?? this.dimensions,
      warrantyInformation: warrantyInformation ?? this.warrantyInformation,
      shippingInformation: shippingInformation ?? this.shippingInformation,
      availabilityStatus: availabilityStatus ?? this.availabilityStatus,
      reviews: reviews ?? this.reviews,
      returnPolicy: returnPolicy ?? this.returnPolicy,
      minimumOrderQuantity: minimumOrderQuantity ?? this.minimumOrderQuantity,
      meta: meta ?? this.meta,
      images: images ?? this.images,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions?.toMap(),
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews?.map((x) => x.toMap()).toList(),
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': meta?.toMap(),
      'images': images,
      'thumbnail': thumbnail,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      category: map['category'] != null ? map['category'] as String : null,
      price: map['price'] != null ? (map['price'] as num).toDouble() : null,
      discountPercentage: map['discountPercentage'] != null
          ? (map['discountPercentage'] as num).toDouble()
          : null,
      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : null,
      stock: map['stock'] != null ? map['stock'] as int : null,
      tags: map['tags'] != null
          ? List<String>.from((map['tags'] as List))
          : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      sku: map['sku'] != null ? map['sku'] as String : null,
      weight: map['weight'] != null ? map['weight'] as int : null,
      dimensions: map['dimensions'] != null
          ? Dimensions.fromMap(map['dimensions'] as Map<String, dynamic>)
          : null,
      warrantyInformation: map['warrantyInformation'] != null
          ? map['warrantyInformation'] as String
          : null,
      shippingInformation: map['shippingInformation'] != null
          ? map['shippingInformation'] as String
          : null,
      availabilityStatus: map['availabilityStatus'] != null
          ? map['availabilityStatus'] as String
          : null,
      reviews: map['reviews'] != null
          ? List<Review>.from(
              (map['reviews'] as List).map<Review?>(
                (x) => Review.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      returnPolicy: map['returnPolicy'] != null
          ? map['returnPolicy'] as String
          : null,
      minimumOrderQuantity: map['minimumOrderQuantity'] != null
          ? map['minimumOrderQuantity'] as int
          : null,
      meta: map['meta'] != null
          ? Meta.fromMap(map['meta'] as Map<String, dynamic>)
          : null,
      images: map['images'] != null
          ? List<String>.from((map['images'] as List))
          : null,
      thumbnail: map['thumbnail'] != null ? map['thumbnail'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toDatabase() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category,
    'price': price,
    'discountPercentage': discountPercentage,
    'rating': rating,
    'stock': stock,
    'tags': jsonEncode(tags),
    'brand': brand,
    'sku': sku,
    'weight': weight,
    'dimensions': dimensions != null ? jsonEncode(dimensions!.toMap()) : null,
    'warrantyInformation': warrantyInformation,
    'shippingInformation': shippingInformation,
    'availabilityStatus': availabilityStatus,
    'reviews': jsonEncode(reviews?.map((r) => r.toMap()).toList()),
    'returnPolicy': returnPolicy,
    'minimumOrderQuantity': minimumOrderQuantity,
    'meta': meta != null ? jsonEncode(meta!.toMap()) : null,
    'images': jsonEncode(images),
    'thumbnail': thumbnail,
  };

  factory Product.fromDatabase(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      description: map['description'] != null
          ? map['description'] as String
          : null,
      category: map['category'] != null ? map['category'] as String : null,
      price: map['price'] != null ? (map['price'] as num).toDouble() : null,
      discountPercentage: map['discountPercentage'] != null
          ? (map['discountPercentage'] as num).toDouble()
          : null,
      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : null,
      stock: map['stock'] != null ? map['stock'] as int : null,
      tags: List<String>.from(jsonDecode(map['tags']) as List),

      brand: map['brand'] != null ? map['brand'] as String : null,
      sku: map['sku'] != null ? map['sku'] as String : null,
      weight: map['weight'] != null ? map['weight'] as int : null,
      dimensions: map['dimensions'] != null
          ? Dimensions.fromMap(jsonDecode(map['dimensions']))
          : null,
      warrantyInformation: map['warrantyInformation'] != null
          ? map['warrantyInformation'] as String
          : null,
      shippingInformation: map['shippingInformation'] != null
          ? map['shippingInformation'] as String
          : null,
      availabilityStatus: map['availabilityStatus'] != null
          ? map['availabilityStatus'] as String
          : null,
      reviews: map['reviews'] != null
          ? (jsonDecode(map['reviews']) as List)
                .map((r) => Review.fromMap(r))
                .toList()
          : null,
      returnPolicy: map['returnPolicy'] != null
          ? map['returnPolicy'] as String
          : null,
      minimumOrderQuantity: map['minimumOrderQuantity'] != null
          ? map['minimumOrderQuantity'] as int
          : null,
      meta: map['meta'] != null ? Meta.fromMap(jsonDecode(map['meta'])) : null,
      images: map['images'] != null
          ? (jsonDecode(map['images']) as List).cast<String>()
          : null,
      thumbnail: map['thumbnail'] != null ? map['thumbnail'] as String : null,
    );
  }

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, category: $category, price: $price, discountPercentage: $discountPercentage, rating: $rating, stock: $stock, tags: $tags, brand: $brand, sku: $sku, weight: $weight, dimensions: $dimensions, warrantyInformation: $warrantyInformation, shippingInformation: $shippingInformation, availabilityStatus: $availabilityStatus, reviews: $reviews, returnPolicy: $returnPolicy, minimumOrderQuantity: $minimumOrderQuantity, meta: $meta, images: $images, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.category == category &&
        other.price == price &&
        other.discountPercentage == discountPercentage &&
        other.rating == rating &&
        other.stock == stock &&
        listEquals(other.tags, tags) &&
        other.brand == brand &&
        other.sku == sku &&
        other.weight == weight &&
        other.dimensions == dimensions &&
        other.warrantyInformation == warrantyInformation &&
        other.shippingInformation == shippingInformation &&
        other.availabilityStatus == availabilityStatus &&
        listEquals(other.reviews, reviews) &&
        other.returnPolicy == returnPolicy &&
        other.minimumOrderQuantity == minimumOrderQuantity &&
        other.meta == meta &&
        listEquals(other.images, images) &&
        other.thumbnail == thumbnail;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        category.hashCode ^
        price.hashCode ^
        discountPercentage.hashCode ^
        rating.hashCode ^
        stock.hashCode ^
        tags.hashCode ^
        brand.hashCode ^
        sku.hashCode ^
        weight.hashCode ^
        dimensions.hashCode ^
        warrantyInformation.hashCode ^
        shippingInformation.hashCode ^
        availabilityStatus.hashCode ^
        reviews.hashCode ^
        returnPolicy.hashCode ^
        minimumOrderQuantity.hashCode ^
        meta.hashCode ^
        images.hashCode ^
        thumbnail.hashCode;
  }
}

class Dimensions {
  final double? width;
  final double? height;
  final double? depth;
  Dimensions({this.width, this.height, this.depth});

  Dimensions copyWith({double? width, double? height, double? depth}) {
    return Dimensions(
      width: width ?? this.width,
      height: height ?? this.height,
      depth: depth ?? this.depth,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'width': width, 'height': height, 'depth': depth};
  }

  factory Dimensions.fromMap(Map<String, dynamic> map) {
    return Dimensions(
      width: map['width'] != null ? (map['width'] as num).toDouble() : null,
      height: map['height'] != null ? (map['height'] as num).toDouble() : null,
      depth: map['depth'] != null ? (map['depth'] as num).toDouble() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Dimensions.fromJson(String source) =>
      Dimensions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Dimensions(width: $width, height: $height, depth: $depth)';

  @override
  bool operator ==(covariant Dimensions other) {
    if (identical(this, other)) return true;

    return other.width == width &&
        other.height == height &&
        other.depth == depth;
  }

  @override
  int get hashCode => width.hashCode ^ height.hashCode ^ depth.hashCode;
}

class Review {
  final int? rating;
  final String? comment;
  final DateTime? date;
  final String? reviewerName;
  final String? reviewerEmail;
  Review({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  Review copyWith({
    int? rating,
    String? comment,
    DateTime? date,
    String? reviewerName,
    String? reviewerEmail,
  }) {
    return Review(
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      date: date ?? this.date,
      reviewerName: reviewerName ?? this.reviewerName,
      reviewerEmail: reviewerEmail ?? this.reviewerEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rating': rating,
      'comment': comment,
      'date': date?.toIso8601String(),
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      rating: map['rating'] != null ? map['rating'] as int : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
      date: map['date'] != null ? DateTime.tryParse(map['date']) : null,
      reviewerName: map['reviewerName'] != null
          ? map['reviewerName'] as String
          : null,
      reviewerEmail: map['reviewerEmail'] != null
          ? map['reviewerEmail'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Review(rating: $rating, comment: $comment, date: $date, reviewerName: $reviewerName, reviewerEmail: $reviewerEmail)';
  }

  @override
  bool operator ==(covariant Review other) {
    if (identical(this, other)) return true;

    return other.rating == rating &&
        other.comment == comment &&
        other.date == date &&
        other.reviewerName == reviewerName &&
        other.reviewerEmail == reviewerEmail;
  }

  @override
  int get hashCode {
    return rating.hashCode ^
        comment.hashCode ^
        date.hashCode ^
        reviewerName.hashCode ^
        reviewerEmail.hashCode;
  }
}

class Meta {
  final String? createdAt;
  final String? updatedAt;
  final String? barcode;
  final String? qrCode;
  Meta({this.createdAt, this.updatedAt, this.barcode, this.qrCode});

  Meta copyWith({
    String? createdAt,
    String? updatedAt,
    String? barcode,
    String? qrCode,
  }) {
    return Meta(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      barcode: barcode ?? this.barcode,
      qrCode: qrCode ?? this.qrCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'barcode': barcode,
      'qrCode': qrCode,
    };
  }

  factory Meta.fromMap(Map<String, dynamic> map) {
    return Meta(
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      barcode: map['barcode'] != null ? map['barcode'] as String : null,
      qrCode: map['qrCode'] != null ? map['qrCode'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Meta.fromJson(String source) =>
      Meta.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Meta(createdAt: $createdAt, updatedAt: $updatedAt, barcode: $barcode, qrCode: $qrCode)';
  }

  @override
  bool operator ==(covariant Meta other) {
    if (identical(this, other)) return true;

    return other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.barcode == barcode &&
        other.qrCode == qrCode;
  }

  @override
  int get hashCode {
    return createdAt.hashCode ^
        updatedAt.hashCode ^
        barcode.hashCode ^
        qrCode.hashCode;
  }
}
