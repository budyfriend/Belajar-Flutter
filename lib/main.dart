// Timer
import 'dart:async';

import 'dart:math';
import 'dart:ui';

import 'package:first_project/api/post_result_model.dart';
import 'package:first_project/api/user_list_model.dart';
import 'package:first_project/api/user_model.dart';
import 'package:first_project/model/bloc_color.dart';
import 'package:first_project/model/color_bloc.dart';
import 'package:first_project/screen/aplication_color.dart';
import 'package:first_project/screen/cart.dart';
import 'package:first_project/screen/colorful_button.dart';
import 'package:first_project/screen/login_page.dart';
import 'package:first_project/screen/money.dart';
import 'package:first_project/screen/product_card.dart';
import 'package:first_project/screen/user_profile.dart';
import 'package:flutter/material.dart';

// QR Code
import 'package:qr_flutter/qr_flutter.dart';
// QR Scan
import 'package:qrscan/qrscan.dart' as scanner;
// Audio Player
import 'package:audioplayers/audioplayers.dart';
// Shared Preferences
import 'package:shared_preferences/shared_preferences.dart';
// Provider
import 'package:provider/provider.dart';
// BloC
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(LatihanCustomProgressBar());
}

class LatihanProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: firstColor,
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.topCenter,
            child: ProductCard(
              imageURL:
                  'https://jubi.co.id/wp-content/uploads/2020/06/Buah-jeruk-Tempo.co_.jpg',
              name: 'Buah Jeruk 1 Kg',
              price: 'Rp10.000,-',
              onAddCartTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}

class LatihanCustomProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom Progress Bar'),
        ),
        body: Center(
          child: ChangeNotifierProvider<TimeState>(
            // ignore: deprecated_member_use
            builder: (context) => TimeState(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer<TimeState>(
                  builder: (context, timeState, _) => CustomProgressBar(
                    width: 200,
                    value: timeState.time,
                    totalValue: 15,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Consumer<TimeState>(
                  builder: (context, timeState, _) => RaisedButton(
                    textColor: Colors.white,
                    color: Colors.lightBlue,
                    child: Text('Start'),
                    onPressed: () {
                      Timer.periodic(Duration(seconds: 1), (timer) {
                        if (timeState.time == 0)
                          timer.cancel();
                        else
                          timeState.time -= 1;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomProgressBar extends StatelessWidget {
  final double width;
  final int value;
  final int totalValue;

  CustomProgressBar({this.width, this.value, this.totalValue});

  @override
  Widget build(BuildContext context) {
    double ratio = value / totalValue;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.timer, color: Colors.grey[700]),
        SizedBox(
          width: 5,
        ),
        Stack(
          children: [
            Container(
              width: width,
              height: 10,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5)),
            ),
            Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(5),
              child: AnimatedContainer(
                height: 10,
                width: width * ratio,
                duration: Duration(milliseconds: 500),
                decoration: BoxDecoration(
                    color: (ratio < 0.3)
                        ? Colors.red
                        : (ratio < 0.6)
                            ? Colors.amber[400]
                            : Colors.lightGreen,
                    borderRadius: BorderRadius.circular(5)),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class TimeState with ChangeNotifier {
  int _time = 15;
  int get time => _time;
  set time(int newTime) {
    _time = newTime;
    notifyListeners();
  }
}

class LatihanTimer extends StatefulWidget {
  @override
  _LatihanTimerState createState() => _LatihanTimerState();
}

class _LatihanTimerState extends State<LatihanTimer> {
  bool isStop = true;
  bool isBlack = true;
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Timer Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                counter.toString(),
                style: TextStyle(
                    color: (isBlack) ? Colors.black : Colors.red,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  Timer(Duration(seconds: 5), () {
                    setState(() {
                      isBlack = !isBlack;
                    });
                  });
                },
                child: Text('Ubah warna 5 detik kemudian'),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  Timer.run(() {
                    setState(() {
                      isBlack = !isBlack;
                    });
                  });
                },
                child: Text('Ubah warna secara langsung'),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  counter = 0;
                  isStop = false;
                  Timer.periodic(Duration(seconds: 1), (timer) {
                    if (isStop) timer.cancel();
                    setState(() {
                      counter++;
                    });
                  });
                },
                child: Text('Start timer'),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  isStop = true;
                },
                child: Text('Stop timer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LatihanDocComment extends StatelessWidget {
  final UserProfile profile = UserProfile(
    name: 'Budyfriend',
    role: 'Programmer',
    photoURL: null,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Doc Comment Example'),
        backgroundColor: Colors.red[900],
      ),
      body: Center(child: profile),
    ));
  }
}

class LatihanFlutterBlocDenganLibrary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<ColorBlocs>(
          builder: (context) => ColorBlocs(), child: MainBlocPage()),
    );
  }
}

class MainBlocPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ColorBlocs bloc = BlocProvider.of<ColorBlocs>(context);

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: () {
                bloc.dispatch(ColorEvents.to_amber);
              }),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
              backgroundColor: Colors.lightBlue,
              onPressed: () {
                bloc.dispatch(ColorEvents.to_light_blue);
              })
        ],
      ),
      appBar: AppBar(
        title: Text('BLoC dengan flutter_bloc'),
      ),
      body: Center(
        // ignore: missing_required_param
        child: BlocBuilder<ColorBlocs, Color>(
          builder: (context, curentColor) => AnimatedContainer(
            width: 100,
            height: 100,
            color: curentColor,
            duration: Duration(seconds: 500),
          ),
        ),
      ),
    );
  }
}

