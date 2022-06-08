// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pharmacy_plateform/utils/colors.dart';
import 'package:pharmacy_plateform/widgets/big_text.dart';

import '../widgets/navigation_drawer_widget.dart';

class MainPharmacyScreen extends StatefulWidget {
  const MainPharmacyScreen({Key? key}) : super(key: key);

  @override
  State<MainPharmacyScreen> createState() => _MainPharmacyScreenState();
}

class _MainPharmacyScreenState extends State<MainPharmacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(text: "Navigation Drawer", color: Colors.white),
        centerTitle: true,
      ),
    );
  }
}
