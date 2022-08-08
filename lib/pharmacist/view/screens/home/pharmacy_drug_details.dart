// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_plateform/base/custom_loader.dart';
import 'package:pharmacy_plateform/models/drug_model.dart';
import 'package:pharmacy_plateform/pharmacist/controllers/post_drug_controller.dart';
import 'package:pharmacy_plateform/utils/app_constants.dart';
import 'package:pharmacy_plateform/utils/styles.dart';
import '../../../../base/show_custom_snackbar.dart';
import '../../../../controllers/cart_controller.dart';
import '../../../../controllers/slide_drug_controller.dart';
import '../../../../routes/route_helper.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/app_icon.dart';
import '../../../../widgets/big_text.dart';
import '../../../../widgets/expandable_text_widget.dart';
import '../widgets/Pharmacy_app_text_field.dart';
import '../widgets/add_quantity_field.dart';

class PharmacyDrugDetails extends StatefulWidget {
  final int pageId;
  final String page;
  final String medId;
  const PharmacyDrugDetails(
      {Key? key, required this.pageId, required this.page, required this.medId})
      : super(key: key);

  @override
  State<PharmacyDrugDetails> createState() => _PharmacyDrugDetailsState();
}

class _PharmacyDrugDetailsState extends State<PharmacyDrugDetails> {
  final Rx<bool> _isLoaded = false.obs;
  bool get isLoaded => _isLoaded.value;
  @override
  Widget build(BuildContext context) {
    var quantityController = TextEditingController();
    var drug = Get.find<SlideDrugController>().slideDrugList[widget.pageId];
    final SlideDrugController slideDrugController =
        Get.put(SlideDrugController());
    Future.delayed(Duration.zero, () {
      slideDrugController.initData(drug, Get.find<CartController>());
    });

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
                  child: AppIcon(icon: Icons.clear),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(
                    child: BigText(size: Dimensions.font26, text: drug.title)),
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
                drug.photoUrl,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    child: ExpandableTextWidget(
                        text:
                            "This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've usedThis video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used This video is about flutter GridView builder. How you can use flutter GridView builder to make an infinte list of contents or large list contents. Here I've used firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list. firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list.firebase to fetch all my data & show up in the list." //drug.description!
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
                                  .deleteByChangeVisibility(widget.medId);
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
                  color: AppColors.mainColor,
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
                            child: !isLoaded
                                ? Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                Dimensions.radius20),
                                            topRight: Radius.circular(
                                                Dimensions.radius20))),
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
                                                    bottom:
                                                        Dimensions.height10 /
                                                            2),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                    .radius20 /
                                                                4),
                                                    color: Theme.of(context)
                                                        .cardColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color:
                                                              Colors.grey[200]!,
                                                          blurRadius: 5,
                                                          spreadRadius: 1)
                                                    ]),
                                                child: ListTile(
                                                  leading: Icon(
                                                    Icons
                                                        .production_quantity_limits,
                                                    size: 40,
                                                    color: Theme.of(context)
                                                        .disabledColor,
                                                  ),
                                                  title: Text(
                                                      "Add new Quantity of this drug",
                                                      style:
                                                          robotoMedium.copyWith(
                                                              fontSize:
                                                                  Dimensions
                                                                      .font20)),
                                                  subtitle: Text(
                                                      "the safe way to add a new quantity",
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      style: robotoRegular
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .disabledColor,
                                                              fontSize:
                                                                  Dimensions
                                                                      .font16)),
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
                                                textController:
                                                    quantityController,
                                                textInputType:
                                                    TextInputType.number,
                                                textInputAction:
                                                    TextInputAction.done,
                                                hintText: "Quantity",
                                              ),
                                              SizedBox(
                                                height: Dimensions.height30,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  uploadDrugQuantity(
                                                    widget.medId,
                                                    int.parse(quantityController
                                                        .text),
                                                  );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: Dimensions.height20,
                                                      bottom:
                                                          Dimensions.height20,
                                                      left: Dimensions.width20 *
                                                          3,
                                                      right:
                                                          Dimensions.width20 *
                                                              3),
                                                  child: BigText(
                                                    text: 'Do it',
                                                    color: Colors.white,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                                  .radius20 /
                                                              4),
                                                      color:
                                                          AppColors.mainColor,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors
                                                                .grey[200]!,
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
                                  )
                                : CircularProgressIndicator(
                                    color: AppColors.mainColor,
                                  ),
                          ),
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
                  color: AppColors.mainColor,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getPharmacyUpdateDrugPage(
                    widget.medId, widget.pageId));
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
                  color: AppColors.mainColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadDrugQuantity(
    String id,
    int quantity,
  ) async {
    _isLoaded.value = true;
    try {
      if (quantity == null) {
        showCustomSnackBar("Fill your quantity please", title: "quantity");
      } else {
        final response = await firestore.collection('Medicines').doc(id).get();
        var restQuantity = response.data() as Map;

        firestore
            .collection('Medicines')
            .doc(id)
            .update({"quantity": restQuantity['quantity'] + quantity}).then(
                (value) async {});
        _isLoaded.value = false;
        Get.back();
      }
    } catch (e) {
      showCustomSnackBar(
        e.toString(),
        title: "Charging the drug quantity",
      );
    }
  }
}
