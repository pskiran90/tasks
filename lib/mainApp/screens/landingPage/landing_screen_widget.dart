import 'package:flutter/material.dart';
import '../../models/data_model.dart';
import '../../reusables/colors.dart';

class CustomeTile extends StatelessWidget {
  const CustomeTile({
    super.key,
    required this.action,
    required this.dataFilesList,
  });
  final void Function() action;
  final DataModel dataFilesList;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16 / 2),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: red),
        borderRadius: const BorderRadius.all(Radius.circular(16 / 2)),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: action,
            title: Text(
              dataFilesList.title,
              style: const TextStyle(
                color: black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
