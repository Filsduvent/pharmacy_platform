// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/models/drug_model.dart';
import 'package:pharmacy_plateform/pharmacist/controllers/post_drug_controller.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:pharmacy_plateform/utils/styles.dart';
import '../../../../base/show_custom_snackbar.dart';
import '../../../../routes/route_helper.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/app_icon.dart';
import '../../../../widgets/big_text.dart';
import '../../../../widgets/expandable_text_widget.dart';
import '../actions_on_drug/update_drug.dart';
import '../widgets/add_quantity_field.dart';

class PharmacyDrugDetails extends StatefulWidget {
  final int pageId;
  final String page;
  final Drug drug;
  const PharmacyDrugDetails(
      {Key? key, required this.pageId, required this.page, required this.drug})
      : super(key: key);

  @override
  State<PharmacyDrugDetails> createState() => _PharmacyDrugDetailsState();
}

class _PharmacyDrugDetailsState extends State<PharmacyDrugDetails> {
  @override
  Widget build(BuildContext context) {
    var quantityController = TextEditingController();
    // var drug = Get.find<SlideDrugController>().slideDrugList[widget.pageId];
    // final SlideDrugController slideDrugController =
    Get.put(PostDrugController());
    // Future.delayed(Duration.zero, () {
    //   slideDrugController.initData(drug, Get.find<CartController>());
    // });

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getPharmacyMedecinePage());
                  },
                  child: AppIcon(
                    icon: Icons.clear,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                  ),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(
                    child: BigText(
                        size: Dimensions.font26, text: widget.drug.title)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    )),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.mainColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.drug.photoUrl,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            BigText(
                              text: "Category",
                            ),
                            SizedBox(
                              width: Dimensions.width30,
                            ),
                            BigText(
                              text: widget.drug.categories,
                              color: Color(0xFFccc7c5),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Row(
                          children: [
                            BigText(
                              text: "Manufacturing date",
                            ),
                            SizedBox(
                              width: Dimensions.width30,
                            ),
                            BigText(
                              text: widget.drug.manufacturingDate,
                              color: Color(0xFFccc7c5),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Row(
                          children: [
                            BigText(
                              text: "Expiring date",
                            ),
                            SizedBox(
                              width: Dimensions.width30,
                            ),
                            BigText(
                              text: widget.drug.expiringDate,
                              color: Color(0xFFccc7c5),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Row(
                          children: [
                            BigText(
                              text: "Posted at",
                            ),
                            SizedBox(
                              width: Dimensions.width20,
                            ),
                            BigText(
                              text: widget.drug.publishedDate,
                              color: Color(0xFFccc7c5),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Row(
                          children: [
                            BigText(
                              text: "Price ",
                            ),
                            SizedBox(
                              width: Dimensions.width30,
                            ),
                            Row(
                              children: [
                                BigText(
                                  text: 'BIF',
                                  color: AppColors.mainColor,
                                ),
                                SizedBox(
                                  width: Dimensions.width10 / 2,
                                ),
                                BigText(
                                  text: widget.drug.price.toString(),
                                  color: AppColors.mainColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Row(
                          children: [
                            BigText(
                              text: "Quantity",
                            ),
                            SizedBox(
                              width: Dimensions.width30,
                            ),
                            BigText(
                              text: widget.drug.quantity.toString(),
                              color: Color(0xFFccc7c5),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Row(
                          children: [
                            BigText(
                              text: "Units",
                            ),
                            SizedBox(
                              width: Dimensions.width30,
                            ),
                            BigText(
                              text: widget.drug.units,
                              color: Color(0xFFccc7c5),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Row(
                          children: [
                            BigText(
                              text: "Status",
                            ),
                            SizedBox(
                              width: Dimensions.width30,
                            ),
                            BigText(
                              text: widget.drug.status,
                              color: Color(0xFFccc7c5),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Row(
                          children: [
                            BigText(
                              text: "Description",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        ExpandableTextWidget(text: widget.drug.description),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),

      //Bottom section
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(
            top: Dimensions.height30,
            bottom: Dimensions.height30,
            left: Dimensions.width20,
            right: Dimensions.width20),
        decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius20 * 2),
              topLeft: Radius.circular(Dimensions.radius20 * 2),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                          'There\'s no way to retreive deleted elements!'),
                      content: BigText(
                        text: "Are you sure you want to delete this drug?",
                        color: AppColors.mainBlackColor,
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              postDrugController
                                  .deleteByChangeVisibility(widget.drug.id);
                            },
                            child: BigText(
                              text: "Yes",
                              color: AppColors.yellowColor,
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
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                child: BigText(
                  text: 'Delete',
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.secondColor,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) {
                    return Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                              child: Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(Dimensions.radius20),
                                    topRight:
                                        Radius.circular(Dimensions.radius20))),
                            child: Column(
                              children: [
                                Container(
                                  height: 400,
                                  padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10,
                                      top: Dimensions.height45 * 2),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            bottom: Dimensions.height10 / 2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20 / 4),
                                            color: Theme.of(context).cardColor,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[200]!,
                                                  blurRadius: 5,
                                                  spreadRadius: 1)
                                            ]),
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.production_quantity_limits,
                                            size: 40,
                                            color:
                                                Theme.of(context).disabledColor,
                                          ),
                                          title: Text(
                                              "Add new Quantity of this drug",
                                              style: robotoMedium.copyWith(
                                                  fontSize: Dimensions.font20)),
                                          subtitle: Text(
                                              "the safe way to add a new quantity",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: robotoRegular.copyWith(
                                                  color: Theme.of(context)
                                                      .disabledColor,
                                                  fontSize: Dimensions.font16)),
                                          trailing: Icon(
                                            Icons.check_circle,
                                            color: AppColors.mainColor,
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        height: Dimensions.height30,
                                      ),
                                      //Quantity
                                      PharmacyAddQuantityTextField(
                                        textController: quantityController,
                                        textInputType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
                                        hintText: "Quantity",
                                      ),
                                      SizedBox(
                                        height: Dimensions.height30,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          try {
                                            if (quantityController
                                                .text.isEmpty) {
                                              showCustomSnackBar(
                                                  "Fill your quantity please",
                                                  title: "quantity");
                                            } else if (int.parse(
                                                    quantityController.text) <=
                                                0) {
                                              showCustomSnackBar(
                                                  "The quantity must be greater than 0",
                                                  title: "quantity");
                                            } else {
                                              final response = await firestore
                                                  .collection('Medicines')
                                                  .doc(widget.drug.id)
                                                  .get();
                                              var restQuantity =
                                                  response.data() as Map;

                                              firestore
                                                  .collection('Medicines')
                                                  .doc(widget.drug.id)
                                                  .update({
                                                "quantity": restQuantity[
                                                        'quantity'] +
                                                    int.parse(
                                                        quantityController.text)
                                              }).then((value) {
                                                Navigator.pop(context);
                                                Get.toNamed(RouteHelper
                                                    .getPharmacyMedecinePage());
                                              });
                                            }
                                          } catch (e) {
                                            showCustomSnackBar(
                                              e.toString(),
                                              title: "Add item quantity",
                                            );
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: Dimensions.height20,
                                              bottom: Dimensions.height20,
                                              left: Dimensions.width20 * 3,
                                              right: Dimensions.width20 * 3),
                                          child: BigText(
                                            text: 'Do it',
                                            color: Colors.white,
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20 / 4),
                                              color: AppColors.mainColor,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey[200]!,
                                                    blurRadius: 5,
                                                    spreadRadius: 1)
                                              ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                        ),
                      ],
                    );
                  }),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                child: BigText(
                  text: 'Add Quantity',
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.secondColor,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Get.toNamed(RouteHelper.getPharmacyUpdateDrugPage(
                //     widget.medId, widget.pageId));
                Get.to(
                  () => UpdateDrugScreen(drug: widget.drug),
                );
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                child: BigText(
                  text: 'Update',
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.secondColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