class LatihanBLoCStateManagementTanpaLibrary extends StatefulWidget {
  @override
  _LatihanBLoCStateManagementTanpaLibraryState createState() =>
      _LatihanBLoCStateManagementTanpaLibraryState();
}

class _LatihanBLoCStateManagementTanpaLibraryState
    extends State<LatihanBLoCStateManagementTanpaLibrary> {
  ColorBloc bloc = ColorBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                onPressed: () {
                  bloc.eventSink.add(ColorEvent.to_amber);
                },
                backgroundColor: Colors.amber),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
                onPressed: () {
                  bloc.eventSink.add(ColorEvent.to_light_blue);
                },
                backgroundColor: Colors.lightBlue),
          ],
        ),
        appBar: AppBar(
          title: Text('BLoC tanpa Library'),
        ),
        body: Center(
          child: StreamBuilder(
            stream: bloc.stateStream,
            initialData: Colors.amber,
            builder: (context, snapshot) {
              return AnimatedContainer(
                duration: Duration(seconds: 500),
                width: 100,
                height: 100,
                color: snapshot.data,
              );
            },
          ),
        ),
      ),
    );
  }
}

class LatihanMultiProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          // ignore: missing_required_param
          ChangeNotifierProvider<Money>(
            // ignore: deprecated_member_use
            builder: (context) => Money(),
          ),
          // ignore: missing_required_param
          ChangeNotifierProvider<Cart>(
            // ignore: deprecated_member_use
            builder: (context) => Cart(),
          )
        ],
        child: Scaffold(
          floatingActionButton: Consumer<Money>(
            builder: (context, money, _) => Consumer<Cart>(
              builder: (context, cart, _) => FloatingActionButton(
                onPressed: () {
                  if (money.balance >= 500) {
                    cart.quantity += 1;
                    money.balance -= 500;
                  }
                },
                child: Icon(Icons.add_shopping_cart),
                backgroundColor: Colors.purple,
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Text('Multi Provider'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Balance'),
                    Container(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Consumer<Money>(
                          builder: (context, money, _) => Text(
                              money.balance.toString(),
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                      height: 30,
                      width: 150,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.purple[100],
                          border: Border.all(color: Colors.purple, width: 2)),
                    )
                  ],
                ),
                Container(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Consumer<Cart>(
                      builder: (context, cart, _) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Apple (500) x ' + cart.quantity.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          Text((500 * cart.quantity).toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                  height: 30,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black, width: 2)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LatihanProviderStateManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: missing_required_param
      home: ChangeNotifierProvider<AplicationColor>(
        // ignore: deprecated_member_use
        builder: (context) => AplicationColor(),
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.black,
              title: Consumer<AplicationColor>(
                builder: (context, aplicationColor, _) => Text(
                  'Provider State Management',
                  style: TextStyle(
                    color: aplicationColor.color,
                  ),
                ),
              )),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<AplicationColor>(
                  builder: (context, aplicationColor, _) => AnimatedContainer(
                    margin: EdgeInsets.all(5),
                    duration: Duration(milliseconds: 500),
                    width: 100,
                    height: 100,
                    color: aplicationColor.color,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(margin: EdgeInsets.all(5), child: Text('AB')),
                    Consumer<AplicationColor>(
                        builder: (context, aplicationColor, _) => Switch(
                            value: aplicationColor.isLightBlue,
                            onChanged: (newValue) {
                              aplicationColor.isLightBlue = newValue;
                            })),
                    Container(margin: EdgeInsets.all(5), child: Text('LB')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LatihanSharedPreferences extends StatefulWidget {
  @override
  _LatihanSharedPreferencesState createState() =>
      _LatihanSharedPreferencesState();
}

class _LatihanSharedPreferencesState extends State<LatihanSharedPreferences> {
  TextEditingController txtControler = TextEditingController(text: 'No Name');
  bool isON = false;

  void saveData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("nama", txtControler.text);
    pref.setBool("ison", isON);
  }

  Future<String> getNama() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("nama") ?? "No Name";
  }

  Future<bool> getON() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("ison") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Shared Preference Example'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: txtControler,
            ),
            Switch(
                value: isON,
                onChanged: (newValue) {
                  setState(() {
                    isON = newValue;
                  });
                }),
            RaisedButton(
              onPressed: () {
                saveData();
              },
              child: Text('Save'),
            ),
            RaisedButton(
              onPressed: () {
                getNama().then((s) {
                  txtControler.text = s;
                  setState(() {});
                });
                getON().then((b) {
                  isON = b;
                  setState(() {});
                });
              },
              child: Text('Load'),
            )
          ],
        ),
      ),
    );
  }
}

class LatihanAnimatedPadding extends StatefulWidget {
  @override
  _LatihanAnimatedPaddingState createState() => _LatihanAnimatedPaddingState();
}

class _LatihanAnimatedPaddingState extends State<LatihanAnimatedPadding> {
  double myPadding = 5;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animated Padding'),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: AnimatedPadding(
                          duration: Duration(seconds: 1),
                          padding: EdgeInsets.all(myPadding),
                          child: Container(color: Colors.red))),
                  Flexible(
                      flex: 1,
                      child: AnimatedPadding(
                          duration: Duration(seconds: 1),
                          padding: EdgeInsets.all(myPadding),
                          child: Container(color: Colors.green)))
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: AnimatedPadding(
                          duration: Duration(seconds: 1),
                          padding: EdgeInsets.all(myPadding),
                          child: Container(color: Colors.blue))),
                  Flexible(
                      flex: 1,
                      child: AnimatedPadding(
                          duration: Duration(seconds: 1),
                          padding: EdgeInsets.all(myPadding),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  myPadding = 20;
                                });
                              },
                              child: Container(color: Colors.yellow))))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LathianAnimatedShitcher extends StatefulWidget {
  @override
  _LathianAnimatedShitcherState createState() =>
      _LathianAnimatedShitcherState();
}

