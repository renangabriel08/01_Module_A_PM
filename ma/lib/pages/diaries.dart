import 'package:flutter/material.dart';
import 'package:ma/controllers/app.dart';
import 'package:ma/widgets/toast.dart';

class Diaries extends StatefulWidget {
  const Diaries({super.key});

  @override
  State<Diaries> createState() => _DiariesState();
}

class _DiariesState extends State<Diaries> {
  Map? diary;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height,
      child: Row(
        children: [
          SizedBox(
            width: width * .4,
            height: height,
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  for (var d in App.diaries)
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: GestureDetector(
                        onTap: () => setState(() {
                          diary = d;
                        }),
                        child: Container(
                          width: width * .16,
                          height: 360,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: diary == d ? Colors.red : Colors.black,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/location_image/scene_${d['diary_image'].toString().substring(d['diary_image'].toString().lastIndexOf('/') + 1)}',
                                ),
                                Text(
                                  d['diary_title'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(height: 8),
                                Text(
                                  d['diary_upload_username'],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: width * .4,
            height: height,
            child: diary == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.translate(
                          offset: Offset(-35, 0),
                          child: Stack(
                            children: [
                              Opacity(
                                opacity: .7,
                                child: Transform.translate(
                                  offset: Offset(70, -70),
                                  child: Image.asset(
                                    'assets/icons/art_icon_la_tour_eiffel.png',
                                  ),
                                ),
                              ),

                              Image.asset(
                                'assets/icons/art_icon_arc_de_triomphe.png',
                              ),
                            ],
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, 0),
                          child: Text(
                            'Welcome to French',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => setState(() {
                                diary = null;
                              }),
                              icon: Icon(Icons.close),
                            ),
                            IconButton(
                              onPressed: () async {
                                if (App.user == null) {
                                  MyToast.get('Please sign in');
                                } else {
                                  if (!App.ids.contains(diary!['diary_id'])) {
                                    await App.addFavorite(diary!['diary_id']);
                                  } else {
                                    // await App.removeFavorite(
                                    //   diary!['id'].toString(),
                                    // );
                                  }
                                }

                                setState(() {});
                              },
                              icon: Icon(
                                App.ids.contains(diary!['diary_id']) &&
                                        App.user != null
                                    ? Icons.star
                                    : Icons.star_outline,
                                color:
                                    App.ids.contains(diary!['diary_id']) &&
                                        App.user != null
                                    ? Colors.amber
                                    : Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () => setState(() {}),
                              icon: Icon(Icons.copy),
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/images/location_image/scene_${diary!['diary_image'].toString().substring(diary!['diary_image'].toString().lastIndexOf('/') + 1)}',
                          width: width,
                          height: height * .4,
                          fit: BoxFit.cover,
                        ),

                        Container(height: 16),
                        Text(
                          diary!['diary_title'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              diary!['diary_upload_username'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              diary!['diary_upload_datetime'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),

                        Container(height: 16),
                        SizedBox(
                          width: width,
                          height: height * .25,
                          child: SingleChildScrollView(
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, seddoeiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamcolaborisnisi ut aliquip ex ea commodo consequat. Duis aute iruredolor inreprehenderit in voluptate velit esse cillum dolore eu fugiat nullapariatur. Excepteur sint occaecat cupidatat non proident, sunt inculpa qui officia deserunt mollit anim id est\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, seddoeiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamcolaborisnisi ut aliquip ex ea commodo consequat. Duis aute iruredolor inreprehenderit in voluptate velit esse cillum dolore eu fugiat nullapariatur. Excepteur sint occaecat cupidatat non proident, sunt inculpa qui officia deserunt mollit anim id est ',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
