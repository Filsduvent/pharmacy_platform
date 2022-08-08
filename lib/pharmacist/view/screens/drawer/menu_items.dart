import 'package:flutter/material.dart';
import 'package:pharmacy_plateform/pharmacist/model/menu_item.dart';

class MenuItemsList {
  static const List<MenuItems> itemsFirst = [itemSettings, itemShare];
  static const List<MenuItems> itemsSecond = [itemSignOut];

  static const itemSettings = MenuItems(text: 'Settings', icon: Icons.settings);
  static const itemShare = MenuItems(text: 'Share', icon: Icons.share);
  static const itemSignOut = MenuItems(text: 'Sign Out', icon: Icons.logout);
}
