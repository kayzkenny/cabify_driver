import 'package:cabify_driver/pages/vehicle_info_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cabify_driver/pages/error_page.dart';
import 'package:cabify_driver/pages/landing_page.dart';
import 'package:cabify_driver/pages/loading_page.dart';
import 'package:cabify_driver/pages/unknown_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cabify_driver/pages/home/home_page.dart';
import 'package:cabify_driver/providers/auth_provider.dart';
import 'package:cabify_driver/providers/app_providers.dart';
import 'package:cabify_driver/pages/authenticate/login_page.dart';
import 'package:cabify_driver/pages/authenticate/signup_page.dart';

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
            final user = context.read(authServiceProvider).currentUser();

            return MaterialPageRoute(
              builder: (context) => user != null ? HomePage() : LandingPage(),
            );

            // return MaterialPageRoute(builder: (context) => LandingPage());
          }

          if (settings.name == '/signup') {
            return MaterialPageRoute(builder: (context) => SignUpPage());
          }

          if (settings.name == '/vehicleinfo') {
            return MaterialPageRoute(builder: (context) => VehicleInfoPage());
          }

          if (settings.name == '/login') {
            return MaterialPageRoute(builder: (context) => LoginPage());
          }

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
