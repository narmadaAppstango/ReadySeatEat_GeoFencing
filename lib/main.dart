import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_seating_mobile_frontend/Core/app_export.dart';
import 'package:restaurent_seating_mobile_frontend/Core/utils/widgets/warning-dialogs.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/api-service-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/create-profile-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/email-verification-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/firebase_options.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/forget-password-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/get-reservation-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/get-restaurent-detailsProvider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/logout-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/make-reservation-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/sign-in-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Provider/sign-up-account-provider.dart';
import 'package:restaurent_seating_mobile_frontend/Screens/SplashScreen.dart';
import 'package:restaurent_seating_mobile_frontend/amplifyconfiguration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vector_math/vector_math.dart';
import 'Provider/shared-preference.dart';
import 'model/token-response-model.dart';

@pragma('vm:entry-point')
void backgroundCallback() {
  BackgroundLocationTrackerManager.handleBackgroundUpdated(
    (data) async => Repo().update(data),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message}');
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } else {
    await Firebase.initializeApp();
  }
}

AndroidNotificationChannel? channel;
late FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } else {
    await Firebase.initializeApp();
  }
  await BackgroundLocationTrackerManager.initialize(
    backgroundCallback,
    config: const BackgroundLocationTrackerConfig(
        loggingEnabled: true,
        androidConfig: AndroidConfig(
          notificationIcon: 'explore',
          trackingInterval: Duration(seconds: 4),
          distanceFilterMeters: null,
        ),
        iOSConfig: IOSConfig(
        activityType: ActivityType.FITNESS,
        distanceFilterMeters: null,
        restartAfterKill: true,
      ),
        ),
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.getInitialMessage();

  channel = const AndroidNotificationChannel(
      'Ready Seat Eat', // id
      'High Importance Notifications', // title
      // 'this iss', // description
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      // sound: RawResourceAndroidNotificationSound("default"),
      enableLights: true,
      showBadge: true);

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin!
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel!);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('++++++++Main.Dart+++++++++++ ' + message.data.toString());
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (Platform.isIOS) {
      final IOSInitializationSettings initializationSettingsIOS =
          IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        defaultPresentSound: true,
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        onDidReceiveLocalNotification: (id, title, body, payload) {},
        //   onDidReceiveLocalNotification: (
        //     int id,
        //     String title,
        //     String body,
        //     String payload,
        //   ) async {
        //     /* didReceiveLocalNotificationSubject.add(
        //   ReceivedNotification(
        //     id: id,
        //     title: title,
        //     body: body,
        //     payload: payload,
        //   ),
        // );*/
        //   }
      );
      flutterLocalNotificationsPlugin!.initialize(InitializationSettings(
        iOS: initializationSettingsIOS,
      ));
    } else {
      var initializationSettingsAndroid = const AndroidInitializationSettings(
        '@mipmap/launcher_icon',
      );
      flutterLocalNotificationsPlugin!.initialize(InitializationSettings(
        android: initializationSettingsAndroid,
      ));
    }
    var initializationSettingsAndroid = const AndroidInitializationSettings(
      '@mipmap/launcher_icon',
    );
    flutterLocalNotificationsPlugin!.initialize(InitializationSettings(
      android: initializationSettingsAndroid,
    ));
  });

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // await FirebaseMessaging.instance.getInitialMessage();

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('++++++++Main.Dart+++++++++++ ' + message.toString());
  //   RemoteNotification? notification = message.notification;
  //   AndroidNotification? android = message.notification?.android;

  // if(message.notification != null){
  //   print('Mesaage COMINGGGGG>>  ${message.notification!.title}' );
  //   //  flutterLocalNotificationsPlugin!.show(
  //   //       notification.hashCode,
  //   //       notification!.title,
  //   //       notification.body,
  //   //       NotificationDetails(
  //   //         android: AndroidNotificationDetails(
  //   //           channel!.id,
  //   //           channel!.name,
  //   //           // channel!.description,
  //   //           importance: Importance.max,
  //   //           priority: Priority.high,
  //   //           icon: '@drawable/logo1',
  //   //           playSound: true,
  //   //           // sound:
  //   //         ),
  //   //       ));
  // }
  // }); //for background messages
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await _configureAmplify();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => CreateAccountProvider()),
    ChangeNotifierProvider(create: (_) => EmailVerificationProvider()),
    ChangeNotifierProvider(create: (_) => SigninProvider()),
    ChangeNotifierProvider(create: (_) => ForgetPasswordProvider()),
    ChangeNotifierProvider(create: (_) => APIServiceProvider()),
    ChangeNotifierProvider(create: (_) => CreateProfileProvider()),
    ChangeNotifierProvider(create: (_) => LogoutProvider()),
    ChangeNotifierProvider(create: (_) => GetRestaurentDetailsProvider()),
    ChangeNotifierProvider(create: (_) => MakeReservationProvider()),
    ChangeNotifierProvider(create: (_) => GetReservationProvider())
  ], child: const MyApp()));
}