class _LathianAnimatedShitcherState extends State<LathianAnimatedShitcher> {
  bool isON = false;
  Widget myWidget = Container(
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.red,
        border: Border.all(color: Colors.black, width: 3),
      ));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animated Switcher'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimatedSwitcher(
                duration: Duration(seconds: 1),
                transitionBuilder: (child, animation) => RotationTransition(
                  turns: animation,
                  child: child,
                ),

                // ScaleTransition(
                //   scale: animation,
                //   child: child,
                // ),
                child: myWidget,
              ),
              Switch(
                  activeColor: Colors.green,
                  inactiveThumbColor: Colors.red,
                  inactiveTrackColor: Colors.red[200],
                  value: isON,
                  onChanged: (newValue) {
                    isON = newValue;
                    setState(() {
                      if (isON)
                        myWidget = Container(
                            // jika menggunakan widget sama maka gunakan key pada container
                            key: ValueKey(1),
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(color: Colors.black, width: 3),
                            ));
                      // SizedBox(
                      //   width: 200,
                      //   height: 100,
                      //   child: Center(
                      //     child: Text(
                      //       'Switch : ON',
                      //       style: TextStyle(
                      //           color: Colors.green,
                      //           fontWeight: FontWeight.w700,
                      //           fontSize: 20),
                      //     ),
                      //   ),
                      // );
                      else
                        myWidget = Container(
                            key: ValueKey(2),
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(color: Colors.black, width: 3),
                            ));
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class KoneksiAPIList extends StatefulWidget {
  @override
  _KoneksiAPIListState createState() => _KoneksiAPIListState();
}

class _KoneksiAPIListState extends State<KoneksiAPIList> {
  String output = 'no data';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Demo API List'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(output),
              RaisedButton(
                onPressed: () {
                  UserList.getListUser("2").then((users) {
                    output = '';
                    for (int i = 0; i < users.length; i++) {
                      output += '[ ' + users[i].name + ' ] ';
                      setState(() {});
                    }
                  });
                },
                child: Text('GET'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class KoneksiAPI extends StatefulWidget {
  @override
  _KoneksiAPIState createState() => _KoneksiAPIState();
}

class _KoneksiAPIState extends State<KoneksiAPI> {
  PostResult postResult = null;
  User user = null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('API Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text((user != null)
                  ? "GET : " + user.id + " | " + user.name
                  : "Tidak ada data GET"),
              Text((postResult != null)
                  ? "POST : " +
                      postResult.id +
                      " | " +
                      postResult.name +
                      " | " +
                      postResult.job +
                      " | " +
                      postResult.created
                  : "Tidak ada data POST"),
              RaisedButton(
                onPressed: () {
                  User.connectToAPI("3").then((value) {
                    user = value;
                    setState(() {});
                  });
                },
                child: Text('GET'),
              ),
              RaisedButton(
                onPressed: () {
                  PostResult.connectToAPI("Budiono", "Programmer")
                      .then((value) {
                    postResult = value;
                    setState(() {});
                  });
                },
                child: Text('POST'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LatihanClipPath extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Custom Clipper'),
        ),
        body: Center(
          child: ClipPath(
            clipper: MyClipperss(),
            child: Image(
              width: 300,
              image: NetworkImage(
                  'https://image.freepik.com/free-photo/rice-field-with-sunrise-sunset-moning-light_37803-387.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipperss extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height * 0.75, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class LatihanFontFeatures extends StatefulWidget {
  @override
  LatihanFontFeaturesState createState() => LatihanFontFeaturesState();
}

class LatihanFontFeaturesState extends State<LatihanFontFeatures> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Font Features'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Contoh 01 (Tanpa Apapun)',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Contoh 02 (Small Caps)',
                style: TextStyle(
                    fontSize: 20, fontFeatures: [FontFeature.enable('smcp')]),
              ),
              Text(
                'Contoh 1/2 (Small Caps & Frac)',
                style: TextStyle(fontSize: 20, fontFeatures: [
                  FontFeature.enable('smcp'),
                  FontFeature.enable('frac')
                ]),
              ),
              Text(
                'Contoh GilmerBold 19 (Tanpa Apapun)',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "GilmerBold",
                ),
              ),
              Text(
                'Contoh GilmerBold 19 (Old Style)',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "GilmerBold",
                    fontFeatures: [FontFeature.oldstyleFigures()]),
              ),
              Text(
                'Contoh GilmerBold (Style set no 5)',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "GilmerBold",
                    fontFeatures: [FontFeature.stylisticSet(5)]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Lewat tutorial
class LatihanQRScan extends StatefulWidget {
  @override
  _LatihanQRScanState createState() => _LatihanQRScanState();
}

class _LatihanQRScanState extends State<LatihanQRScan> {
  String text = 'Hasil QR Scan';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('QR Scan'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () async {
                  text = await scanner.scan();
                  setState(() {});
                },
                child: Text('Scan'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LatihanAudioPlayers extends StatefulWidget {
  @override
  _LatihanAudioPlayersState createState() => _LatihanAudioPlayersState();
}

class _LatihanAudioPlayersState extends State<LatihanAudioPlayers> {
  AudioPlayer audioPlayer;
  String durasi = '00:00:00';

  _LatihanAudioPlayersState() {
    audioPlayer = AudioPlayer();
    audioPlayer.onAudioPositionChanged.listen((duration) {
      setState(() {
        durasi = duration.toString();
      });
    });
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);
  }

  void playSound(String url) async {
    await audioPlayer.seek(Duration(seconds: 30));
    await audioPlayer.play(url);
  }

  void pauseSound() async {
    await audioPlayer.pause();
  }

  void stopSound() async {
    await audioPlayer.stop();
  }

  void resumeSound() async {
    audioPlayer.resume();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Audio Player'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                  onPressed: () {
                    playSound(
                        'http://23.237.126.42/ost/top-gear-2-sega-genesis/yzcalloe/01_Title%20Theme.mp3');
                  },
                  child: Text('Play')),
              RaisedButton(
                  onPressed: () {
                    pauseSound();
                  },
                  child: Text('Pause')),
              RaisedButton(
                  onPressed: () {
                    stopSound();
                  },
                  child: Text('Stop')),
              RaisedButton(
                  onPressed: () {
                    resumeSound();
                  },
                  child: Text('Resume')),
              Text(
                durasi,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TransparansiBergaradasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gradient Opacity'),
        ),
        body: Center(
          child: ShaderMask(
            shaderCallback: (rectangle) {
              return LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)
                  .createShader(
                      Rect.fromLTRB(0, 0, rectangle.width, rectangle.height));
            },
            blendMode: BlendMode.dstIn,
            child: Image(
              width: 300,
              image: NetworkImage(
                  'https://leanature.com/wp-content/uploads/2015/09/Slide_g%C3%A9n%C3%A9rique_Groupe.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonBelahKetupatWarnaWarni extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Colorful Buttons'),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ColorfulButton(Colors.pink, Colors.blue, Icons.adb),
              ColorfulButton(Colors.amber, Colors.red, Icons.comment),
              ColorfulButton(Colors.green, Colors.purple, Icons.computer),
              ColorfulButton(Colors.blue, Colors.yellow, Icons.contact_phone),
            ],
          ),
        ),
      ),
    );
  }
}

class LatihanQRCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('QR Code'),
        ),
        body: Center(
          child: QrImage(
            version: 6,
            backgroundColor: Colors.grey,
            foregroundColor: Colors.black,
            errorCorrectionLevel: QrErrorCorrectLevel.M,
            padding: EdgeInsets.all(30),
            size: 300,
            data: "https://www.youtube.com/channel/UCrslWTodjjzWzqQldDfYYNQ",
          ),
        ),
      ),
    );
  }
}

