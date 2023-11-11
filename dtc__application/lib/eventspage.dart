import 'package:dtc__application/Utils/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// DataModel (EventData & Upcoming Events)--------> [Start]
class EventData {
  final String event_title;
  final String event_speaker;
  final String event_date;
  final String event_desc;
  final String event_img;

  EventData({
    required this.event_title,
    required this.event_speaker,
    required this.event_date,
    required this.event_img,
    required this.event_desc,
  });

  factory EventData.fromJson(Map<String, dynamic> json) => EventData(
      event_title: json['event_title'],
      event_speaker: json['event_speaker'],
      event_date: json['event_date'],
      event_img: json['event_img'],
      event_desc: json['event_desc']);
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

// DataModel (EventData & Upcoming Events) <--------[END]

// EventsPage Widget --------> [Start]
class Events extends StatefulWidget {
  const Events({super.key});

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State {
  List<EventData> oldEvents = [];
  List<EventData> newEvents = [];

  @override
  void initState() {
    super.initState();
    fetchUpcomingEvents();
  }

// Function for Fetching the Events Data
  fetchUpcomingEvents() async {
    final url = Uri.parse(
        "https://dtcapplication-1d801-default-rtdb.firebaseio.com/events.json");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;

      // Now you have the JSON data as a string in the jsonData variable
      // print(jsonData);

      // You can parse the JSON string as needed
      Map<String, dynamic> extractedData = json.decode(jsonData);
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
        oldEvents = loadedEvents;
        newEvents = loadedUpComingEvents;
      });
    }
  }

// Widget Starts Here.....
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.background1,
              title: const Text(
                'Events',
                style: TextStyle(color: AppColors.headingtext1),
              ),
              centerTitle: true,
              bottom:
                  const TabBar(indicatorColor: AppColors.headingtext1, tabs: [
                Tab(
                  child: Text(
                    "Upcoming",
                    style: TextStyle(color: AppColors.headingtext1),
                  ),
                ),
                Tab(
                  child: Text(
                    "Past Events",
                    style: TextStyle(color: AppColors.headingtext1),
                  ),
                )
              ]),
            ),
            body: TabBarView(children: [
              (newEvents == 0)
                  ? Container(
                      width: width / 3,
                      color: Colors.amber,
                      child: Center(
                          child: Image.asset('lib/assets/Empty_illus.png')),
                    )
                  : CustomCard(width: width, Events: [], events: newEvents),
              CustomCard(
                width: width,
                events: oldEvents,
                Events: [],
              )
            ])));
  }
}
// EventsPage Widget <------- [END]

// Card Layout ---------> [Start]
class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.width,
    required List<EventData> Events,
    required this.events,
  });

  final List<EventData> events;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Container(
            height: 130,
            margin: const EdgeInsets.all(4),
            child: Card(
              child: Row(
                children: [
                  SizedBox(
                    width: width / 3,
                    child: Image.asset(event.event_img),
                  ),
                  const SizedBox(width: 10), // Add some spacing
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          event.event_title,
                          style: const TextStyle(
                              fontSize: 20, color: AppColors.headingtext1),
                        ),
                        const SizedBox(
                            height:
                                5), // Add spacing between title and description
                        Text(
                          event.event_speaker,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          event.event_date,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
// Card Layout <--------- [END]
