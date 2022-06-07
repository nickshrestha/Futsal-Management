import 'package:flutter/material.dart';
import 'package:myhomepage/Details/teamdetail.dart';

import 'Team.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(children: <Widget>[
        /// Goku Saiyan 1 card
        Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Ink.image(
                    image: AssetImage(
                      'assets/images/Ground.png',
                    ),
                    height: 240,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16).copyWith(bottom: 0),
                child: Text(
                  'We can Views Teams and  Create Teams here',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text('Create teams'),
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Teams())),
                  ),
                  TextButton(
                    child: Text('View Teams'),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Team_page())),
                  )
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
