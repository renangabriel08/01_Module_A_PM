import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ma/controllers/app.dart';
import 'package:ma/pages/diaries.dart';
import 'package:ma/pages/profile.dart';
import 'package:ma/pages/travel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  startApp() async {
    String json = await rootBundle.loadString(
      'assets/data/location_map_data.json',
    );

    App.map = jsonDecode(json);
    await App.getDiarios();
    setState(() {});
  }

  @override
  void initState() {
    startApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ValueListenableBuilder(
      valueListenable: App.page,
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: Text(
            value == 0
                ? 'Diaries'
                : value == 1
                ? 'Popular Locations'
                : 'Profile',
          ),
        ),
        body: SizedBox(
          width: width,
          height: height,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                width: width * .2,
                height: height,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/art_icon_la_tour_eiffel.png',
                            height: 50,
                          ),
                          Container(width: 16),
                          Text('My France', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Container(height: 32),
                      ListTile(
                        title: Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: value == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: value == 0 ? Colors.blue : Colors.black,
                          ),
                        ),
                        leading: Icon(
                          Icons.home,
                          color: value == 0 ? Colors.blue : Colors.black,
                        ),
                        onTap: () => App.page.value = 0,
                      ),
                      Divider(),
                      Container(height: 16),
                      ListTile(
                        title: Text(
                          'Travel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: value == 1
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: value == 1 ? Colors.blue : Colors.black,
                          ),
                        ),
                        leading: Icon(
                          Icons.map,
                          color: value == 1 ? Colors.blue : Colors.black,
                        ),
                        onTap: () => App.page.value = 1,
                      ),
                      Divider(),
                      Container(height: 16),
                      ListTile(
                        title: Text(
                          'Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: value == 2
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: value == 2 ? Colors.blue : Colors.black,
                          ),
                        ),
                        leading: Icon(
                          Icons.account_circle_outlined,
                          color: value == 2 ? Colors.blue : Colors.black,
                        ),
                        onTap: () => App.page.value = 2,
                      ),
                      Divider(),
                      Container(height: 16),
                    ],
                  ),
                ),
              ),

              SizedBox(
                width: width * .8,
                height: height,
                child: App.diaries.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : IndexedStack(
                        index: value,
                        children: [Diaries(), Travel(), Profile()],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
