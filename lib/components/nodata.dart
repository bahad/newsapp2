import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  const NoDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Image.asset(
        'assets/images/nodata1.png',
        height: size.height / 6,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    );
  }
}
