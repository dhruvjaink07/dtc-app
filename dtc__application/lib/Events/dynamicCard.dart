import 'package:dtc__application/eventspage.dart';
import 'package:flutter/material.dart';

class DynamicCard extends StatelessWidget {
  const DynamicCard({
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
      height: 140,
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Container(
            height: 130,
            margin: const EdgeInsets.all(4),
            child: Card(
              elevation: 5,
              child: Row(
                children: [
                  Container(
                    width: 100,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(event.event_img),
                  ),
                  SizedBox(width: 10), // Add some spacing
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          event.event_title,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(
                            height:5), // Add spacing between title and description
                        Text(
                          event.event_speaker,
                          style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 88, 16, 161)),
                        ),
                        Text(
                          event.event_date,
                          style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 88, 16, 161)),
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
