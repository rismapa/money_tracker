import 'package:budget_tracker/app/data/database/database.dart';

class TransactionWithCategory {
  final Transaction transaction;
  final Category category;

  TransactionWithCategory(this.transaction, this.category);
}
