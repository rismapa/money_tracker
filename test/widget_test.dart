// import 'package:budget_tracker/app/data/database/database.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
// // 
//   final database = AppDb();

//   await database
//       .into(database.categories)
//       .insert(CategoriesCompanion.insert(category: 'foods', type: true));
//   List<Category> allItems = await database.select(database.categories).get();

//   print('items in database: $allItems');
// }