/* Amplify Configure with the app */
Future<void> _configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    await Amplify.addPlugin(auth);
    // call Amplify.configure to use the initialized categories in your app
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    print('An error occurred configuring Amplify: $e');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String sociallogin = '';
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Stream _myStream =
      Stream.periodic(const Duration(seconds: 5), (int count) {
    return count;
  });
  StreamSubscription? _sub;

// location track
  var isTracking = false;
  Timer? _timer;
  List<String> _locations = [];
  TokenResponse? _tokenResponseDataModel;
  var devicetoken;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('++++++++Main.Dart+++++++++++ ' + message.data.toString());
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      // IOSNot? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                // channel!.description,
                importance: Importance.max,
                priority: Priority.high,
                icon: '@mipmap/launcher_icon',
                playSound: true,
                // sound:
              ),
            ));
      }
    });
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        networkstatus('');
      } else {
        networkstatus('Online');
      }
      // Got a new connectivity status!
    });
    _loadInitial();
    requestPermission();
    _requestLocationPermission();
    _getTrackingStatus();
    _startLocationsUpdatesStream();
    trackingnethod();
  }

  Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print(
          'User permission granted ' + settings.authorizationStatus.toString());
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission' +
          settings.authorizationStatus.toString());
    } else {
      print('user declined');
    }
    setState(() {});
  }

