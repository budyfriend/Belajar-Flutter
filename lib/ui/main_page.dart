import 'package:first_project/bloc/colors_bloc.dart';
import 'package:first_project/bloc/counter_bloc.dart';
import 'package:first_project/ui/draft_page.dart';
import 'package:first_project/ui/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorsBloc, Color>(
      builder: (context, color) => DraftPage(
        backgroundColor: color,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<CounterBloc, int>(
                builder: (context, number) => Text(
                  number.toString(),
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SecondsPages()));
                },
                child: Text(
                  'Click to Change',
                  style: TextStyle(color: Colors.white),
                ),
                color: color,
                shape: StadiumBorder(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
