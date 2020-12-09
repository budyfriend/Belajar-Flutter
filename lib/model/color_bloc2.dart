import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

enum ColorEvents2 { to_amber, to_light_blue }

class ColorBloc2 extends Bloc<ColorEvents2, Color> {
  @override
  Color get initialState => Colors.amber;

  @override
  Stream<Color> mapEventToState(ColorEvents2 event) async* {
    yield (event == ColorEvents2.to_amber) ? Colors.amber : Colors.lightBlue;
  }
}
