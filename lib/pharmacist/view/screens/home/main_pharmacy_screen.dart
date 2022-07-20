// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pharmacy_plateform/utils/colors.dart';
import 'package:pharmacy_plateform/widgets/app_icon.dart';
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(text: "Navigation Drawer", color: Colors.white),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(color: Color(0xFFf5CEBB)),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "Good Morning \nShishir",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29.5),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        icon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        CategoryCard(
                          imgSrc: "assets/image/empty_cart.png",
                          title: "Medicines stock",
                          press: () {},
                        ),
                        CategoryCard(
                            imgSrc: "assets/image/empty_cart.png",
                            title: "Orders",
                            press: () {}),
                        CategoryCard(
                          imgSrc: "assets/image/empty_cart.png",
                          title: "Medicines stock",
                          press: () {},
                        ),
                        CategoryCard(
                            imgSrc: "assets/image/empty_cart.png",
                            title: "Orders",
                            press: () {}),
                        CategoryCard(
                          imgSrc: "assets/image/empty_cart.png",
                          title: "Medicines stock",
                          press: () {},
                        ),
                        CategoryCard(
                            imgSrc: "assets/image/empty_cart.png",
                            title: "Orders",
                            press: () {}),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imgSrc;
  final String title;
  final VoidCallback press;
  const CategoryCard({
    Key? key,
    required this.imgSrc,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 17,
                spreadRadius: -23,
                color: Color(0XFFE6E6E6),
              )
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Spacer(),
                  Image.asset(imgSrc),
                  Spacer(),
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
