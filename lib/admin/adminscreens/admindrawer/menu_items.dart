import 'package:flutter/material.dart';
import 'package:pharmacy_plateform/admin/adminmodels/admin_menu_item.dart';

class MenuItemsListAdmin {
  static const List<MenuItemsAdmin> itemsFirst = [itemSettings, itemShare];
  static const List<MenuItemsAdmin> itemsSecond = [itemSignOut];

  static const itemSettings =
      MenuItemsAdmin(text: 'Settings', icon: Icons.settings);
  static const itemShare = MenuItemsAdmin(text: 'Share', icon: Icons.share);
  static const itemSignOut =
      MenuItemsAdmin(text: 'Sign Out', icon: Icons.logout);
}
