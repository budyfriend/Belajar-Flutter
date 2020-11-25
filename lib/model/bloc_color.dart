import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

enum ColorEvents { to_amber, to_light_blue }

class ColorBlocs extends Bloc<ColorEvents, Color> {
  Color _color = Colors.amber;
  @override
  Color get initialState => Colors.amber;

  @override
  Stream<Color> mapEventToState(ColorEvents event) async* {
    _color = (event == ColorEvents.to_amber) ? Colors.amber : Colors.lightBlue;
    yield _color;
  }
}
