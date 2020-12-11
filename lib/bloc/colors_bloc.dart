import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

enum ColorsEvent { toPink, toAmbar, toPurple }

class ColorsBloc extends Bloc<ColorsEvent, Color> {
  @override
  // TODO: implement initialState
  Color get initialState => Colors.pink;

  @override
  Stream<Color> mapEventToState(ColorsEvent event) async* {
    yield (event == ColorsEvent.toPink)
        ? Colors.pink
        : (event == ColorsEvent.toAmbar)
            ? Colors.amber
            : Colors.purple;
  }
}
