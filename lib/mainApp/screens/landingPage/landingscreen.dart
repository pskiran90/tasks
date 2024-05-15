import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/mainApp/bloc/fetch_bloc.dart';
import 'package:tasks/mainApp/models/data_model.dart';

import '../../reusables/data_not_found.dart';
import '../../reusables/loading_screen.dart';
import 'landing_screen_widget.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
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
                        child: PolicyFilesTile(
                          dataFilesList: dataList,
                          action: () {
                            debugPrint((index + 1).toString());
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
