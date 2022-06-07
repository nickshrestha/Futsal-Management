// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppbarPages/Events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageDetails _$ImageDetailsFromJson(Map<String, dynamic> json) => ImageDetails(
      imagePath: json['imagePath'] as String,
      price: json['price'] as String,
      photographer: json['photographer'] as String,
      title: json['title'] as String,
      details: json['details'] as String,
    );

Map<String, dynamic> _$ImageDetailsToJson(ImageDetails instance) =>
    <String, dynamic>{
      'imagePath': instance.imagePath,
      'price': instance.price,
      'photographer': instance.photographer,
      'title': instance.title,
      'details': instance.details,
    };