class MainPageTabBar2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TabBar myTabBar = TabBar(
      // indicatorColor: Colors.red,
      indicator: BoxDecoration(
          color: Colors.red,
          border: Border(top: BorderSide(color: Colors.purple, width: 5))),
      tabs: [
        Tab(
          icon: Icon(Icons.comment),
          text: 'Comment',
        ),
        Tab(
          icon: Icon(
            Icons.computer,
          ),
          text: 'Computer',
        )
      ],
    );

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: Text('Contoh Tab Bar'),
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(myTabBar.preferredSize.height),
                  child: Container(color: Colors.amber, child: myTabBar))),
          body: TabBarView(
            children: [
              Center(
                child: Text('Tab 1'),
              ),
              Center(
                child: Text('Tab 2'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainPageTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Contoh Tab Bar'),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.comment),
                  text: 'Comment',
                ),
                Tab(
                  child: Image(
                    image: AssetImage("images/landing-build-products.jpg"),
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.computer,
                  ),
                ),
                Tab(
                  text: 'News',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Text('Tab 1'),
              ),
              Center(
                child: Text('Tab 2'),
              ),
              Center(
                child: Text('Tab 3'),
              ),
              Center(
                child: Text('Tab 4'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBarHight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(200),
          child: AppBar(
            backgroundColor: Colors.amber,
            flexibleSpace: Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  'Appbar with custom heights',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCardDenganCorak extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPageHeroClipRRect(),
    );
  }
}

class MainPageHeroClipRRect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Latihan Hero Animation',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SecondPageClipRRect();
          }));
        },
        child: Hero(
          tag: 'pp',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 100,
              height: 100,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://budyfriendcode.files.wordpress.com/2020/05/cropped-iconnew.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondPageClipRRect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Latihan Hero Animation',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Hero(
          tag: 'pp',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              width: 200,
              height: 200,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://budyfriendcode.files.wordpress.com/2020/05/cropped-iconnew.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainPageCustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Custom Card Example',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF8C062F),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFFE5788), Color(0xFFF56D5D)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
          ),
          Center(
              child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Card(
              elevation: 10,
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.7,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQvg0coMpSm1vcJaUNCpiYAqkdOVbpxCMnqhw&usqp=CAU"),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4)),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://image.freepik.com/free-photo/rice-field-with-sunrise-sunset-moning-light_37803-387.jpg"),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        20,
                        50 + (MediaQuery.of(context).size.height * 0.35),
                        20,
                        20),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Beautyful Sunset at Paddy Field',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFFF56D5D), fontSize: 25),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Posted on ',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                Text(
                                  'June 18, 2019',
                                  style: TextStyle(
                                      color: Color(0xFFF56D5D), fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Spacer(
                                flex: 10,
                              ),
                              Icon(
                                Icons.thumb_up,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Text(
                                '99',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Spacer(
                                flex: 5,
                              ),
                              Icon(
                                Icons.comment,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Text(
                                '888',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Spacer(
                                flex: 10,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class GradasiButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gradasi Button'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                onPressed: () {},
                shape: StadiumBorder(),
                child: Text('Raised Button'),
                color: Colors.amber,
              ),
              Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 2,
                child: Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [Colors.purple, Colors.pink],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {},
                      child: Center(
                          child: Text(
                        'My Button',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LatihanMediaQuerys extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPageMediaQuery(),
    );
  }
}

class MainPageMediaQuery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Latihan Media Query'),
        ),
        body: (MediaQuery.of(context).orientation == Orientation.portrait)
            ? Column(
                children: generatedContainers(),
              )
            : Row(
                children: generatedContainers(),
              ));
  }

  List<Widget> generatedContainers() {
    return [
      Container(
        color: Colors.red,
        width: 100,
        height: 100,
      ),
      Container(
        color: Colors.green,
        width: 100,
        height: 100,
      ),
      Container(
        color: Colors.blue,
        width: 100,
        height: 100,
      )
    ];
  }
}

class LatihanTextFields extends StatefulWidget {
  @override
  _LatihanTextFieldsState createState() => _LatihanTextFieldsState();
}

class _LatihanTextFieldsState extends State<LatihanTextFields> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Text Field'),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                // obscureText: true,
                decoration: InputDecoration(
                    // icon: Icon(Icons.person),
                    // jika menggunakan prefix maka prefixText dan prefixStyle jangan digunakan
                    suffix: Container(
                      width: 5,
                      height: 5,
                      color: Colors.red,
                    ),
                    fillColor: Colors.lightBlue[50],
                    filled: true,
                    prefixIcon: Icon(Icons.person),
                    prefixText: "Name : ",
                    prefixStyle: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w600),
                    labelText: "Nama Lengkap",
                    hintText: "Username",
                    hintStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                maxLength: 5,
                onChanged: (value) {
                  setState(() {});
                },
                controller: controller,
              ),
              Text(controller.text)
            ],
          ),
        ),
      ),
    );
  }
}

