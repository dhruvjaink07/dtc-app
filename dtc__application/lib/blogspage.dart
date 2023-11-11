import 'package:dtc__application/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogsPage extends StatefulWidget {
  const BlogsPage({super.key});

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
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
            color: AppColors.background2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Our Blogs',
                          style: TextStyle(
                            color: AppColors.headingtext2,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arvo',
                          ),
                        ),
                        Container(
                          width: 60, // Set the width to your desired value
                          height: 2, // Set the height of the underline
                          decoration: BoxDecoration(
                            color: AppColors
                                .headingtext2, // Color of the underline
                            borderRadius: BorderRadius.circular(
                                2), // Optional: Add rounded corners to the underline
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
                      'THE COMPLETE GUIDE TO JAVA',
                      'Anas Khan',
                      'https://dtc.hashnode.dev/the-complete-guide-to-java-2023',
                      'assets/Java.png',
                      250,
                      220,
                    ),
                    _buildCard(
                      screenSize,
                      'OPEN SOURCE IS OVERRATED',
                      'Anas Khan',
                      'https://dtc.hashnode.dev/open-source-is-overrated',
                      'assets/opensource.png',
                      250,
                      220,
                    ),
                    _buildCard(
                      screenSize,
                      'AWESOME TOOLS FOR DEVELOPERS',
                      'Anas Khan',
                      'https://dtc.hashnode.dev/awesome-online-tools-for-self-improving-as-a-developersoftware-engineer',
                      'assets/tools.png',
                      250,
                      200,
                    ),
                    _buildCard(
                      screenSize,
                      'WEB DEVELOPMENT ROADMAP',
                      'Anas Khan',
                      'https://dtc.hashnode.dev/the-complete-guide-to-java-2023',
                      'assets/web dev.png',
                      250,
                      220,
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

  Widget _buildCard(Size screenSize, String title, String content, String url,
      String imagePath, double imageWidth, double imageHeight) {
    return GestureDetector(
      onTap: () {
        _launchURL(url);
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(20),
        child: Container(
          width: screenSize.width * 0.9,
          height: screenSize.height * 0.5,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: imageWidth,
                height: imageHeight,
                child: Image.asset(
                  imagePath, // Use the provided image path
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.uppertext,
                  fontFamily: 'Arvo',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                content,
                style: TextStyle(fontSize: 16, color: AppColors.lowertext),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _openRightDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }
}
