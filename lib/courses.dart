import 'package:flutter/material.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
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
              filterQuality: FilterQuality.high,
            ),
            color: Colors.white,
          ),

          child: Padding(
            padding: EdgeInsets.only(top: (width - width * 0.7) / 3),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [const CourseTile(), const CourseTile()],
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
  const CourseTile({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/course');
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
          border: Border.all(color: Color.fromRGBO(32, 32, 32, 1), width: 4, strokeAlign: BorderSide.strokeAlignOutside),
          color: const Color.fromARGB(255, 167, 166, 166),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          width: width * 0.35,
          height: width * 0.35,
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(241, 241, 241, 1), width: 0.4, strokeAlign: BorderSide.strokeAlignInside,),
            color: const Color.fromARGB(255, 121, 120, 120),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.school, color: Colors.white, size: width * 0.1),
              SizedBox(height: width * 0.05),
              Container(
                width: width * 0.35,
                height: 33,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Color.fromRGBO(32, 32, 32, 1), width: 4, strokeAlign: BorderSide.strokeAlignInside)),
                ),
                child: Container(
                  width: width * 0.35,
                  height: 33,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Color.fromRGBO(241, 241, 241, 1), width: 0.6, strokeAlign: BorderSide.strokeAlignInside)),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                  ),
                  child: Text(
                    'Ada Lovelace',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
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
