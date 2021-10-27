import 'package:flutter/material.dart';

class FlightForm extends StatelessWidget {
  final VoidCallback onTap;

  const FlightForm({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.flight_takeoff, color: Colors.red),
              SizedBox(width: 20),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: "From"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const <Widget>[
              Icon(Icons.flight_land, color: Colors.red),
              SizedBox(width: 20),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: "To"),
                ),
              ),
            ],
          ),
          const Spacer(),
          FloatingActionButton(
            onPressed: onTap,
            backgroundColor: Colors.red,
            child: const Icon(Icons.multiline_chart),
          ),
        ],
      ),
    );
  }
}
