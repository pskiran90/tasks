import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/mainApp/bloc/fetch_bloc.dart';
import 'package:tasks/mainApp/models/data_model.dart';

import '../../reusables/data_not_found.dart';
import '../../reusables/loading_screen.dart';
import '../landingPage/landing_screen_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<FetchDataBloc>().add(FetchData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchDataBloc, FetchDataState>(
      builder: (context, fdb) {
        if (fdb is FetchDataProgress) {
          return const LoadingScreen(message: "Loading");
        }
        return Scaffold(
          body: fdb is FetchDataSuccess
              ? ListView.builder(
                  itemCount: fdb.dataList.length,
                  itemBuilder: (context, index) {
                    DataModel dataList = fdb.dataList[index];
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomeTile(
                          dataFilesList: dataList,
                          action: () {
                            debugPrint(dataList.id.toString());
                          },
                        ));
                  })
              : const NotSelectedView(
                  msg: "No data",
                ),
        );
      },
    );
  }
}
