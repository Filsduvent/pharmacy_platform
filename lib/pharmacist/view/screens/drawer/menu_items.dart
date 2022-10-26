import 'package:flutter/material.dart';
import 'package:pharmacy_plateform/pharmacist/model/menu_item.dart';

class MenuItemsList {
  static const List<MenuItems> itemsFirst = [itemProfile];
  static const List<MenuItems> itemsSecond = [itemSignOut];

  // static const itemSettings = MenuItems(text: 'Settings', icon: Icons.settings);
  static const itemProfile = MenuItems(text: 'Profile', icon: Icons.person);
  static const itemSignOut = MenuItems(text: 'Sign Out', icon: Icons.logout);
}
