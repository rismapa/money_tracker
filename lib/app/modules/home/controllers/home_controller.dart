import 'package:budget_tracker/app/data/database/database.dart';
import 'package:budget_tracker/app/data/database/transaction_with_category.dart';
import 'package:budget_tracker/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:drift/drift.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final db = AppDb();

  RxInt totalIncome = 0.obs;

  Stream<List<TransactionWithCategory>> getTransactionsByCategory(String type) {
    final db = AppDb();
    final query = db.select(db.transactions).join([
      innerJoin(
        db.categories,
        db.categories.id.equalsExp(db.transactions.categoryId),
      ),
    ]);

    // Masukkan kriteria where ke dalam query
    query.where(db.categories.type.equals(type));

    return query.watch().map((rows) {
      return rows.map((row) {
        final transaction = row.readTable(db.transactions);
        final category = row.readTable(db.categories);

        return TransactionWithCategory(
            row.readTable(db.transactions), row.readTable(db.categories));
      }).toList();
    });
  }

  void calculateTotalIncome() async {
    final transactionsStream = getTransactionsByCategory('income');

    int total = 0;
    transactionsStream.listen((List<TransactionWithCategory> transactions) {
      for (TransactionWithCategory transaction in transactions) {
        total += transaction.transaction.amount;
      }
      totalIncome.value = total;
    });

    totalIncome.value = total;
  }

  @override
  void onInit() {
    super.onInit();
    calculateTotalIncome();
    // calculateTotalExpense();
  }
}
