import 'package:flutter/material.dart';
import 'package:pharmacy_plateform/admin/adminmodels/admin_menu_item.dart';

class MenuItemsListAdmin {
  static const List<MenuItemsAdmin> itemsFirst = [itemSettings, itemProfile];
  static const List<MenuItemsAdmin> itemsSecond = [itemSignOut];

  static const itemSettings =
      MenuItemsAdmin(text: 'Settings', icon: Icons.settings);
  static const itemProfile =
      MenuItemsAdmin(text: 'Profile', icon: Icons.person);
  static const itemSignOut =
      MenuItemsAdmin(text: 'Sign Out', icon: Icons.logout);
}
