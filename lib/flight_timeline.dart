import 'dart:ffi';

import 'package:animatedflight/flight_routes.dart';
import 'package:flutter/material.dart';

class FlightTimeLine extends StatefulWidget {
  const FlightTimeLine({Key? key}) : super(key: key);

  @override
  _FlightTimeLineState createState() => _FlightTimeLineState();
}

const _airplaneSize = 50.0;
const _dotSize = 18.0;
const _cardAnimationDuration = 100;

class _FlightTimeLineState extends State<FlightTimeLine> {
  bool animated = false;
  bool animateCards = false;
  bool animateButton = false;

  void initAnimation() async {
    setState(() {
      animated = !animated;
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      animateCards = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      animateButton = true;
    });
  }

  void _onRoutesPressed() {
    Navigator.of(context)
        .push(PageRouteBuilder(pageBuilder: (_, animation1, __) {
      return FadeTransition(opacity: animation1, child: const FlightRoutes());
    }));
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      initAnimation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final centerDot = constraints.maxWidth / 2 - _dotSize / 2;
        return Stack(
          children: <Widget>[
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              left: constraints.maxWidth / 2 - _airplaneSize / 2,
              top: animated ? 20 : constraints.maxHeight - _airplaneSize - 10,
              bottom: 0.0,
              child: const AircraftAndLine(),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              left: centerDot,
              top: animated ? 100 : constraints.maxHeight,
              child: TimeLineDot(
                selected: true,
                displayCard: animateCards,
                left: false,
                delay: const Duration(milliseconds: _cardAnimationDuration),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 800),
              right: centerDot,
              top: animated ? 180 : constraints.maxHeight,
              child: TimeLineDot(
                selected: false,
                displayCard: animateCards,
                left: true,
                delay: const Duration(milliseconds: _cardAnimationDuration * 2),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              left: centerDot,
              top: animated ? 260 : constraints.maxHeight,
              child: TimeLineDot(
                selected: false,
                displayCard: animateCards,
                left: false,
                delay: const Duration(milliseconds: _cardAnimationDuration * 3),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1200),
              right: centerDot,
              top: animated ? 340 : constraints.maxHeight,
              child: TimeLineDot(
                selected: true,
                displayCard: animateCards,
                left: true,
                delay: const Duration(milliseconds: _cardAnimationDuration * 4),
              ),
            ),
            if (animateButton)
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 500),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.check),
                    onPressed: () {
                      _onRoutesPressed();
                    },
                  ),
                ),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
              ),
          ],
        );
      },
    );
  }
}

class TimeLineDot extends StatefulWidget {
  final bool selected;
  final bool displayCard;
  final bool left;
  final Duration delay;

  const TimeLineDot(
      {Key? key,
      required this.selected,
      required this.displayCard,
      required this.left,
      required this.delay})
      : super(key: key);

  @override
  State<TimeLineDot> createState() => _TimeLineDotState();
}

class _TimeLineDotState extends State<TimeLineDot> {
  bool animated = false;

  void _animateWithDelay() async {
    if (widget.displayCard) {
      await Future.delayed(widget.delay);
      setState(() {
        animated = true;
      });
    }
  }

  @override
  void didUpdateWidget(covariant TimeLineDot oldWidget) {
    _animateWithDelay();
    super.didUpdateWidget(oldWidget);
  }

  Widget _buildCard() => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: _cardAnimationDuration),
        child: Container(
          color: Colors.grey.shade200,
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("JFK + ORY"),
          ),
        ),
        builder: (context, value, child) {
          return Transform.scale(
            alignment:
                widget.left ? Alignment.centerRight : Alignment.centerLeft,
            scale: value,
            child: child,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (animated && widget.left) ...[
          _buildCard(),
          Container(
            width: 10,
            height: 1,
            color: Colors.grey.shade400,
          ),
        ],
        Container(
          height: _dotSize,
          width: _dotSize,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: CircleAvatar(
              backgroundColor: widget.selected ? Colors.red : Colors.green,
            ),
          ),
        ),
        if (animated && !widget.left) ...[
          Container(
            width: 10,
            height: 1,
            color: Colors.grey.shade400,
          ),
          _buildCard(),
        ],
      ],
    );
  }
}

class AircraftAndLine extends StatefulWidget {
  const AircraftAndLine({Key? key}) : super(key: key);

  @override
  State<AircraftAndLine> createState() => _AircraftAndLineState();
}

class _AircraftAndLineState extends State<AircraftAndLine> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _airplaneSize,
      child: Column(
        children: <Widget>[
          const Icon(
            Icons.flight,
            color: Colors.red,
            size: _airplaneSize,
          ),
          Expanded(
            child: Container(
              width: 1.5,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
