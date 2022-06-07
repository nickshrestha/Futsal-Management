import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class contact extends StatelessWidget {
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
                      leading: Icon(Icons.contact_mail, color: Colors.black),
                      title: Text(
                        "Contact Us",
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
      bottomNavigationBar: ContactUsBottomAppBar(
        companyName: 'Nikhil Shrestha',
        textColor: Colors.white,
        backgroundColor: Colors.black,
        email: 'lihkinshrestha@gmail.com',
        // textFont: 'Sail',
      ),
      body: ContactUs(
          cardColor: Colors.white,
          textColor: Colors.black,
          logo: AssetImage('assets/images/Profile.png'),
          email: 'lihkinshrestha.ad@gmail.com',
          companyName: 'Nikhil Shrestha',
          companyColor: Colors.black,
          dividerThickness: 2,
          phoneNumber: '+9119841466133',
          githubUserName: 'nickShrestha',
          linkedinURL: 'www.linkedin.com/in/nikhil-shrestha369',
          tagLine: 'please contact us for more details',
          taglineColor: Colors.black,
          twitterHandle: 'nickShrestha5',
          instagram: 'Nick_shrestha369',
          facebookHandle: 'nick.shrestha.159'),
    );
  }
}
