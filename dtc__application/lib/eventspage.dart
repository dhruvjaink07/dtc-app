import 'dart:convert';
import 'package:dtc__application/Events/colors.dart';
import 'package:dtc__application/Events/dynamicCard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// enum category { Events }

class EventData {
  final String event_title;
  final String event_speaker;
  final String event_date;
  final String event_desc;
  final String event_img;
  // final String upcoming_event_img;

  EventData({
    required this.event_title,
    required this.event_speaker,
    required this.event_date,
    required this.event_img,
    required this.event_desc,
    // required this.upcoming_event_img,
  });

  factory EventData.fromJson(Map<String, dynamic> json) => EventData(
      event_title: json['event_title'],
      event_speaker: json['event_speaker'],
      event_date: json['event_date'],
      event_img: json['event_img'],
      event_desc: json['event_desc']);
  // upcoming_event_img: json['upcoming_img']);
}

class UpcomingEventData {
  final String upcoming_event_title;
  final String upcoming_event_speaker;
  final String upcoming_event_date;
  final String upcoming_event_description;
  final String upcoming_event_image;

  UpcomingEventData({
    required this.upcoming_event_title,
    required this.upcoming_event_speaker,
    required this.upcoming_event_date,
    required this.upcoming_event_description,
    required this.upcoming_event_image,
  });

  factory UpcomingEventData.fromJson(Map<String, dynamic> json) =>
      UpcomingEventData(
        upcoming_event_title: json['event_title'],
        upcoming_event_speaker: json['event_speaker'],
        upcoming_event_date: json['event_date'],
        upcoming_event_image: json['event_img'],
        upcoming_event_description: json['event_desc'],
      );
}

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State {
  List<EventData> upcomingEvents = [];
  List<EventData> newEvents = [];
  

  @override
  void initState() {
    super.initState();
    fetchUpcomingEvents();
  }

  fetchUpcomingEvents() async {
    final url = Uri.parse(
        "https://dtcapplication-1d801-default-rtdb.firebaseio.com/events.json");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;

      // Now you have the JSON data as a string in the jsonData variable
      print(jsonData);

      // You can parse the JSON string as needed
      Map<String, dynamic> extractedData = json.decode(jsonData);

      // Rest of your processing here...
      final List<EventData> loadedEvents = [];
      extractedData.forEach((eventId, eventData) {
        final eventTitle = eventData['event_title'] as String;
        if (eventTitle != "") {
          loadedEvents.add(EventData(
            event_title: eventData['event_title'],
            event_speaker: eventData['event_speaker'],
            event_date: eventData['event_date'],
            event_img: eventData['event_image'],
            event_desc: eventData['event_description'],
          ));
        }
      });

      final List<EventData> loadedUpComingEvents = [];
      extractedData.forEach((eventId, eventData) {
        final upcomingEventTitle = eventData['upcoming_event_title'];
        if (upcomingEventTitle.isNotEmpty) {
          loadedUpComingEvents.add(UpcomingEventData(
            upcoming_event_title: eventData['upcoming_event_title'],
            upcoming_event_speaker: eventData['upcoming_event_speaker'],
            upcoming_event_date: eventData['upcoming_event_date'],
            upcoming_event_image: eventData['upcoming_event_image'],
            upcoming_event_description: eventData['upcoming_event_description'],
          ) as EventData);
        }
      });

      setState(() {
        upcomingEvents = loadedEvents;
        newEvents = loadedUpComingEvents;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('E V E N T S', 
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 18,
              fontWeight: FontWeight.bold),  
              ),
              backgroundColor:Color.fromARGB(255, 57, 37, 120) ,
              centerTitle: true,
              bottom: const TabBar(
                indicatorColor:Color.fromARGB(255, 57, 37, 120),
                tabs: [
                Tab(
                  child: Text('Upcoming',
                   style: TextStyle(color: Colors.black87,
                   fontSize:16,
                   fontWeight: FontWeight.bold),
                   ),
                ),
                Tab(
                  child: Text('Past ',
                   style: TextStyle(color: Colors.black87,
                   fontSize:16,
                   fontWeight: FontWeight.bold),) ,
                )
              ]),
            ),
            body: TabBarView(children: [
              (newEvents == 0)
                  ? Container(
                      width: width / 3,
                      color: AppColors.background1,
                      child:
                          Center(child: Image.asset('assets/images/')),
                    )
                  : DynamicCard(width: width, Events: [], events: newEvents),
              DynamicCard(
                width: width,
                events: upcomingEvents,
                Events: [],
              )
            ])));
  }
}
