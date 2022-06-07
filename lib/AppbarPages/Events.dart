import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myhomepage/Services/event_service.dart';
import '../details_page.dart';

import 'package:json_annotation/json_annotation.dart';
part '../Events.g.dart';

List<ImageDetails> _images = [];

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 90,
                    vertical: 30,
                  ),
                  child: GridViewBuilder()),
            )
          ],
        ),
      ),
    );
  }
}

class GridViewBuilder extends StatefulWidget {
  @override
  _GridViewBuilderState createState() => _GridViewBuilderState();
}

class _GridViewBuilderState extends State<GridViewBuilder> {
  setData(events, error) {
    if (error != '') {
      final snackBar = SnackBar(
        content: Text(error),
        backgroundColor: Colors.redAccent,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    setState(() {
      _images = (events as List).map((e) => ImageDetails.fromJson(e)).toList();
    });
  }

  @override
  initState() {
    super.initState();
    final EventService eventService = EventService();
    eventService
        .getEvents()
        .then((events) => {setData(jsonDecode(events), eventService.error)});
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return RawMaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(
                  imagePath: _images[index].imagePath,
                  title: _images[index].title,
                  photographer: _images[index].photographer,
                  price: _images[index].price,
                  details: _images[index].details,
                  index: index,
                ),
              ),
            );
          },
          child: Hero(
            tag: 'logo$index',
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 90,
                vertical: 30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(_images[index].imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: _images.length,
    );
  }
}

@JsonSerializable()
class ImageDetails {
  final String imagePath;
  final String price;
  final String photographer;
  final String title;
  final String details;
  ImageDetails({
    required this.imagePath,
    required this.price,
    required this.photographer,
    required this.title,
    required this.details,
  });

  factory ImageDetails.fromJson(Map<String, dynamic> json) =>
      _$ImageDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$ImageDetailsToJson(this);
}
