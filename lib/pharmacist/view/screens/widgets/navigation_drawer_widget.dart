// ignore_for_file: prefer_const_constructors, dead_code, sized_box_for_whitespace, prefer_const_declarations, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/pharmacist/model/drawer_item_model.dart';
import 'package:pharmacy_plateform/pharmacist/view/screens/drawer/drawer_items.dart';
import 'package:pharmacy_plateform/routes/route_helper.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';

import '../../../../utils/colors.dart';
import '../../../../widgets/big_text.dart';

class NavigationDrawerWidget extends StatefulWidget {
  NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);
    final isCollapsed = navigationController.isCollapsed;

    return Container(
      width: isCollapsed ? MediaQuery.of(context).size.width * 0.2 : null,
      child: Drawer(
        child: Container(
          color: Color(0xFF1a2f45),
          child: Column(children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 24).add(safeArea),
                width: double.infinity,
                color: Colors.white12,
                child: buildHeader(isCollapsed)),
            SizedBox(
              height: 24,
            ),
            buildList(items: itemsFirst, isCollapsed: isCollapsed),
            SizedBox(
              height: 24,
            ),
            Divider(
              color: Colors.white70,
            ),
            SizedBox(height: 24),
            buildList(
                indexOffset: itemsFirst.length,
                items: itemsSecond,
                isCollapsed: isCollapsed),
            Spacer(),
            buildCollapseIcon(context, isCollapsed),
            SizedBox(
              height: 12,
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildHeader(bool isCollapsed) => isCollapsed
      ? FlutterLogo(size: 48)
      : Row(
          children: [
            SizedBox(width: 24),
            FlutterLogo(size: 48),
            Text(
              "Flutter",
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
          ],
        );

  Widget buildCollapseIcon(BuildContext context, bool isCollapsed) {
    final double size = 52;
    final icon = isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
    final alignment = isCollapsed ? Alignment.center : Alignment.centerRight;
    final margin = isCollapsed ? null : EdgeInsets.only(right: 16);
    final width = isCollapsed ? double.infinity : size;

    return Container(
      alignment: alignment,
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            width: width,
            height: size,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          onTap: () {
            setState(() {
              navigationController.toggleIsCollapsed();
            });
          },
        ),
      ),
    );
  }

  Widget buildList({
    required List<DrawerItem> items,
    required bool isCollapsed,
    int indexOffset = 0,
  }) =>
      ListView.separated(
        padding: isCollapsed ? EdgeInsets.zero : padding,
        shrinkWrap: true,
        primary: false,
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(
          height: 16,
        ),
        itemBuilder: (context, index) {
          final item = items[index];

          return buildMenuItem(
            isCollapsed: isCollapsed,
            text: item.title,
            icon: item.icon,
            onClicked: () => selectItem(context, indexOffset + index),
          );
        },
      );

  Widget buildMenuItem(
      {required bool isCollapsed,
      required String text,
      required IconData icon,
      VoidCallback? onClicked}) {
    final color = Colors.white;
    final leading = Icon(
      icon,
      color: color,
    );

    return Material(
      color: Colors.transparent,
      child: isCollapsed
          ? ListTile(
              title: leading,
              onTap: onClicked,
            )
          : ListTile(
              leading: leading,
              title: Text(
                text,
                style: TextStyle(color: color, fontSize: 16),
              ),
              onTap: onClicked,
            ),
    );
  }

  selectItem(BuildContext context, int index) {
    navigator?.pop();
    switch (index) {
      case 0:
        Get.toNamed(RouteHelper.getMainPharmacyPage());
        break;

      case 1:
        Get.toNamed(RouteHelper.getPharmacyMedecinePage());
        break;

      case 2:
        Get.toNamed(RouteHelper.getPharmacistOrderScreen());
        break;

      case 3:
        Get.toNamed(RouteHelper.getSignInPage());
        break;

      case 7:
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: BigText(
                text: "You are Quitting the App",
                color: AppColors.mainBlackColor,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      //print('Im tapeeeeeeeed');
                      if (firebaseAuth.currentUser != null) {
                        authController.clearShareData();
                        cartControllers.clear();
                        cartControllers.clearCartHistory();
                        authController.logOut();
                      }
                    },
                    child: BigText(
                      text: "Yes",
                      color: Colors.redAccent,
                    )),
                TextButton(
                    onPressed: () => Get.back(),
                    child: BigText(
                      text: "No",
                      color: AppColors.mainColor,
                    ))
              ],
            );
          },
        );
        break;
    }
  }
}
