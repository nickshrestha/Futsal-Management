import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Services/bookingdetails_services.dart';

// ignore: camel_case_types
class Booking_page extends StatefulWidget {
  const Booking_page({Key? key}) : super(key: key);

  @override
  _Booking_pageState createState() => _Booking_pageState();
}

// ignore: camel_case_types
class _Booking_pageState extends State<Booking_page> {
  String _date = '';
  String _time = '';
  String _username = '';

  get areaList => null;

  setData(bookings, error) {
    if (error != '') {
      final snackBar = SnackBar(
        content: Text(error),
        backgroundColor: Colors.redAccent,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    setState(() {
      if (bookings[0]['date'] != null) _date = bookings[0]['date'];
      if (bookings[0]['time'] != null) _time = bookings[0]['time'];
      if (bookings[0]['username'] != null) _username = bookings[0]['username'];
    });
  }

  @override
  initState() {
    super.initState();
    final BookingService bookingService = BookingService();
    bookingService.getBookings().then((booking) =>
        {setData(jsonDecode(booking.toString()), bookingService.error)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Center(
          child: Row(
            children: [
              Expanded(
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ListTile(
                      title: Text(
                        "Booked List",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Form(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 80,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DataTable(
                        columns: [
                          DataColumn(label: Text("Date")),
                          DataColumn(label: Text("Time")),
                          DataColumn(label: Text("User Name")),
                        ],
                        rows:
                            // areaList
                            //     .map<DataRow>((element) => DataRow(cells: [
                            //           DataCell(Text(element._date.toString())),
                            //           DataCell(Text(element._time.toString())),
                            //           DataCell(Text(element._username.toString())),
                            //         ]))
                            //     .toList()

                            [
                          DataRow(cells: [
                            DataCell(Text(_date)),
                            DataCell(Text(_time)),
                            DataCell(Text(_username)),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(_date)),
                            DataCell(Text(_time)),
                            DataCell(Text(_username)),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(_date)),
                            DataCell(Text(_time)),
                            DataCell(Text(_username)),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(_date)),
                            DataCell(Text(_time)),
                            DataCell(Text(_username)),
                          ]),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
