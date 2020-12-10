import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

enum ColorEvents2 { to_amber, to_light_blue }

class ColorBloc2 extends HydratedBloc<ColorEvents2, Color> {
  @override
  Color get initialState => super.initialState ?? Colors.amber;

  @override
  Stream<Color> mapEventToState(ColorEvents2 event) async* {
    yield (event == ColorEvents2.to_amber) ? Colors.amber : Colors.lightBlue;
  }

  @override
  Color fromJson(Map<String, dynamic> json) {
    try {
      return Color(json['color'] as int);
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Map<String, int> toJson(Color state) {
    try {
      return {'color': state.value};
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
