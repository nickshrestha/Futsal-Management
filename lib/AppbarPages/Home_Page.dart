import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myhomepage/Details/imagedetails.dart';
import 'package:myhomepage/Services/venue_service.dart';

// ignore: camel_case_types
class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  _Home_pageState createState() => _Home_pageState();
}

// ignore: camel_case_types
class _Home_pageState extends State<Home_page> {
  String _description = '';
  String _imageUrl = 'assets/images/party.jpg';
  String _name = '';

  setData(venues, error) {
    if (error != '') {
      final snackBar = SnackBar(
        content: Text(error),
        backgroundColor: Colors.redAccent,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    setState(() {
      if (venues[0]['description'] != null)
        _description = venues[0]['description'];
      if (venues[0]['imageUrl'] != null) _imageUrl = venues[0]['imageUrl'];
      if (venues[0]['name'] != null) _name = venues[0]['name'];
    });
  }

  @override
  initState() {
    super.initState();
    final VenueService venueService = VenueService();
    venueService.getVenue().then((venues) =>
        {setData(jsonDecode(venues.toString()), venueService.error)});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(children: <Widget>[
        /// home page
        Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    // 'assets/images/party.jpg',
                    _imageUrl,
                    height: 370,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    left: 16,
                    child: Text(
                      // 'Venue Management',
                      _name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16).copyWith(bottom: 0),
                child: Text(
                  // 'Roses & Drapes Event Venue will be targeting customers in the Colorado Springs area. The list of customers will be small and large companies, and families in the area that require family events. They will be targeting young couples that plan on getting married, parents that need a baby shower venue, parents that are planning their teenager Sweet 16 party, older couples that are celebrating milestone anniversaries. A lot of their clients will overlap as some will be holding corporate events and will also require a family event, and vice versa. Another meaning of venue is specific to the law as the place where a trial will be held, and the area from which the jury will be selected. If you stealing, and youre known around town as "Sticky Fingers Magoo," your lawyer would wisely request a change of venue to give you a better shot at a fair trial.',
                  _description,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            imagedetails(size: size),
            SizedBox(
              height: 10,
            )
          ]),
        )
      ]),
    );
  }
}
