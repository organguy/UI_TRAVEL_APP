import 'package:flutter/material.dart';
import 'package:ui_travel_app/components/side_bar.dart';
import 'package:ui_travel_app/screen/activities_screen.dart';
import 'package:ui_travel_app/screen/hotels_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Travel App UI',
      initialRoute: '/activities',
      routes: {
        ActivitiesScreen.routeName: (context) => const ActivitiesScreen(),
        HotelsScreen.routeName: (context) => const HotelsScreen()
      },
      builder: (context, child){
        return _TravelApp(
          navigator: (child!.key as GlobalKey<NavigatorState>),
          child: child,
        );
      },
    );
  }
}

class _TravelApp extends StatefulWidget {
  const _TravelApp({
    Key? key,
    required this.navigator,
    required this.child
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigator;
  final Widget child;

  @override
  State<_TravelApp> createState() => _TravelAppState();
}

class _TravelAppState extends State<_TravelApp> {

  bool isOnboarding = true;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5EDDC),
      body: isOnboarding
          ? _buildOnboarding(context)
          : Row(
              children: [
                SideBar(
                  height: height,
                  width: width,
                  navigator: widget.navigator,
                ),
                Expanded(
                  child: widget.child
                )
              ],
            ),
    );
  }

  Container _buildOnboarding(context) => Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/background-2.jpg'),
        fit: BoxFit.cover
      )
    ),
    child: Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.45,
        bottom: MediaQuery.of(context).size.height * 0.1,
        left: 30,
        right: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hidden Treasures of Italy',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontSize: 65,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: (){
              setState(() {
                isOnboarding = false;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              elevation: 0.0
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 50,
                  color: Colors.white,
                ),
                const SizedBox(width: 10,),
                Text(
                  'Explore Now',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}

