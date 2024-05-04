
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription? _subscription;
  InternetBloc() : super(InternetInitial()) {
    on<InternetEvent>((event, emit) {
      if(event is ConnectedEvent){
        emit(ConnectedState(message: "Connected"));
      }else if(event is NotConnectedEvent){
        emit(NotConnectedState(message: "Not Connected"));
      }
      });

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result){
      debugPrint(result.toString());
      if(result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile)){
        add(ConnectedEvent());
      }else{
        add(NotConnectedEvent());
      } });
  }

  @override
  Future<void> close() {
    _subscription!.cancel(); //close the stream when the bloc is closed
    return super.close();
  }
}