class CardViews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green,
        body: Container(
          margin: EdgeInsets.all(10),
          child: ListView(
            children: [
              buildCard(Icons.account_box, "Account Box"),
              buildCard(Icons.person, "Users")
            ],
          ),
        ),
      ),
    );
  }

  Card buildCard(IconData iconData, String text) {
    return Card(
      elevation: 5,
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.all(5),
              child: Icon(iconData, color: Colors.green)),
          Text(text)
        ],
      ),
    );
  }
}

class AppBarGradasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.adb,
          color: Colors.white,
        ),
        title: Text(
          'AppBar Example',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: () {}),
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {})
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff0096ff), Color(0xff6610f2)],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight),
              image: DecorationImage(
                  image: AssetImage("images/patern.png"),
                  fit: BoxFit.none,
                  repeat: ImageRepeat.repeat)),
        ),
      ),
    ));
  }
}

class NavigasiMultiPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage());
  }
}

class Draggables extends StatefulWidget {
  @override
  _DraggablesState createState() => _DraggablesState();
}

class _DraggablesState extends State<Draggables> {
  Color color1 = Colors.red;
  Color color2 = Colors.amber;
  Color targetColor;
  bool isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Latihan Draggable'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Draggable<Color>(
                  data: color1,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Material(
                      color: color1,
                      shape: StadiumBorder(),
                      elevation: 3,
                    ),
                  ),
                  childWhenDragging: SizedBox(
                    width: 50,
                    height: 50,
                    child: Material(
                      color: Colors.grey,
                      shape: StadiumBorder(),
                    ),
                  ),
                  feedback: SizedBox(
                    width: 50,
                    height: 50,
                    child: Material(
                      color: color1.withOpacity(0.7),
                      shape: StadiumBorder(),
                      elevation: 3,
                    ),
                  ),
                ),
                Draggable<Color>(
                  data: color2,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Material(
                      color: color2,
                      shape: StadiumBorder(),
                      elevation: 3,
                    ),
                  ),
                  childWhenDragging: SizedBox(
                    width: 50,
                    height: 50,
                    child: Material(
                      color: Colors.grey,
                      shape: StadiumBorder(),
                    ),
                  ),
                  feedback: SizedBox(
                    width: 50,
                    height: 50,
                    child: Material(
                      color: color2.withOpacity(0.7),
                      shape: StadiumBorder(),
                      elevation: 3,
                    ),
                  ),
                )
              ],
            ),
            DragTarget<Color>(
              onWillAccept: (value) => true,
              onAccept: (value) {
                isAccepted = true;
                targetColor = value;
              },
              builder: (context, candidates, rejected) {
                return (isAccepted)
                    ? SizedBox(
                        width: 100,
                        height: 100,
                        child: Material(
                          color: targetColor,
                          shape: StadiumBorder(),
                        ),
                      )
                    : SizedBox(
                        width: 100,
                        height: 100,
                        child: Material(
                          color: Colors.black26,
                          shape: StadiumBorder(),
                        ),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}

class Spacers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Latihan Spacer'),
        ),
        body: Center(
          child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(
                flex: 1,
              ),
              Container(
                width: 80,
                height: 80,
                color: Colors.red,
              ),
              Spacer(
                flex: 2,
              ),
              Container(
                width: 80,
                height: 80,
                color: Colors.green,
              ),
              Spacer(
                flex: 3,
              ),
              Container(
                width: 80,
                height: 80,
                color: Colors.blue,
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LatihanImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Latihan Image'),
        ),
        body: Center(
          child: Container(
            color: Colors.black,
            width: 200,
            height: 200,
            padding: EdgeInsets.all(3),
            child: Image(
              image: AssetImage("images/landing-build-products.jpg"),
// image: NetworkImage(
//     'https://miro.medium.com/max/1000/1*JbDo7U0l62vYMfm1WxnA1g.png'),
              fit: BoxFit.contain,
              repeat: ImageRepeat.repeat,
            ),
          ),
        ),
      ),
    );
  }
}

