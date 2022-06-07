import 'package:flutter/material.dart';
import 'package:myhomepage/main.dart';

import 'Services/auth_service.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  // Define a key to access the form
  final _formKey = GlobalKey<FormState>();

  String _userEmail = '';
  String _userFirstName = '';
  String _userLastName = '';
  // ignore: unused_field
  String _userContact = '';
  String _password = '';
  // ignore: unused_field
  String _confirmPassword = '';

  // This function is triggered when the user press the "Sign Up" button
  Future<void> _trySubmitForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      print('Everything looks good!');

      final authService = AuthService();
      final bool isSuccess = await authService.signUp(
          _userFirstName, _userLastName, _userEmail, _password);

      if (isSuccess) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ),
        );
        final snackBar = SnackBar(
          content:
              Text('Account has been created! Please login to continue...'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text(authService.error),
          backgroundColor: Colors.redAccent,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      /* 
      Continute proccessing the provided information with your own logic 
      such us sending HTTP requests, savaing to SQLite database, etc.
      */
    }
  }

  // Emaill Box
  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
                return 'Please enter your email address';
              }
              // Check if the entered email has the right format
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              // Return null if the entered email is valid
              return null;
            },
            onChanged: (value) => _userEmail = value,
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

// User First Name Box
  Widget buildUserFirstName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
                return 'This field is required';
              }
              if (value.trim().length < 4) {
                return 'Username must be at least 4 characters in length';
              }
              // Return null if the entered username is valid
              return null;
            },
            onChanged: (value) => _userFirstName = value,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.person, color: Colors.black),
              hintText: 'First Name',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        ),
      ],
    );
  }

  // User Last Name Box
  Widget buildUserLastName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
                return 'This field is required';
              }
              if (value.trim().length < 4) {
                return 'Username must be at least 4 characters in length';
              }
              // Return null if the entered username is valid
              return null;
            },
            onChanged: (value) => _userLastName = value,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.person, color: Colors.black),
              hintText: 'Last Name',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        ),
      ],
    );
  }

// Contact Box
  Widget buildContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
                return 'This field is required';
              }
              if (value.trim().length < 10) {
                return 'Enter valid Contact';
              }
              // Return null if the entered username is valid
              return null;
            },
            onChanged: (value) => _userContact = value,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.call, color: Colors.black),
              hintText: 'Contact',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        ),
      ],
    );
  }

  // Password Box
  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
              obscureText: true,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'This field is required';
                }
                if (value.trim().length < 8) {
                  return 'Password must be at least 8 characters in length';
                }
                // Return null if the entered password is valid
                return null;
              },
              onChanged: (value) => _password = value,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.lock, color: Colors.black),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.black38),
              )),
        ),
      ],
    );
  }

  //Confirm Password Box
  Widget buildConfirmPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2)),
                ]),
            height: 60,
            child: TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field is required';
                  }

                  if (value != _password) {
                    return 'Confimation password does not match the entered password';
                  }

                  return null;
                },
                onChanged: (value) => _confirmPassword = value,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.lock, color: Colors.black),
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(color: Colors.black38),
                ))),
      ],
    );
  }

//SignUp button
  Widget buildSignUpButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 100),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _trySubmitForm,
        child: Text(
          'Sign Up',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.green.shade900,
          padding: EdgeInsets.all(15),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: [
              Expanded(
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ListTile(
                      title: Text(
                        "Registration",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    )),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        alignment: Alignment.center,
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 120,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildEmail(),
                  buildUserFirstName(),
                  buildUserLastName(),
                  buildContact(),
                  buildPassword(),
                  buildConfirmPassword(),
                  buildSignUpButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
