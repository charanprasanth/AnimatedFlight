import 'package:flutter/material.dart';

class FlightRoutes extends StatelessWidget {
  const FlightRoutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFE04148), Color(0xFFD85774)],
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 20,
              top: 10,
              child: BackButton(
                color: Colors.white,
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              top: MediaQuery.of(context).size.height * 0.15,
              child: Column(
                children: const <Widget>[
                  RouteItem(duration: Duration(milliseconds: 400)),
                  SizedBox(height: 10),
                  RouteItem(duration: Duration(milliseconds: 600)),
                  SizedBox(height: 10),
                  RouteItem(duration: Duration(milliseconds: 800)),
                  SizedBox(height: 10),
                  RouteItem(duration: Duration(milliseconds: 1000)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RouteItem extends StatelessWidget {
  final Duration duration;

  const RouteItem({Key? key, required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 1.0, end: 0.0),
      curve: Curves.decelerate,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(
            0.0,
            MediaQuery.of(context).size.height * value,
          ),
          child: child,
        );
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Text(
                      "SAHARA",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "SHE",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 24,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Icon(
                      Icons.flight,
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "A6DN30C",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Text(
                      "MACAU",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "MAC",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 24,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
