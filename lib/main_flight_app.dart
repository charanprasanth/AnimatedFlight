import 'package:animatedflight/flight_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'flight_timeline.dart';

class FlightHomeApp extends StatefulWidget {
  const FlightHomeApp({Key? key}) : super(key: key);

  @override
  _FlightHomeAppState createState() => _FlightHomeAppState();
}

enum FlightView { form, timeline }

class _FlightHomeAppState extends State<FlightHomeApp> {
  FlightView flightView = FlightView.form;

  void _onFlightPressed() {
    setState(() {
      flightView = FlightView.timeline;
    });
  }

  @override
  Widget build(BuildContext context) {
    final headerHeight = MediaQuery.of(context).size.height * 0.32;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              height: headerHeight,
              left: 0,
              right: 0,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFE04148), Color(0xFFD85774)],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        "Air Asia",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const <Widget>[
                          HeaderButton(title: 'One way', selected: false),
                          HeaderButton(title: 'Round', selected: false),
                          HeaderButton(title: 'MultiCity', selected: true),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 0,
              top: headerHeight / 2,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
                        Expanded(
                          child: TabButton(title: "Flight", selected: true),
                        ),
                        Expanded(
                          child: TabButton(title: "Train", selected: false),
                        ),
                        Expanded(
                          child: TabButton(title: "Bus", selected: false),
                        ),
                      ],
                    ),
                    // const Expanded(
                    //   child: FlightForm(),
                    // ),
                    Expanded(
                      child: flightView == FlightView.form
                          ? FlightForm(onTap: _onFlightPressed)
                          : const FlightTimeLine(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String title;
  final bool selected;

  const TabButton({Key? key, required this.title, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              style: TextStyle(
                color: selected ? Colors.black : Colors.grey,
              ),
            ),
          ),
          if (selected)
            Container(
              height: 2,
              color: Colors.red,
            ),
        ],
      ),
    );
  }
}

class HeaderButton extends StatelessWidget {
  final String title;
  final bool selected;

  const HeaderButton({Key? key, required this.title, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: selected ? Colors.white : null,
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 13),
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              color: selected ? Colors.red : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
