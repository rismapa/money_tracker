import 'package:budget_tracker/app/data/database/categories.dart';
import 'package:drift/drift.dart';


class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer().references(Categories, #id)();
  DateTimeColumn get date => dateTime()();
  IntColumn get amount => integer()();
  TextColumn get description => text()();
}