// Be sure to cancel subscription after you are done
  @override
  dispose() {
    _timer?.cancel();
    super.dispose();
    _connectivitySubscription.cancel();
  }

  //fot get Tracking status
  Future<void> _getTrackingStatus() async {
    print('tracking status>>> ');
    isTracking = await BackgroundLocationTrackerManager.isTracking();
    setState(() {});
  }

  //Start tracking
  trackingnethod() {
    BackgroundLocationTrackerManager.startTracking();
    setState(() {
      isTracking = true;
    });

    //  LocationDao().clear();
    //                           // await _getLocations();
    //                            BackgroundLocationTrackerManager
    //                               .stopTracking();
    //                           setState(() => isTracking = false);
    print('Start tracking');
    // if( !isTracking){

    //  }
  }

  Future<void> _requestLocationPermission() async {
    print('enterrequest>>> ');
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    var status = await Permission.locationWhenInUse.status;
    if (!status.isGranted) {
      var status = await Permission.locationWhenInUse.request();
      if (status.isGranted) {
        var status = await Permission.locationAlways.request();
        if (status.isGranted) {
          print('GRANTED');
        } else {
          //Do another stuff
        }
      } else {
        //The user deny the permission
      }
      if (status.isPermanentlyDenied) {
        //When the user previously rejected the permission and select never ask again
        //Open the screen of settings
        bool res = await openAppSettings();
      }
    } else {
      //In use is available, check the always in use
      var status = await Permission.locationAlways.status;
      if (!status.isGranted) {
        var status = await Permission.locationAlways.request();
        if (status.isGranted) {
          //Do some stuff
        } else {
          //Do another stuff
        }
      } else {
        //previously available, do some stuff or nothing
      }
    }
    setState(() {});
  }

  //Location update
  void _startLocationsUpdatesStream() {
    print('Stream Location>>> ');
    _timer?.cancel();
    _timer = Timer.periodic(
        const Duration(milliseconds: 250), (timer) => _getLocations());
  }

  Future<void> _getLocations() async {
    final locations = await LocationDao().getLocations();
    setState(() {
      _locations = locations;
    });
  }

  _loadInitial() async {
    var socialLogin = await SharedPreference().getsocialloginName();
    setState(() {
      if (socialLogin.toString() != '') {
        fetchAuthSession.call();
      }
    });
  }

  void fetchAuthSession() async {
    _sub = _myStream.listen((event) async {
      final result = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true),
      );
      if (result != null) {
        sociallogin = (result as CognitoAuthSession).isSignedIn.toString();
        loginStatus(context, sociallogin,
            result.userPoolTokens!.accessToken.toString());
      } else {
        _sub!.pause();
      }
    });
  }

  networkstatus(netStatus) async {
    final bool resultstatus =
        await SharedPreference().setinternetStatus(netStatus);
  }

  loginStatus(
    BuildContext context,
    String signInStatus,
    String token,
  ) async {
    final bool resultoken = await SharedPreference().setToken(token);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ready Seat Eat',
      theme: ThemeData(
          // This is the theme of your application.
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: Colors.blue,
          ),
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Repo {
  static Repo? _instance;

  Repo._();

  factory Repo() => _instance ??= Repo._();

  Future<void> update(BackgroundLocationUpdateData data) async {
    // final text = 'Location Update: Lat: ${data.lat} Lon: ${data.lon}';

    var lat2 = 12.7119116;
    var lon2 = 79.8931288;
    double earthRadius = 6371000;

    // for radians use vector_math lib
    var dLat = radians(lat2 - data.lat);
    var dLng = radians(lon2 - lon2);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(radians(data.lat)) *
            cos(radians(lat2)) *
            sin(dLng / 2) *
            sin(dLng / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = earthRadius * c; //d is the distance in meters
    totalDistance = d;
    // calculateDistance(data.lat,data.lon);
    final text = 'Location Update: TOTAL DISTANCE $totalDistance';
    print(text); // ignore: avoid_print
    // for(var i = 0; i < data.length-1; i++){
    //   totalDistance += calculateDistance(data.lat, data.lon, data[i+1]["lat"], data[i+1]["lng"]);
    // }
    if (totalDistance < 16) {
      sendNotification(text);
      print('5 FEET DISTANCE ' + totalDistance.toString());
    } else {
      print('FAR DISTANCE ' + totalDistance.toString());
    }
    //  sendNotification(text);

    await LocationDao().saveLocation(data);
  }

  void sendNotification(String text) {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      iOS: IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );
    FlutterLocalNotificationsPlugin().initialize(
      settings,
      onSelectNotification: (data) async {
        print('ON CLICK $data'); // ignore: avoid_print
      },
    );
    FlutterLocalNotificationsPlugin().show(
      Random().nextInt(9999),
      'Title',
      text,
      const NotificationDetails(
        android: AndroidNotificationDetails('test_notification', 'Test'),
        iOS: IOSNotificationDetails(),
      ),
    );
  }

  num totalDistance = 0;
  num calculateDistance(lat1, lon1) {
    var lat2 = 17.5156763;
    var lon2 = 78.3760164;
    double earthRadius = 6371000;

// for radians use vector_math lib
    var dLat = radians(lat2 - lat1);
    var dLng = radians(lon2 - lon2);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(radians(lat1)) * cos(radians(lat2)) * sin(dLng / 2) * sin(dLng / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = earthRadius * c; //d is the distance in meters
    totalDistance = d;
    print('Total distance ' + d.toString());

    // var p = 0.017453292519943295;
    // var c = cos;
    // var a = 0.5 - c((lat2 - lat1) * p)/2 +
    //       c(lat1 * p) * c(lat2 * p) *
    //       (1 - c((lon2 - lon1) * p))/2;
    // totalDistance = 12742 * asin(sqrt(a));
    // print('HHHHHHHHHHHHHHHHHHHHHHHHHHHHH ' + totalDistance.toString());
    // LocationDao().clear();

    return 12742 * asin(sqrt(a));
  }
}

class LocationDao {
  static const _locationsKey = 'background_updated_locations';
  static const _locationSeparator = '-/-/-/';

  static LocationDao? _instance;

  LocationDao._();

  factory LocationDao() => _instance ??= LocationDao._();

  SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async =>
      _prefs ??= await SharedPreferences.getInstance();

  Future<void> saveLocation(BackgroundLocationUpdateData data) async {
    final locations = await getLocations();
    locations.add(
        '${DateTime.now().toIso8601String()}       ${data.lat},${data.lon}');
    await (await prefs)
        .setString(_locationsKey, locations.join(_locationSeparator));
  }

  Future<List<String>> getLocations() async {
    final prefs = await this.prefs;
    await prefs.reload();
    final locationsString = prefs.getString(_locationsKey);
    if (locationsString == null) return [];
    return locationsString.split(_locationSeparator);
  }

  Future<void> clear() async => (await prefs).clear();
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
