import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myhomepage/AppbarPages/Team.dart';

import '../Services/teamdetail_service.dart';

// ignore: camel_case_types
class Team_page extends StatefulWidget {
  const Team_page({Key? key}) : super(key: key);

  @override
  _Team_pageState createState() => _Team_pageState();
}

// ignore: camel_case_types
class _Team_pageState extends State<Team_page> {
  String _username = '';
  String _email = '';
  String _team = '';

  get areaList => null;

  setData(teams, error) {
    if (error != '') {
      final snackBar = SnackBar(
        content: Text(error),
        backgroundColor: Colors.redAccent,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    setState(() {
      if (teams[0]['username'] != null) _username = teams[0]['username'];
      if (teams[0]['email'] != null) _email = teams[0]['email'];
      if (teams[0]['team'] != null) _team = teams[0]['team'];
    });
  }

  @override
  initState() {
    super.initState();
    final TeamService teamService = TeamService();
    teamService.getTeams().then(
        (team) => {setData(jsonDecode(team.toString()), teamService.error)});
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
                        "Team List",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'View Teams',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      DataTable(
                        columns: [
                          DataColumn(label: Text("Username")),
                          DataColumn(label: Text("email")),
                          DataColumn(label: Text("Team Name")),
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
                            DataCell(Text(_team)),
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
