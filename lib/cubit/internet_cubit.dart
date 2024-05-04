import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit() : super(InternetInitial());
  StreamSubscription? _subscription;

  void connected(){
    emit(ConnectedState(message: "Connected"));
  }

  void notConnected(){
    emit(NotConnectedState(message: "Not Connected"));
  }

  void checkConnection(){
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result){
      if(result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.mobile)){
        connected();
      }else{
        notConnected();
      }
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    _subscription!.cancel();
    return super.close();
  }

}


