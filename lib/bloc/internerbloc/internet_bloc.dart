import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocpettern/bloc/internerbloc/internet_event.dart';
import 'package:flutterblocpettern/bloc/internerbloc/internet_state.dart';
import 'package:connectivity/connectivity.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {

  final Connectivity _connectivity = Connectivity();
  StreamSubscription? streamSubscription;

  InternetBloc() : super(InternetInitialState()) {
    on<InternetLostEvent>((event, emit) {
      emit(InternetLostState());
    });
    on<InternetGainedEvent>((event, emit) {
      emit(InternetGainedState());
    });

   streamSubscription =  _connectivity.onConnectivityChanged.listen((event) {
      if(event == ConnectivityResult.mobile || event == ConnectivityResult.wifi){
        add(InternetGainedEvent());
      } else {
        add(InternetLostEvent());
      }
    });

  }

  @override
  Future<void> close() {
    // TODO: implement close
    streamSubscription?.cancel();
    return super.close();
  }
}
