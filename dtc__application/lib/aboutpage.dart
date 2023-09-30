import 'package:dtc__application/Events/colors.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/Background.jpeg',
                ),
                fit: BoxFit.cover)),
      child: Scaffold(
        key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset(
                    'assets/logo-small.png',
                    width: MediaQuery.of(context).size.width * 0.19,
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {
                  _openRightDrawer();
                },
              ),
            ],
          ),
          endDrawer: Drawer(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pushNamed(context, 'Home');
                  },
                ),
                ListTile(
                  title: Text('About'),
                  onTap: () {
                    Navigator.pushNamed(context, 'About');
                  },
                ),
                ListTile(
                  title: Text('Events'),
                  onTap: () {
                    Navigator.pushNamed(context, 'Events');
                  },
                ),
                ListTile(
                  title: Text('Blogs'),
                  onTap: () {
                    Navigator.pushNamed(context, 'Blogs');
                  },
                ),
                ListTile(
                  title: Text('FAQs'),
                  onTap: () {
                    Navigator.pushNamed(context, 'FAQ');
                  },
                ),
                ListTile(
                  title: Text('Connect'),
                  onTap: () {
                    Navigator.pushNamed(context, 'Connect');
                  },
                ),
              ],
            ),
          ),

        body: SingleChildScrollView(
          child: Container(
            color: AppColors.background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Benefits of Joining Us',
                          style: TextStyle(
                            color: AppColors.headingtext,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arvo', 
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 50, // Set the width to your desired value
                          height: 1, // Set the height of the underline
                          decoration: BoxDecoration(
                            color: AppColors.headingtext, // Color of the underline
                            borderRadius: BorderRadius.circular(1), 
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCard(
                      screenSize,
                      'HELP YOU TO LEARN AND GROW FROM OTHERS EXPERIENCE',
                      'assets/grow.png',
                    ),
                    _buildCard(
                      screenSize,
                      'HACKATHON AND INTERNSHIP OPPORTUNITIES',
                      'assets/hackathon.png',
                    ),
                    _buildCard(
                      screenSize,
                      'GET TO LEARN FROM SENIORS AND MENTORS',
                      'assets/learn.png',
                    ),
                    _buildCard(
                      screenSize,
                      'PLATFORM FOR YOU TO BE A ROCKSTAR',
                      'assets/platform.png',
                    ),
                    _buildCard(
                      screenSize, 
                      'BEST TECHNICAL WORKSHOPS AND SESSIONS', 
                      'assets/workshops.png',
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Size screenSize, String title, String imagePath) {
    double imageWidth = screenSize.width * 0.6;
    double imageHeight = screenSize.height * 0.25;
    
    double titleFontSize = screenSize.width * 0.05;  // Adjust this value as needed

    return GestureDetector(
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(20),
        child: Container(
          width: screenSize.width * 0.8,
          height: screenSize.height * 0.48,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: imageWidth,
                height: imageHeight,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: titleFontSize,
                  color: Color.fromRGBO(52, 62, 74, 1),
                  fontFamily: 'Arvo',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
  void _openRightDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }
}