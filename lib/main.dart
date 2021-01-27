import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cabify_driver/providers/app_providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final textTheme = Theme.of(context).textTheme;
    final _firebaseApp = watch(firebaseAppProvider);

    return _firebaseApp.when(
      data: (firebaseApp) => MaterialApp(
        title: 'Cabify',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.greenAccent,
          textTheme: GoogleFonts.latoTextTheme(textTheme),
        ),
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            // final user = context.read(authServiceProvider).currentUser();

            // return MaterialPageRoute(
            //   builder: (context) => user != null ? HomePage() : LandingPage(),
            // );

            return MaterialPageRoute(builder: (context) => LandingPage());
          }

          // if (settings.name == '/signup') {
          //   return MaterialPageRoute(builder: (context) => SignUpPage());
          // }

          // if (settings.name == '/search') {
          //   return MaterialPageRoute(builder: (context) => SearchPage());
          // }

          // if (settings.name == '/login') {
          //   return MaterialPageRoute(builder: (context) => LoginPage());
          // }

          // if (settings.name == '/requestcab') {
          //   return MaterialPageRoute(builder: (context) => RequestCabPage());
          // }

          // if (settings.name == '/profile') {
          //   return MaterialPageRoute(builder: (context) => ProfilePage());
          // }

          return MaterialPageRoute(builder: (context) => UnknownPage());
        },
      ),
      loading: () => LoadingPage(),
      error: (error, stack) => ErrorPage(error: error, stack: stack),
    );
  }
}

class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    Key key,
    @required this.error,
    @required this.stack,
  }) : super(key: key);

  final Object error;
  final StackTrace stack;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('${error.toString()}'),
        ),
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cabify",
          style: TextStyle(color: Colors.black, fontSize: 32.0),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 32.0),
              Icon(
                Icons.car_rental,
                size: 100.0,
              ),
              SizedBox(height: 64.0),
              Text(
                "Welcome.",
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.black45,
                ),
              ),
              Text(
                "Modern travel",
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.black45,
                ),
              ),
              Text(
                "Starts here",
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: 64.0),
              Text(
                "Setting 700+ cities in motion",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black45,
                ),
              ),
              SizedBox(height: 64.0),
              SizedBox(
                height: 64.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: Text("Log in"),
                  elevation: 2.0,
                  color: Colors.black,
                  textColor: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 64.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                  child: Text("Don\'t have an account? Sign Up"),
                  elevation: 2.0,
                  color: Colors.greenAccent,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
