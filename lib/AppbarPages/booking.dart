import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myhomepage/Details/bookingdetails.dart';

import '../Services/Booking_service.dart';

class Bookings extends StatefulWidget {
  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  final _formKey = GlobalKey<FormState>();

  String date = '';
  String time = '';
  String username = '';

  // This function is triggered when the user press the "Sign Up" button
  Future<void> _trySubmitForm() async {
    final isValid = this._formKey.currentState!.validate();
    if (isValid) {
      print('Everything looks good!');

      final bookingService = BookingService();
      final bool isSuccess = await bookingService.create(date, time, username);

      if (!isSuccess) {
        final snackBar = SnackBar(
          content: Text(bookingService.error),
          backgroundColor: Colors.redAccent,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      } else {
        final snackBar = SnackBar(
          content: Text('Your time is booked.'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _formKey.currentState?.reset();
      }
    }
  }

  Widget builddate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Date',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
              ]),
          height: 60,
          child: TextFormField(
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'date is required';
              }
              // Check if the entered email has the right format
              if (!RegExp(r'\d{0,4}/\d{0,2}\/\d{0,2}').hasMatch(value)) {
                return 'Please enter a valid date';
              }
              // Return null if the entered email is valid
              return null;
            },
            onChanged: (value) => this.date = value,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.person, color: Colors.black),
              hintText: '(YYYY/MM/DD)',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        ),
      ],
    );
  }

// Time Box
  Widget buildTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Time',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
              ]),
          height: 60,
          child: TextFormField(
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'Time is required';
              }
              // Check if the entered email has the right format
              if (!RegExp(r'\d{0,2}\:\d{0,2}\s{0,2}').hasMatch(value)) {
                return 'Please enter a valid Time';
              }
              // Return null if the entered email is valid
              return null;
            },
            onChanged: (value) => this.time = value,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.email, color: Colors.black),
              hintText: '(HH:MM AM/PM)',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        ),
      ],
    );
  }

// username box
  Widget buildusername() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'User Name',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
              ]),
          height: 60,
          child: TextFormField(
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'Username is required';
              }
              if (value.trim().length < 4) {
                return 'Username must be at least 4 characters in length';
              }
              // Return null if the entered username is valid
              return null;
            },
            onChanged: (value) => this.username = value,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.person, color: Colors.black),
              hintText: 'User',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        ),
      ],
    );
  }

//Submit Button
  Widget buildSubmitButton() {
    return Container(
      color: Colors.white,
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        height: 50.0,
        minWidth: 50,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: _trySubmitForm,
        splashColor: Colors.white,
        child: Text(
          "Sumit",
          textAlign: TextAlign.center,
        ),
        textColor: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green.shade900,
              ),
              child: Form(
                key: this._formKey,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Booking_page())),
                          child: Text('View Booked Shedule'),
                        ),
                      ]),
                      builddate(),
                      SizedBox(
                        height: 20,
                      ),
                      buildTime(),
                      SizedBox(
                        height: 20,
                      ),
                      buildusername(),
                      SizedBox(
                        height: 20,
                      ),
                      buildSubmitButton(),
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
