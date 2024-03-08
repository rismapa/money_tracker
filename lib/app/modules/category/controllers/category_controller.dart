import 'package:budget_tracker/app/data/database/database.dart';
import 'package:budget_tracker/app/theme/theme.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final db = AppDb();
  TextEditingController categoryC = TextEditingController();
  TextEditingController newCategoryC = TextEditingController();

  Future<List<Category>> addCategoy(String category, String type) async {
    if (newCategoryC.text.isNotEmpty) {
      final row = await db
          .into(db.categories)
          .insert(CategoriesCompanion.insert(category: category, type: type));

      List<Category> allItems = await db.select(db.categories).get();

      print(allItems);
      Get.back();
      update();
      Get.snackbar('Success', 'Category has been save!', colorText: greyColor);
      return allItems;
    } else {
      Get.back();
      Get.snackbar('Error', 'The field is empty!', colorText: greyColor);
      return Future.error('The field is empy!');
    }
  }

  Future<List<Category>> getAllCategories() async {
    List<Category> allItems = await db.select(db.categories).get();
    return allItems;
  }

  Future deleteCategory(int id) async {
    await (db.categories
      ..delete()
      ..deleteWhere((tbl) => tbl.id.equals(id)));

    Get.back();
    update();
    Get.snackbar('Success', 'Category has been delete!', colorText: greyColor);
  }

  Future updateCategory(int id, String updateCategory, String newType) async {
    if (categoryC.text.isNotEmpty) {
      await (db.update(db.categories)..where((tbl) => tbl.id.equals(id))).write(
        CategoriesCompanion(
          category: drift.Value(updateCategory),
          type: drift.Value(newType),
        ),
      );

      Get.back();
      update();
      Get.snackbar('Success', 'Category has been updated!',
          colorText: greyColor);
    } else {
      Get.back();
      Get.snackbar('Error', 'The field is empty!', colorText: greyColor);
      return Future.error('The field is empy!');
    }
  }
}
