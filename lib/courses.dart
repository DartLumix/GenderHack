import 'package:flutter/material.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

    @override
    _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.black,
            body: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/purp-back.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, 0.5), BlendMode.darken),
                  ),
                  color: Colors.white,
                ),
                child: ListView(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/course-1.jpg'),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/course-2.jpg'),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.5,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/course-3.jpg'),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                ),
              ),
            ),
        );
    }
}