import 'package:budget_tracker/app/data/database/database.dart';
import 'package:budget_tracker/app/data/database/transaction_with_category.dart';
import 'package:budget_tracker/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:budget_tracker/app/theme/theme.dart';
import 'package:drift/drift.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  final db = AppDb();

  Stream<List<TransactionWithCategory>> getTransactionCategory() {
    final query = db.select(db.transactions).join([
      innerJoin(
        db.categories,
        db.categories.id.equalsExp(db.transactions.categoryId),
      ),
    ]);

    query.orderBy([
      OrderingTerm(expression: db.transactions.date, mode: OrderingMode.desc)
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        final transaction = row.readTable(db.transactions);
        final category = row.readTable(db.categories);

        return TransactionWithCategory(
            row.readTable(db.transactions), row.readTable(db.categories));
      }).toList();
    });
  }

  Future deleteTransactionCategory(int id) async {
    await (db.transactions
      ..delete()
      ..deleteWhere((tbl) => tbl.id.equals(id)));

    Get.back();
    update();
    Get.snackbar('Success', 'Transaction has been delete!',
        colorText: greyColor);
  }
}
