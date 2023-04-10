import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocpettern/bloc/internerbloc/internet_bloc.dart';
import 'package:flutterblocpettern/bloc/internerbloc/internet_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: BlocConsumer<InternetBloc, InternetState>(
        listener: (context, state) {
          if (state is InternetGainedState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Internet connected!"),backgroundColor: Colors.green,));
          } else if (state is InternetLostState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Internet not connected!"),backgroundColor: Colors.red,));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Loading...."),backgroundColor: Colors.indigoAccent,));
          }
        },
        builder: (context, state) {
          return BlocBuilder<InternetBloc, InternetState>(
            builder: (context, state) {
              if (state is InternetGainedState) {
                return const Text("Connected!");
              } else if (state is InternetLostState) {
                return const Text("Not Connected!");
              } else {
                return const Text("Loading...");
              }
            },
          );
        },
      ))),
    );
  }
}
