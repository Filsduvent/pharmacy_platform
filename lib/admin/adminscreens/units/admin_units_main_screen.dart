// ignore_for_file: sort_child_properties_last, prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/models/units_model.dart';
import '../../../base/no_data_page.dart';
import '../../../base/show_custom_snackbar.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/big_text.dart';

class AdminUnitsMainScreen extends StatefulWidget {
  const AdminUnitsMainScreen({Key? key}) : super(key: key);

  @override
  State<AdminUnitsMainScreen> createState() => _AdminUnitsMainScreenState();
}

class _AdminUnitsMainScreenState extends State<AdminUnitsMainScreen> {
  var controller = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var updateController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('Units').snapshots(),
          builder: (context, snapshot) {
            return Stack(
              children: [
                // color cover back ground
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.popularFoodImgSize,
                    color: AppColors.mainColor,
                  ),
                ),

                //Two buttons

                Positioned(
                  top: Dimensions.height20 * 2,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getAdminHomeScreen());
                          },
                          child: AppIcon(
                            icon: Icons.arrow_back_ios,
                            iconColor: AppColors.mainColor,
                          )),
                      AppIcon(
                        icon: Icons.search,
                        iconColor: AppColors.mainColor,
                      )
                    ],
                  ),
                ),

                //The container with the number of items in firebase
                Positioned(
                  top: Dimensions.height20 * 5,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: Container(
                    height: Dimensions.height45 * 1.3,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.secondColor,
                      borderRadius: BorderRadius.circular(29.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BigText(
                                text: "Total number of units : ",
                                color: Colors.white,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimensions.height10,
                                    bottom: Dimensions.height10,
                                    left: Dimensions.width10,
                                    right: Dimensions.width10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: Dimensions.width10 / 2,
                                    ),
                                    BigText(
                                        text: snapshot.hasData
                                            ? snapshot.data!.docs.length
                                                .toString()
                                            : "0"),
                                    SizedBox(
                                      width: Dimensions.width10 / 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //the white background on wich we have all delails
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: Dimensions.popularFoodImgSize - 120,
                  child: Container(
                    padding: EdgeInsets.only(
                        // left: Dimensions.width20,
                        // right: Dimensions.width20,
                        top: Dimensions.height10 / 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius20),
                          topLeft: Radius.circular(Dimensions.radius20),
                        ),
                        color: Colors.white),

                    // the content of the white background

                    child: snapshot.hasData && snapshot.data!.docs.isNotEmpty
                        ? Stack(
                            children: [
                              ListView.builder(
                                  // physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    // DocumentSnapshot snap =
                                    //     snapshot.data!.docs[index];
                                    var listUnits =
                                        snapshot.data!.docs.map((unit) {
                                      return UnitsModel.fromjson(unit);
                                    }).toList();
                                    // The container which contains the unit indexes
                                    return Container(
                                      margin: EdgeInsets.only(
                                        bottom: Dimensions.width20 * 2,
                                        left: Dimensions.width10,
                                        right: Dimensions.width10,
                                      ),
                                      padding: EdgeInsets.only(
                                          left: Dimensions.width20,
                                          right: Dimensions.width20,
                                          top: Dimensions.width20,
                                          bottom: Dimensions.width20),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                                text: listUnits[index]
                                                    .name
                                                    .toString()),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        updateController =
                                                            TextEditingController(
                                                                text: listUnits[
                                                                        index]
                                                                    .name
                                                                    .toString());
                                                      });
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                          title: BigText(
                                                            text: 'Unit type',
                                                            color: AppColors
                                                                .secondColor,
                                                            size: Dimensions
                                                                .font20,
                                                          ),
                                                          content: TextField(
                                                            autofocus: false,
                                                            controller:
                                                                updateController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .name,
                                                            textInputAction:
                                                                TextInputAction
                                                                    .done,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'Enter your unit type',
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: BigText(
                                                                text: "Cancel",
                                                                color: AppColors
                                                                    .yellowColor,
                                                                size: Dimensions
                                                                    .font20,
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                try {
                                                                  if (updateController
                                                                      .text
                                                                      .isEmpty) {
                                                                    showCustomSnackBar(
                                                                        "Fill the unit type please",
                                                                        title:
                                                                            "Name");
                                                                  } else {
                                                                    final docUnit = firestore
                                                                        .collection(
                                                                            'Units')
                                                                        .doc(listUnits[index]
                                                                            .id);

                                                                    UnitsModel
                                                                        units =
                                                                        UnitsModel(
                                                                      id: updateController
                                                                          .text,
                                                                      name: updateController
                                                                          .text,
                                                                    );

                                                                    docUnit
                                                                        .update(units
                                                                            .tojson())
                                                                        .whenComplete(
                                                                            () async {
                                                                      await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'Medicines')
                                                                          .where(
                                                                              'units',
                                                                              isEqualTo: listUnits[index].name)
                                                                          .get()
                                                                          .then((snapshot) {
                                                                        for (int i =
                                                                                0;
                                                                            i < snapshot.docs.length;
                                                                            i++) {
                                                                          String
                                                                              unitNameInPost =
                                                                              snapshot.docs[i]['units'];

                                                                          if (unitNameInPost !=
                                                                              updateController.text) {
                                                                            FirebaseFirestore.instance.collection('Medicines').doc(snapshot.docs[index].id).update({
                                                                              'units': updateController.text,
                                                                            });
                                                                          }
                                                                        }
                                                                      });

                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    });
                                                                  }
                                                                } catch (e) {
                                                                  showCustomSnackBar(
                                                                    e.toString(),
                                                                    title:
                                                                        "Editing unit type",
                                                                  );
                                                                }
                                                                // updateUnits(
                                                                //     listUnits[
                                                                //             index]
                                                                //         .id
                                                                //         .toString(),
                                                                //     updateController
                                                                //         .text);
                                                              },
                                                              child: BigText(
                                                                text: "Edit",
                                                                color: AppColors
                                                                    .mainColor,
                                                                size: Dimensions
                                                                    .font20,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    child: AppIcon(
                                                      icon: Icons.edit,
                                                      iconColor: Colors.white,
                                                      backgroundColor:
                                                          AppColors.mainColor,
                                                    )),
                                                SizedBox(
                                                  width: Dimensions.width30,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        title: BigText(
                                                          text:
                                                              'There\'s no way to retreive deleted elements!',
                                                          color: AppColors
                                                              .secondColor,
                                                          size:
                                                              Dimensions.font20,
                                                        ),
                                                        content: BigText(
                                                          text:
                                                              "Are you sure you want to delete this unit type?",
                                                          color: AppColors
                                                              .mainBlackColor,
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: BigText(
                                                              text: "Cancel",
                                                              color: AppColors
                                                                  .yellowColor,
                                                              size: Dimensions
                                                                  .font20,
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              deleteUnits(
                                                                  listUnits[
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                            },
                                                            child: BigText(
                                                              text: "Delete",
                                                              color: AppColors
                                                                  .mainColor,
                                                              size: Dimensions
                                                                  .font20,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: AppIcon(
                                                    icon: Icons.delete,
                                                    iconColor: Colors.white,
                                                    backgroundColor:
                                                        AppColors.yellowColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ]),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radius30),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 1,
                                              offset: Offset(0, 2),
                                              color:
                                                  Colors.grey.withOpacity(0.6),
                                            )
                                          ]),
                                    );
                                  })
                            ],
                          )
                        : NoDataPage(
                            text: "No unit type found",
                            imgPath: "assets/image/units.png",
                          ),
                  ),
                ),
              ],
            );
          }),
      // floatingactionbutton
      floatingActionButton: buildNavigateButton(),
    );
  }

  buildNavigateButton() => FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: AppColors.secondColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15)),
        onPressed: () {
          openDialog();
        },
      );

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: BigText(
            text: 'Unit type',
            color: AppColors.secondColor,
            size: Dimensions.font20,
          ),
          content: TextField(
            autofocus: false,
            controller: controller,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: 'Enter your unit type',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: BigText(
                text: "Cancel",
                color: AppColors.yellowColor,
                size: Dimensions.font20,
              ),
            ),
            TextButton(
              onPressed: () {
                uploadUnits(controller.text);
                controller.clear();
              },
              child: BigText(
                text: "Submit",
                color: AppColors.mainColor,
                size: Dimensions.font20,
              ),
            )
          ],
        ),
      );

  Future uploadUnits(String name) async {
    try {
      if (name.isEmpty) {
        showCustomSnackBar("Fill the unit type please", title: "Name");
      } else {
        final docUnit = firestore.collection('Units').doc(name);

        UnitsModel units = UnitsModel(
          id: name,
          name: name,
        );

        await docUnit.set(units.tojson()).then((value) => Get.back());
      }
    } catch (e) {
      showCustomSnackBar(
        e.toString(),
        title: "Create unit type",
      );
    }
  }

  Future updateUnits(String id, String name) async {
    try {
      if (name.isEmpty) {
        showCustomSnackBar("Fill the unit type please", title: "Name");
      } else {
        final docUnit = firestore.collection('Units').doc(id);

        UnitsModel units = UnitsModel(
          id: name,
          name: name,
        );

        docUnit.update(units.tojson()).whenComplete(() {
          updateUnitsOnMedicineExistingPost(name);
          Navigator.of(context).pop();
        });
      }
    } catch (e) {
      showCustomSnackBar(
        e.toString(),
        title: "Editing unit type",
      );
    }
  }

  updateUnitsOnMedicineExistingPost(String name) async {
    await FirebaseFirestore.instance
        .collection('Medicines')
        .where('units', isEqualTo: controller.text)
        .get()
        .then((snapshot) {
      for (int index = 0; index < snapshot.docs.length; index++) {
        String unitNameInPost = snapshot.docs[index]['units'];

        if (unitNameInPost != name) {
          FirebaseFirestore.instance
              .collection('Medicines')
              .doc(snapshot.docs[index].id)
              .update({
            'units': name,
          });
        }
      }
    });
  }

  Future deleteUnits(String id) async {
    try {
      await firestore
          .collection('Units')
          .doc(id)
          .delete()
          .then((value) => Navigator.of(context).pop());
    } catch (e) {
      showCustomSnackBar(
        e.toString(),
        title: "Deleting unit type",
      );
    }
  }
}
