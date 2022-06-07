import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myhomepage/Services/feedback_service.dart';

class Feedbacks extends StatefulWidget {
  @override
  _FeedbacksState createState() => _FeedbacksState();
}

class _FeedbacksState extends State<Feedbacks> {
  final _formKey = GlobalKey<FormState>();

  String username = '';
  String email = '';
  String feedback = '';

  // This function is triggered when the user press the "Sign Up" button
  Future<void> _trySubmitForm() async {
    final isValid = this._formKey.currentState!.validate();
    if (isValid) {
      print('Everything looks good!');

      final feedbackService = FeedbackService();
      final bool isSuccess =
          await feedbackService.create(username, email, feedback);

      if (!isSuccess) {
        final snackBar = SnackBar(
          content: Text(feedbackService.error),
          backgroundColor: Colors.redAccent,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      } else {
        final snackBar = SnackBar(
          content: Text('Your feedback has been received.'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _formKey.currentState?.reset();
      }
    }
  }

  Widget buildUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'User Name',
          style: TextStyle(
            color: Colors.black54,
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

// Email Box
  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
            color: Colors.black54,
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
                return 'Email is required';
              }
              // Check if the entered email has the right format
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              // Return null if the entered email is valid
              return null;
            },
            onChanged: (value) => this.email = value,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.email, color: Colors.black),
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        ),
      ],
    );
  }

// Feedback Box
  Widget buildFeedback() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        Text(
          'Feedbacks',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
              ]),
          height: 150,
          child: TextFormField(
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'Feedbacks is required';
              }
              if (value.trim().length < 4) {
                return 'Feedbacks must be at least 4 characters in length';
              }
              // Return null if the entered feedback is valid
              return null;
            },
            onChanged: (value) => this.feedback = value,
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
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
      color: Colors.green.shade900,
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
        textColor: Colors.white,
      ),
    );
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
                        "Feedbacks",
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
                      buildUI(),
                      SizedBox(
                        height: 20,
                      ),
                      buildEmail(),
                      SizedBox(
                        height: 20,
                      ),
                      buildFeedback(),
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
