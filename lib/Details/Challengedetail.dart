import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myhomepage/AppbarPages/Challenge.dart';

import '../Services/challengedetails_service.dart';

// ignore: camel_case_types
class Challenge_page extends StatefulWidget {
  const Challenge_page({Key? key}) : super(key: key);

  @override
  _Challenge_pageState createState() => _Challenge_pageState();
}

// ignore: camel_case_types
class _Challenge_pageState extends State<Challenge_page> {
  String _username = '';
  String _email = '';

  get areaList => null;

  setData(challenges, error) {
    if (error != '') {
      final snackBar = SnackBar(
        content: Text(error),
        backgroundColor: Colors.redAccent,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    setState(() {
      if (challenges[0]['username'] != null)
        _username = challenges[0]['username'];
      if (challenges[0]['email'] != null) _email = challenges[0]['email'];
    });
  }

  @override
  initState() {
    super.initState();
    final ChallengeService challengeService = ChallengeService();
    challengeService.getChallenges().then((challenge) =>
        {setData(jsonDecode(challenge.toString()), challengeService.error)});
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                              ),
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => Challenges())),
                              child: Text('Create challenges'),
                            ),
                          ]),
                      DataTable(
                        columns: [
                          DataColumn(label: Text("Username")),
                          DataColumn(label: Text("email")),
                        ],
                        rows:
                            // areaList
                            //     .map<DataRow>((element) => DataRow(cells: [
                            //           DataCell(Text(element._username.toString())),
                            //           DataCell(Text(element._email.toString())),
                            //           DataCell(Text(element._username.toString())),
                            //         ]))
                            //     .toList()

                            [
                          DataRow(cells: [
                            DataCell(Text(_username)),
                            DataCell(Text(_email)),
                          ]),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 45),
                        child: Center(
                          child: Image.asset(
                            "assets/images/Football.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
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
