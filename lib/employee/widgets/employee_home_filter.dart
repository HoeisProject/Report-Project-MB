import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:report_project/employee/view_model/employee_home_view_model.dart';

Widget employeeHomeFilterMenu(BuildContext context, WidgetRef ref) {
  return IconButton(
      onPressed: () {
        debugPrint("menu out");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return _showFilterMenu(context, ref);
            });
      },
      icon: const Icon(Icons.filter_list));
}

Widget _showFilterMenu(BuildContext context, WidgetRef ref) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 5,
    backgroundColor: Colors.transparent,
    child: Container(
      height: 250.0,
      width: 100.0,
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(0, 10), blurRadius: 10)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          statusDropdown(ref),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Close",
                  style: TextStyle(fontSize: 18),
                )),
          ),
        ],
      ),
    ),
  );
}

List<String> statusFilter = [
  "All",
  "Pending",
  "Approved",
  "Rejected",
];

List<DropdownMenuItem<String>> get statusDropdownItem {
  List<DropdownMenuItem<String>> items = [];
  items = statusFilter.map((e) {
    return DropdownMenuItem(value: e, child: Text(e));
  }).toList();
  return items;
}

Widget statusDropdown(WidgetRef ref) {
  return DropdownButton(
    value: ref.watch(employeeHomeStatusSelectedProvider),
    onChanged: (value) {
      ref.read(employeeHomeStatusSelectedProvider.notifier).state =
          (statusFilter.indexOf(value.toString()) - 1);
    },
    items: statusDropdownItem,
  );
}
