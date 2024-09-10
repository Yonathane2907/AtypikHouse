import 'package:atypik_house/widgets/commons/appbar_widget.dart';
import 'package:flutter/material.dart';

import '../services/logements_service.dart';


class LogementsTypesWidget extends StatefulWidget {
  const LogementsTypesWidget({super.key});

  @override
  State<LogementsTypesWidget> createState() => _LogementsTypesWidgetState();
}

class _LogementsTypesWidgetState extends State<LogementsTypesWidget> {

  List<dynamic> data = [];
  @override
  void initState() {
    super.initState();
    LogementsService().fetchLogements();


  }
  @override
  Widget build(BuildContext context) {


    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text("test"),
            Text(
              'Data: ${data.join(', ')}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
    );
  }
}
