import 'package:budget_tracker/app/data/database/database.dart';
import 'package:budget_tracker/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  TransactionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    if (controller.dataEdit != null) {
      final transaction = controller.dataEdit!.transaction;
      controller.dateC.text = DateFormat('yyyy-MM-dd').format(transaction.date);
      controller.amountC.text = transaction.amount.toString();
      controller.descC.text = transaction.description;
    }
    return Scaffold(
      backgroundColor: primary,
      body: Container(
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/images/girl.svg",
                // width: 200,
                // height: 200,
              ),
              SizedBox(
                height: Get.height * 0.8,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          'Transaction',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FutureBuilder<List<Category>>(
                          future: controller.categoriesC.getAllCategories(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (snapshot.data!.isNotEmpty) {
                              if (snapshot.data!.length > 0) {
                                return DropdownButtonFormField<Category>(
                                  value: (controller.dataEdit != null)
                                      ? controller.dataEdit!.category
                                      : controller.selectedCategory,
                                  decoration: const InputDecoration(
                                    labelText: 'Categories',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                  ),
                                  items: snapshot.data!.map((Category item) {
                                    return DropdownMenuItem<Category>(
                                      value: item,
                                      child: Text(
                                        item.category,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (Category? value) {
                                    controller.selectedCategory = value;
                                  },
                                );
                              } else {
                                return const Center(
                                  child: Text('Create categories first!'),
                                );
                              }
                            } else {
                              return const Center(
                                child: Text('Create categories first!'),
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2025),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print('FORMATT DATE : ${formattedDate}');
                              controller.dateC.text = formattedDate;
                            }
                          },
                          controller: controller.dateC,
                          // initialValue: (controller.dataEdit != null)
                          //     ? DateFormat('yyyy-MM-dd')
                          //         .format(controller.dataEdit!.transaction.date)
                          //     : null,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: controller.amountC,
                          // initialValue: (controller.dataEdit != null)
                          //     ? '${controller.dataEdit!.transaction.amount}'
                          //     : null,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Amount',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: controller.descC,
                          // initialValue: (controller.dataEdit != null)
                          //     ? controller.dataEdit!.transaction.description
                          //     : null,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (controller.selectedCategory!.id != null &&
                                controller.dateC.text.isNotEmpty &&
                                controller.amountC.text.isNotEmpty &&
                                controller.descC.text.isNotEmpty) {
                              if (controller.dataEdit != null) {
                                if (controller.selectedCategory!.id != null) {
                                  controller.updateTransaction(
                                    controller.dataEdit!.transaction.id,
                                    controller.selectedCategory!.id,
                                    DateTime.parse(controller.dateC.text),
                                    int.parse(controller.amountC.text),
                                    controller.descC.text,
                                  );
                                } else {
                                  Get.snackbar('Error', 'Choose Categories!',
                                      colorText: greyColor);
                                }
                              } else {
                                controller.addTransaction(
                                  controller.selectedCategory!.id,
                                  DateTime.parse(controller.dateC.text),
                                  int.parse(controller.amountC.text),
                                  controller.descC.text,
                                );
                                controller.dateC.clear();
                                controller.amountC.clear();
                                controller.descC.clear();
                              }
                            } else {
                              Get.snackbar('Error', 'The field is empty!',
                                  colorText: greyColor);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: greyColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: const Size(350, 50)),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
