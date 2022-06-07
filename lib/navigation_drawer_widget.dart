import 'package:flutter/material.dart';
import 'package:myhomepage/AppbarPages/Challenge.dart';
import 'package:myhomepage/AppbarPages/Events.dart';
import 'package:myhomepage/AppbarPages/Team.dart';
import 'package:myhomepage/AppbarPages/TeamView.dart';
import 'package:myhomepage/Details/Challengedetail.dart';
import 'package:myhomepage/Details/teamdetail.dart';
import 'package:myhomepage/main.dart';
import 'package:myhomepage/registration.dart';
import 'AppbarPages/Home_Page.dart';
import 'people_page.dart';
import 'user_page.dart';
import 'contact.dart';
import 'Feedback.dart';
import 'AppbarPages/booking.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final name = 'Nikhil Shrestha';
    final email = 'Nikhil2@gmail.com';
    final urlImage =
        'https://scontent.fktm14-1.fna.fbcdn.net/v/t39.30808-6/281720947_3119076631645892_7911258547258694923_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=BlZRQxoK3mIAX9F-ROX&_nc_ht=scontent.fktm14-1.fna&oh=00_AT_pTLYjxj4yPywmdNbOlsCoTsc4ipTIyML35waf9qrEHQ&oe=629DDCA2';

    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: ClipOval(
              child: Image.asset(
                "assets/images/image.png",
                height: 90.0,
                fit: BoxFit.cover,
              ),
            ),
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.green.shade900,
              indicatorWeight: 5,
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'Home'),
                Tab(icon: Icon(Icons.location_on_outlined), text: 'Events'),
                Tab(
                    icon: Icon(Icons.supervised_user_circle_rounded),
                    text: 'Challenge'),
                Tab(icon: Icon(Icons.people), text: 'Team'),
                Tab(icon: Icon(Icons.calendar_today), text: 'Booking'),
                // Tab(icon: Icon(Icons.food_bank), text: 'items'),
              ],
            ),
          ),

          // drawer here
          drawer: Drawer(
            child: Material(
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  buildHeader(
                    urlImage: urlImage,
                    name: name,
                    email: email,
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserPage(
                        name: 'Nikhil Shrestha',
                        urlImage: urlImage,
                      ),
                    )),
                  ),
                  Container(
                    padding: padding,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Home'),
                          leading: Icon(Icons.home),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NavigationDrawerWidget())),
                        ),
                        ListTile(
                          title: Text('feedback'),
                          leading: Icon(Icons.feedback_rounded),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Feedbacks())),
                        ),
                        ListTile(
                          title: Text('Contact Us'),
                          leading: Icon(Icons.settings),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => contact())),
                        ),
                        ListTile(
                          title: Text('New Registration'),
                          leading: Icon(Icons.person_add),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Registration())),
                        ),
                        ListTile(
                          title: Text('Logout'),
                          leading: Icon(Icons.logout),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage())),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Home_page(),
              Events(),
              Challenge_page(),
              TeamScreen(),
              Bookings()
            ],
          )),
    );
  }

// opens profile
  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.black;
    final hoverColor = Colors.blueGrey;

    return ListTile(
        leading: Icon(icon, color: color),
        title: Text(text, style: TextStyle(color: color)),
        hoverColor: hoverColor,
        onTap: onClicked);
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => peoplePage(),
        ));
        break;
    }
  }
}
