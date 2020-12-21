import 'package:flutter/material.dart';
import 'package:flutter_scan_bluetooth_example/Landing/calender.dart';
import 'package:flutter_scan_bluetooth_example/Landing/help.dart';
import 'package:flutter_scan_bluetooth_example/Landing/home.dart';
import 'package:flutter_scan_bluetooth_example/Landing/profile.dart';
import 'package:flutter_scan_bluetooth_example/Self-assess/selfassess_content.dart';

import 'EventCalender.dart';

class Tab_Bar extends StatefulWidget {
  final Widget child;
  Tab_Bar({Key key, this.child}) : super(key: key);

  // final String value;
  // Tab_Bar({Key key, this.value}) : super(key: key);

  @override
  _Tab_BarState createState() => _Tab_BarState();
}

Color PrimaryColor = Color(0xff109618);

class _Tab_BarState extends State<Tab_Bar> {
  TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: PrimaryColor,
            title: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Appbar(),
            ),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 6.0,
              onTap: (index) {
                setState(() {
                  switch (index) {
                    case 0:
                      PrimaryColor =
                          Color.alphaBlend(Colors.green, Colors.green);
                      break;
                    case 1:
                      PrimaryColor =
                          Color.alphaBlend(Colors.green, Colors.green);
                      break;
                    case 2:
                      PrimaryColor =
                          Color.alphaBlend(Colors.green, Colors.green);
                      break;
                    case 3:
                      PrimaryColor =
                          Color.alphaBlend(Colors.green, Colors.green);
                      break;
                    case 4:
                      PrimaryColor =
                          Color.alphaBlend(Colors.green, Colors.green);
                      break;
                    default:
                  }
                });
              },
              tabs: <Widget>[
                Tab(
                  child: Container(
                    child: Text(
                      'HOME',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'STATS',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'SELF-ASSESSMENT',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'CALENDER',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'SANITIZATION',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Home(0x87938f), //ff5722
              HelpContent(0x87938f), //2196f3 //4CAF50
              SelfAssessContent(0x87938f), //e91e63
              EventCalendar(), //9c27b0
              Profile(0x87938f), //3f51b5
              
            ],
          )),
    );
  }

  Widget Appbar() {
    return Container(
      //color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Container(
          //   child: IconButton(
          //     onPressed: null,
          //     icon: Icon(FontAwesomeIcons.handHoldingHeart),
          //   ),
          // ),
          Container(
            child: Text(
              'Salutem',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Avenir',
                fontWeight: FontWeight.bold,
                fontSize: 35.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
