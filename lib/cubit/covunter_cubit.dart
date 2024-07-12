 
 import 'package:bloc/bloc.dart';

class CovunterCubit extends Cubit<int> {
  CovunterCubit():super(0);



  void decrment(){
    emit(state-1);
  }


  void increment(){
    emit(state+1);
  }
   
 }


