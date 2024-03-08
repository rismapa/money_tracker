import 'package:budget_tracker/app/data/database/transaction_with_category.dart';
import 'package:budget_tracker/app/routes/app_pages.dart';
import 'package:budget_tracker/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          'Histories',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder<List<TransactionWithCategory>>(
        stream: controller.getTransactionCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.length == 0) {
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
              TransactionWithCategory data = snapshot.data![index];

              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8),
                child: Container(
                  height: 70,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: (data.category.type == 'income')
                          ? softGreen
                          : softPurple,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 10),
                            child: Stack(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: (data.category.type == 'income')
                                          ? greenColor
                                          : purpleColor,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Icon(
                                      (data.category.type == 'income')
                                          ? Icons.arrow_downward_rounded
                                          : Icons.arrow_upward_rounded,
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data.transaction.description}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: greyColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Rp. ${NumberFormat("#,##0", "id_ID").format(data.transaction.amount)}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: greyColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Category: ${data.category.category}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: greyColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.toNamed(Routes.TRANSACTION,
                                  arguments: snapshot.data![index]);
                            },
                            icon: Icon(
                              Icons.edit_rounded,
                              color: greyColor,
                            ),
                          ),
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
                                    'Your data will lost when you delete transaction history',
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            .deleteTransactionCategory(
                                                data.transaction.id),
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
    );
  }
}
