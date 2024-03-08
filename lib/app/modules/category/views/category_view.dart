import 'package:budget_tracker/app/data/database/database.dart';
import 'package:budget_tracker/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          'Categories',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: GetBuilder<CategoryController>(
        builder: (c) => FutureBuilder<List<Category>>(
          future: c.getAllCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF37474F),
                ),
              );
            }

            if (snapshot.data?.length == 0) {
              return const Center(
                child: Text(
                  'There is no data',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Category data = snapshot.data![index];
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 8),
                  child: Container(
                    height: 70,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: data.type == 'income' ? softGreen : softPurple,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 10),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: data.type == 'income'
                                            ? greenColor
                                            : purpleColor,
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Icon(
                                        data.type == 'income'
                                            ? Icons.arrow_downward_rounded
                                            : Icons.arrow_upward_rounded,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${data.category}',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: greyColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Get.defaultDialog(
                                contentPadding: const EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                title: 'Are you sure?',
                                titleStyle: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                content: Column(
                                  children: [
                                    const Text(
                                      'All of your data will lost if you delete the Category',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () => Get.back(),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: greenColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              minimumSize: Size(0, 45)),
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Poppins',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        ElevatedButton(
                                          onPressed: () => controller
                                              .deleteCategory(data.id),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red[200],
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              minimumSize: Size(0, 45)),
                                          child: const Text(
                                            'Delete',
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
                                  ],
                                ),
                              ),
                              icon: Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.red[200],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                var dataToEdit = snapshot.data![index];
                                controller.categoryC.text = dataToEdit.category;
                                Get.defaultDialog(
                                  title: 'Edit Category',
                                  backgroundColor: whiteColor,
                                  contentPadding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
                                  titleStyle: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  content: Column(
                                    children: [
                                      TextFormField(
                                        controller: controller.categoryC,
                                        textInputAction: TextInputAction.next,
                                        decoration: const InputDecoration(
                                          labelText: 'Edit Category',
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
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              controller.updateCategory(
                                                  data.id,
                                                  controller.categoryC.text,
                                                  'income');
                                              controller.categoryC.clear();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: greenColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                minimumSize: Size(0, 45)),
                                            child: const Text(
                                              'Income',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              controller.updateCategory(
                                                  data.id,
                                                  controller.categoryC.text,
                                                  'expense');
                                              controller.categoryC.clear();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: purpleColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                minimumSize: Size(0, 45)),
                                            child: const Text(
                                              'Expenses',
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
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.edit_rounded,
                                color: greyColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            title: 'Add Category',
            backgroundColor: whiteColor,
            contentPadding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            titleStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            content: Column(
              children: [
                TextFormField(
                  controller: controller.newCategoryC,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'New Category',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      fontFamily: 'Poppins',
                      // fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.addCategoy(
                            controller.newCategoryC.text, 'income');
                        controller.newCategoryC.clear();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: greenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(0, 45)),
                      child: const Text(
                        'Income',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.addCategoy(
                            controller.newCategoryC.text, 'expense');
                        controller.newCategoryC.clear();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: purpleColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(0, 45)),
                      child: const Text(
                        'Expenses',
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
              ],
            ),
          );
        },
        backgroundColor: greyColor,
        child: Icon(
          Icons.add,
          color: whiteColor,
          size: 30,
        ),
      ),
    );
  }
}