class StackAndAlign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Stack and Align'),
        ),
        body: Stack(
          children: [
// background
            Column(
              children: [
                Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Flexible(
                            flex: 1,
                            child: Container(
                              color: Colors.white,
                            )),
                        Flexible(
                            flex: 1,
                            child: Container(
                              color: Colors.black12,
                            ))
                      ],
                    )),
                Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Flexible(
                            flex: 1,
                            child: Container(
                              color: Colors.black12,
                            )),
                        Flexible(
                            flex: 1,
                            child: Container(
                              color: Colors.white,
                            ))
                      ],
                    ))
              ],
            ),

// listview dengan text

            ListView(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Ini adalah text yang ada di lapisan tengah dari stack',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Ini adalah text yang ada di lapisan tengah dari stack',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Ini adalah text yang ada di lapisan tengah dari stack',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Ini adalah text yang ada di lapisan tengah dari stack',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Ini adalah text yang ada di lapisan tengah dari stack',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Ini adalah text yang ada di lapisan tengah dari stack',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Ini adalah text yang ada di lapisan tengah dari stack',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'Ini adalah text yang ada di lapisan tengah dari stack',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                )
              ],
            ),
// button di tengah bawah
            Align(
// x = -1, 0, 1 (kiri - kanan)
// y = -1, 0, 1 (atas - bawah)

              alignment: Alignment(0.8, 0.9),
              child: RaisedButton(
                onPressed: () {},
                child: Text('My Button'),
                color: Colors.amber,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Flexibles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flexibel Layout'),
        ),
        body: Column(
          children: [
            Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          color: Colors.red,
                        )),
                    Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          color: Colors.green,
                        )),
                    Flexible(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          color: Colors.purple,
                        )),
                  ],
                )),
            Flexible(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.all(5),
                  color: Colors.amber,
                )),
            Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(5),
                  color: Colors.blue,
                ))
          ],
        ),
      ),
    );
  }
}

