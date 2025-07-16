import 'package:flutter/material.dart';
import 'package:ma/controllers/app.dart';
import 'package:url_launcher/url_launcher.dart';

class Travel extends StatefulWidget {
  const Travel({super.key});

  @override
  State<Travel> createState() => _TravelState();
}

class _TravelState extends State<Travel> {
  modal(local) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(local['location_name']),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Row(
            children: [
              Container(
                width: 250,
                child: Text(
                  local['location_introduction'],
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: Image.asset(
                      'assets/images/location_image/${local['location_scene_image']}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    child: Image.asset(
                      'assets/images/location_image/${local['location_map_image']}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await launchUrl(Uri.parse('https://www.google.com/maps'));
            },
            child: Text(
              'Go Now!',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
                decorationThickness: 3,
                decorationColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          SizedBox(
            width: width,
            height: height,
            child: InteractiveViewer(
              child: Image.asset(
                'assets/images/map_paris_city.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          for (var local in App.map)
            Transform.translate(
              offset: Offset(
                local['location_mark_x_y_of_map_image'][0] / 4,
                local['location_mark_x_y_of_map_image'][1] / 4,
              ),
              child: GestureDetector(
                onTap: () => modal(local),
                child: Image.asset(
                  'assets/icons/icon_map_marker.png',
                  height: 50,
                ),
              ),
            ),

          Positioned(
            bottom: 40,
            right: 40,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  ),
                ],
                borderRadius: BorderRadius.circular(999),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/icons/icon_download.png'),
              ),
            ),
          ),

          Positioned(
            bottom: 40 + 50 + 10,
            right: 40,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  ),
                ],
                borderRadius: BorderRadius.circular(999),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/icons/icon_draw.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
