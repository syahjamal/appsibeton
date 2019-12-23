import 'package:appsibeton/pages/account.dart';
import 'package:appsibeton/pages/cart.dart';
import 'package:appsibeton/pages/home.dart';
import 'package:appsibeton/pages/orders.dart';
import 'package:appsibeton/services/auth_service.dart';
import 'package:appsibeton/views/first_view.dart';
import 'package:appsibeton/views/sign_up_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'MaisonNeue',
          primarySwatch: Colors.red,
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/SignUp': (BuildContext context) => SignUpView(),
          '/home': (BuildContext context) => HomeController(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedTab = 0;
  final _layout = [Home(), Orders(), Cart(), Account()];

  void _onTabItem(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new MyHomePage()));
          },
          child: Image.asset('images/Sibeton-logo.png', height: 35.0),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.grey,
              size: 30.0,
            ),
            onPressed: () {},
          )
        ],
      ),
//      drawer: new Drawer(
//        child: new ListView(
//          children: <Widget>[
//            new UserAccountsDrawerHeader(
//                accountName: Text('Sulaiman Syah Jamal'),
//                accountEmail: Text('sulaimansyahjamal@gmail.com'))
//          ],
//        ),
//      ),
      body: _layout.elementAt(_selectedTab),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedTab,
        onTap: _onTabItem,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Image.asset('images/home.png', scale: 2.5),
              ),
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Image.asset('images/home-non.png', scale: 2.5),
              ),
              title: Text("Home")),
          BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Image.asset('images/orders.png', scale: 2.5),
              ),
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Image.asset('images/orders-non.png', scale: 2.5),
              ),
              title: Text("Orders")),
          BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Image.asset('images/cart.png', scale: 2.5),
              ),
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Image.asset('images/cart-non.png', scale: 2.5),
              ),
              title: Text("Cart")),
          BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Image.asset('images/account.png', scale: 2.5),
              ),
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Image.asset('images/account-non.png', scale: 2.5),
              ),
              title: Text("Account")),
        ],
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, AsyncSnapshot<String> snapshot){
          if(snapshot.connectionState == ConnectionState.active){
            final bool signedIn = snapshot.hasData;
            return signedIn ? MyHomePage() : FirstView();
          }
          return CircularProgressIndicator();
        }
    );
  }
}

class Provider extends InheritedWidget{
  final AuthService auth;
  Provider ({Key key, Widget child, this.auth}) : super (key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget){
    return true;
  }
  
  static Provider of(BuildContext context) => (context.inheritFromWidgetOfExactType(Provider)as Provider);
}