class AnimatedContainers extends StatefulWidget {
  @override
  _AnimatedContainersState createState() => _AnimatedContainersState();
}

class _AnimatedContainersState extends State<AnimatedContainers> {
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animated Container'),
        ),
        body: Center(
          child: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: AnimatedContainer(
              color: Color.fromARGB(255, random.nextInt(256),
                  random.nextInt(256), random.nextInt(256)),
              duration: Duration(seconds: 1),
              width: 50.0 + random.nextInt(101),
              height: 50.0 + random.nextInt(101),
            ),
          ),
        ),
      ),
    );
  }
}

class StyleTexts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Text Style'),
        ),
        body: Center(
          child: Text(
            'Ini adalah text',
            style: TextStyle(
                fontFamily: "GilmerBold",
                fontSize: 30,
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
                decorationThickness: 5,
                decorationStyle: TextDecorationStyle.wavy),
          ),
        ),
      ),
    );
  }
}

class ListViews extends StatefulWidget {
  @override
  _ListViewsState createState() => _ListViewsState();
}

class _ListViewsState extends State<ListViews> {
  List<Widget> widgets = [];
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Latihan ListView')),
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      widgets.add(Text(
                        "Data ke-" + counter.toString(),
                        style: TextStyle(fontSize: 35),
                      ));
                      counter++;
                    });
                  },
                  child: Text('Tambah Data'),
                ),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      widgets.removeLast();
                      counter--;
                    });
                  },
                  child: Text('Hapus Data'),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widgets,
            )
          ],
        ),
      ),
    );
  }
}

