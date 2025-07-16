import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:ma/controllers/app.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();
  bool obscureText = true;
  bool emailValido = true;
  bool senhaValido = true;
  bool logando = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width,
      height: height,
      child: Row(
        children: [
          if (App.user == null)
            SizedBox(
              width: width * .4,
              height: height,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/icons/icon_account_circle_outline.png',
                      height: 130,
                    ),
                    Container(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width * .2, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () => setState(() {
                        logando = !logando;
                      }),
                      child: Text(
                        'Join us now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(height: 16),
                    Text(
                      'to discover more sights of France',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            )
          else
            SizedBox(
              width: width * .4,
              height: height,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/icons/icon_account_circle_outline.png',
                      height: 130,
                    ),
                    Container(height: 16),
                    Text(
                      App.user!['user']['email'].toString().substring(
                        0,
                        App.user!['user']['email'].toString().indexOf('@'),
                      ),
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width * .2, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () => setState(() {
                        logando = !logando;
                        App.user = null;
                        email.clear();
                        senha.clear();
                      }),
                      child: Text(
                        'Sign out',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(height: 16),
                    Text(
                      'to change the other account',
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          '${App.favorites.length.toString().padLeft(2, '0')}\nFavorites',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (App.user == null && logando)
            SizedBox(
              width: width * .4,
              height: height,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Sign in/up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(height: 16),
                    TextFormField(
                      controller: email,
                      onChanged: (value) {
                        if (email.text.contains('@') &&
                            (email.text.indexOf('@') == 0 ||
                                email.text.lastIndexOf('@') ==
                                    email.text.length - 1)) {
                          emailValido = false;
                        } else if ((!email.text.contains('.com') &&
                                !email.text.contains('.com.br')) ||
                            !email.text.contains('@')) {
                          emailValido = false;
                        } else {
                          emailValido = true;
                        }

                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: 'Your E-mail Address',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    if (!emailValido)
                      Row(
                        children: [
                          Text(
                            'Invalid E-mail',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    Container(height: 16),
                    TextFormField(
                      controller: senha,
                      obscureText: false,
                      onChanged: (value) {
                        if (senha.text.length < 6) {
                          senhaValido = false;
                        } else if ((!senha.text.contains(RegExp(r'[a-z]')) &&
                                !senha.text.contains(RegExp(r'[A-Z]'))) ||
                            !senha.text.contains(RegExp(r'[0-9]'))) {
                          senhaValido = false;
                        } else {
                          senhaValido = true;
                        }

                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: 'Your Password',
                        border: OutlineInputBorder(),
                        suffixIcon: GestureDetector(
                          onLongPress: () => setState(() {
                            obscureText = false;
                          }),
                          onLongPressEnd: (details) => setState(() {
                            obscureText = true;
                          }),
                          child: Icon(Icons.visibility),
                        ),
                      ),
                    ),
                    if (!senhaValido)
                      Row(
                        children: [
                          Text(
                            'Invalid Password',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    Container(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () async {
                        await App.logar(email.text, senha.text);

                        if (App.user != null) {
                          final player = AudioPlayer();
                          await player.play(
                            AssetSource('sound/sign_in_succes.mp3'),
                          );
                        }

                        setState(() {});
                      },
                      child: Text(
                        'Sign in/up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(height: 16),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'READ USER AGREEMENT',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationThickness: 3,
                          decorationColor: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else if (App.user == null && !logando)
            Container()
          else
            SizedBox(
              width: width * .4,
              height: height,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'My Favorites',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(height: 16),
                      for (var favorito in App.favorites)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: width * .4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 5,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: width * .25,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          favorito['diary_title'],
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(height: 2),
                                        Text(
                                          '${favorito['diary_upload_username']} - ${favorito['diary_upload_datetime']}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Container(height: 12),
                                        Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, seddoeiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamcolaborisnisi ut aliquip ex ea commodo consequat. Duis aute iruredolor inreprehenderit in voluptate velit esse cillum dolore eu fugiat nullapariatur. Excepteur sint occaecat cupidatat non proident, sunt inculpa qui officia deserunt mollit anim id est',
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * .09,
                                    height: width * .12,
                                    child: Image.asset(
                                      'assets/images/location_image/scene_${favorito['diary_image'].toString().substring(favorito['diary_image'].toString().lastIndexOf('/') + 1)}',
                                      fit: BoxFit.cover,
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
              ),
            ),
        ],
      ),
    );
  }
}
