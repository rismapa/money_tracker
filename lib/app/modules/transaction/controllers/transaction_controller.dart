import 'dart:ffi';

import 'package:budget_tracker/app/data/database/database.dart';
import 'package:budget_tracker/app/data/database/transaction_with_category.dart';
import 'package:budget_tracker/app/modules/category/controllers/category_controller.dart';
import 'package:budget_tracker/app/theme/theme.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drift/drift.dart' as drift;

class TransactionController extends GetxController {
  final db = AppDb();
  final categoriesC = Get.put(CategoryController());

  TransactionWithCategory? dataEdit;
  Category? selectedCategory;

  TextEditingController dateC = TextEditingController();
  TextEditingController amountC = TextEditingController();
  TextEditingController descC = TextEditingController();

  Future<List<Transaction>> addTransaction(
      int categoryId, DateTime date, int amount, String description) async {
    DateTime now = DateTime.now();
    final row = await db.into(db.transactions).insert(
          TransactionsCompanion.insert(
              categoryId: categoryId,
              date: now,
              amount: amount,
              description: description),
        );

    List<Transaction> allItems = await db.select(db.transactions).get();
    print(allItems);

    Get.back();
    update();
    Get.snackbar('Success', 'Transaction has been save!', colorText: greyColor);
    return allItems;
  }

  Future updateTransaction(int id, int newCategoryId, DateTime newDate,
      int newAmount, String newDscription) async {
    await (db.update(db.transactions)..where((tbl) => tbl.id.equals(id))).write(
      TransactionsCompanion(
        categoryId: drift.Value(newCategoryId),
        date: drift.Value(newDate),
        amount: drift.Value(newAmount),
        description: drift.Value(newDscription),
      ),
    );

    Get.back();
    update();
    Get.snackbar('Success', 'Transaction has been update!',
        colorText: greyColor);
  }

  @override
  void onInit() {
    super.onInit();
    dataEdit = Get.arguments as TransactionWithCategory?;
  }
}