class AnonymousMethod extends StatefulWidget {
  @override
  _AnonymousMethodState createState() => _AnonymousMethodState();
}

class _AnonymousMethodState extends State<AnonymousMethod> {
  String message = "Ini adalah Text";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Anonymous Method'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    message = "Tombol sudah ditekan";
                  });
                },
                child: Text('Tekan Saya'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StatefullWidgetLatihan extends StatefulWidget {
  @override
  _StatefullWidgetLatihanState createState() => _StatefullWidgetLatihanState();
}

class _StatefullWidgetLatihanState extends State<StatefullWidgetLatihan> {
  int number = 0;
  void tekanTombol() {
    setState(() {
      number += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Statefull Widget Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number.toString(),
                style: TextStyle(fontSize: 10 + number.toDouble()),
              ),
              RaisedButton(
                child: Text('Tambah Bilangan'),
                onPressed: tekanTombol,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LatihanContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Latihan Container'),
        ),
        body: Container(
          color: Colors.red,
          margin: EdgeInsets.fromLTRB(10, 15, 20, 25),
          padding: EdgeInsets.only(bottom: 20, top: 20),
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.amber, Colors.blue])),
          ),
        ),
      ),
    );
  }
}

class ColumnAndRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Latihan Row dan Column'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Text 1'),
            Text('Text 2'),
            Text('Text 3'),
            Row(
              children: [Text('Text 4'), Text('Text 5'), Text('Text 6')],
            )
          ],
        ),
      ),
    );
  }
}

class LatihanHelloWord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Aplikasi Hello Word'),
        ),
        body: Center(
            child: Container(
                color: Colors.lightBlue,
                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  'Saya sedang melatih kemampuan saya dengan belajar flutter',
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ))),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
