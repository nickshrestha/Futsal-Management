import 'package:flutter/material.dart';
import 'package:myhomepage/splash.dart';
import 'Services/auth_service.dart';
import 'navigation_drawer_widget.dart';
import 'registration.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlayChat',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(
        duration: 3,
        goToPage: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

bool isRememberMe = false;

class _MyHomePageState extends State<MyHomePage> {
  // Define a key to access the form
  final _formKey = GlobalKey<FormState>();

  String _userEmail = '';
  String _password = '';

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  // This function is triggered when the user press the "Sign Up" button
  Future<void> _trySubmitForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      print('Everything looks good!');

      final authService = AuthService();
      final bool isSuccess = await authService.signIn(_userEmail, _password);

      if (isSuccess) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NavigationDrawerWidget(),
          ),
        );
        final snackBar = SnackBar(
          content: Text('You are logged in!'),
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

  // Forget Passsword Button
  Widget buildForgetPasswordButton() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print("Forget Password Pressed"),
        child: Text(
          'Forget Password?',
          style: TextStyle(
            color: Color.fromARGB(137, 255, 255, 255),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

// Remmember Password Button
  Widget buildRememberCB() {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(
                unselectedWidgetColor: Color.fromARGB(255, 255, 255, 255)),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Color.fromARGB(255, 255, 255, 255),
              activeColor: Colors.green.shade900,
              onChanged: (value) {
                setState(() {
                  isRememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember Me',
            style: TextStyle(
              color: Color.fromARGB(136, 255, 255, 255),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

//Signup button
  Widget buildSignupButton() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Registration()));
      },
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: 'Dont have an Account? ',
            style: TextStyle(
              color: Color.fromARGB(137, 255, 255, 255),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: 'Sign Up',
            style: TextStyle(
              color: Color.fromARGB(137, 255, 255, 255),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
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
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        hintStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
      ),
    );

    final passwordField = TextFormField(
      obscureText: true,
      style: TextStyle(color: Colors.white),
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
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        hintStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        ),
      ),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.green.shade900,
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        height: 50.0,
        minWidth: 50,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: _trySubmitForm,
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style:
              style.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              // color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 155.0,
                      child: Image.asset(
                        "assets/images/image.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 45.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    buildForgetPasswordButton(),
                    buildRememberCB(),
                    SizedBox(
                      height: 15.0,
                    ),
                    loginButon,
                    buildSignupButton(),
                    SizedBox(
                      height: 25.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
