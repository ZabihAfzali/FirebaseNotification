import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/screen_notification.dart';
import 'package:firebase_notification/screen_snake_bar.dart';
import 'package:flutter/material.dart';


Future<void> _firebaseOnBackgroundMessageHandle(RemoteMessage remoteMessage) async {
  try{
    print("FirebaseMessage ${remoteMessage.notification!.title}");
    print("FirebaseMessage ${remoteMessage.notification!.body}");
  }catch(e){
    print("Firebase error ${e.toString()}");
  }
}

Future<void> main() async {
  try{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseOnBackgroundMessageHandle);
    runApp(const MyApp());
  }catch(e){
    print("Firebase Messaging error ${e.toString()}");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  GlobalKey<NavigatorState> navigatorState=GlobalKey<NavigatorState>();



  void onMessageNotificationHandler() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      print("FirebaseMessage onMessage");

      if(remoteMessage!=null){
        _notificationHandler(remoteMessage);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      print("FirebaseMessage onMessageOpenedApp");
      if(remoteMessage!=null){
        _notificationHandler(remoteMessage);
      }
    });
  }

  void _notificationHandler(RemoteMessage remoteMessage) async {

    try {
      Map<String, dynamic> sss=remoteMessage.data;
      print("object 1 ${remoteMessage.notification!.title.toString()}");
      print("object 2 ${remoteMessage.notification!.body.toString()}");
      print("object 3 ${remoteMessage.data.toString()}");
      print("object rol num 4 ${remoteMessage.data["roll_num"]}");
      print("object notification 5 ${remoteMessage.data["notification_type"]}");

      // {
      //   if(remoteMessage.data["notification_type"]=="roll_num"){
      //
      //   }
      navigatorState.currentState!.pushNamed("/notification_screen",arguments: remoteMessage.data["notification_type"]);

    } on Exception catch (e) {
      // TODO
      print("Error ${e.toString()}");
    }


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging firebaseMessaging=FirebaseMessaging.instance;

    firebaseMessaging.getToken().then((value){
      print("FirebaseMessaging token ${value}");
    });


    onMessageNotificationHandler();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorState,
      debugShowCheckedModeBanner: false,
      title: "Firebase Notification",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // routes: {
      // "/": (context)=>  Scaffold(
      //   appBar: AppBar(
      //     title: Text("Firebase Notification"),
      //   ),
      //   floatingActionButton: FloatingActionButton(onPressed:(){
      //     WidgetsReusing.getSnakeBar(navigatorState.currentState!.context,"message");
      //   },
      //     child: Icon(Icons.message),
      //   ),
      //   body: Container(
      //     color: Colors.lightBlue,
      //   ),
      // ),
      //   "/notification_screen":(context)=>Screen_notification();
      // },
      onGenerateRoute: GetRoutes,
    );

  }

  Route<dynamic> GetRoutes(RouteSettings settings){
    if(settings.name=="/notification_screen"){
      return MaterialPageRoute(builder: (builder)=>Screen_notification(notifiaction_title:settings.arguments.toString(),),);
    }
    else{
      return
      MaterialPageRoute(builder: (builder)=>Scaffold(
        appBar: AppBar(
          title: Text("Firebase Notification"),
        ),
        floatingActionButton: FloatingActionButton(onPressed:(){
          WidgetsReusing.getSnakeBar(navigatorState.currentState!.context,"message");
        },
          child: Icon(Icons.message),
        ),
        body: Container(
          color: Colors.lightBlue,
        ),
      ),
      );
    }
  }
}


