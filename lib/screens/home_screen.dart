import 'package:connectedornotproject/bloc/internet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: BlocBuilder<InternetBloc, InternetState>(
        builder: (context, state){
          if(state is ConnectedState){
            return _buildTextWidget(state.message);
          }else if(state is NotConnectedState){
            return _buildTextWidget(state.message);
          }
          return _buildTextWidget("Not this nor this");
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget _buildTextWidget(String message){
  return Center(
    child: Text(
      message,
      style: const TextStyle(fontSize: 20),
    ),
  );
}