import 'package:flutter/material.dart';
import 'package:gender_hack/course.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pre-cache images to avoid a flash of the background color on load.
    precacheImage(const AssetImage('assets/back-purp-white.jpg'), context);
    precacheImage(const AssetImage('assets/Ada.png'), context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.popAndPushNamed(context, '/home_page'),
        shape: const CircleBorder(),
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/back-purp-white.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Color.fromRGBO(0, 0, 0, 0.5),
                BlendMode.darken,
              ),
              opacity: 0.8,
              filterQuality: FilterQuality.low,
            ),
            // The color is removed to prevent it from showing during image load.
          ),
          child: Padding(
            padding: EdgeInsets.only(top: (width - width * 0.7) / 3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [const CourseTile(name: 'Ada Lovelace'), const CourseTile(name: 'Margherita Hack')],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: const Course(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
      ),
      child: Container(
        width: width * 0.35,
        height: width * 0.35,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(32, 32, 32, 1),
            width: 4,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
          color: const Color.fromARGB(255, 167, 166, 166),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          width: width * 0.35,
          height: width * 0.35,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Ada.png'),
              fit: BoxFit.fitHeight,
              opacity: 0.6,
              filterQuality: FilterQuality.high,
            ),
            border: Border.all(
              color: Color.fromRGBO(241, 241, 241, 1),
              width: 0.4,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            color: const Color.fromARGB(255, 121, 120, 120),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: width * 0.05),
              Container(
                width: width * 0.35,
                height: 33,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color.fromRGBO(32, 32, 32, 1),
                      width: 4,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                ),
                child: Container(
                  width: width * 0.35,
                  height: 33,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color.fromRGBO(241, 241, 241, 1),
                          width: 0.6,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: Color.fromRGBO(0, 0, 0, 0.9)),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
