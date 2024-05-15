import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tasks/mainApp/models/data_model.dart';

class FetchDataBloc extends Bloc<FetchDataEvent, FetchDataState> {
  FetchDataBloc() : super(FetchDataInitial()) {
    on<FetchData>((event, emit) async {
      emit(FetchDataProgress());
      if (kDebugMode) debugPrint("FetchDataBloc");
      var client = http.Client();
      List<DataModel> datas = [];
      try {
        var response = await client.get(
          Uri.parse(' https://swan.alisonsnewdemo.online/api'),
        );
        List result = jsonDecode(response.body);
        for (int i = 0; i < result.length; i++) {
          DataModel data = DataModel.fromJson(result[i] as Map<String, dynamic>);
          datas.add(data);
        }
        debugPrint(datas.toString());

        emit(FetchDataSuccess(dataList: datas));
      } catch (e) {
        emit(FetchDataFailure(e));
      }
    });
  }
}

///state - inst
abstract class FetchDataState {}

///event - inst
abstract class FetchDataEvent {}

///events - impl
class FetchData extends FetchDataEvent {}

///states - impl
class FetchDataInitial extends FetchDataState {}

class FetchDataProgress extends FetchDataState {}

class FetchDataSuccess extends FetchDataState {
  FetchDataSuccess({required this.dataList});

  final List<DataModel> dataList;
}

class FetchDataFailure extends FetchDataState {
  FetchDataFailure(this.error);

  final dynamic error;
}
