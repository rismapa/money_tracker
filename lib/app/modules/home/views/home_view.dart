import 'package:budget_tracker/app/routes/app_pages.dart';
import 'package:budget_tracker/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // section 1
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 165,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: greyColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Available Balance',
                              style: TextStyle(
                                  color: whiteColor.withOpacity(0.8),
                                  fontFamily: 'Poppins',
                                  fontSize: 17),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Rp. 300.000',
                              style: TextStyle(
                                color: whiteColor,
                                fontFamily: 'Poppins',
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Text(
                              'See Details',
                              style: TextStyle(
                                  color: whiteColor,
                                  fontFamily: 'Poppins',
                                  fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 40,
                        child: SvgPicture.asset('assets/images/line.svg'),
                      ),
                      Positioned(
                        right: 0,
                        child: SvgPicture.asset('assets/images/plant.svg'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 18,
              ),
              // section 2
              Text(
                'Menus',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: greyColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => Get.toNamed(Routes.CATEGORY),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFD9D1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_tree_rounded,
                              color: greyColor,
                              size: 40,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Categories',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: greyColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Get.toNamed(Routes.TRANSACTION);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFD9D1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.attach_money_rounded,
                              color: greyColor,
                              size: 40,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Transactions',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: greyColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Get.toNamed(Routes.HISTORY);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFD9D1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.history_rounded,
                              color: greyColor,
                              size: 40,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'History',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: greyColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 18,
              ),
              // section 2
              Text(
                'Cash',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: greyColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),

              // section 3
              Container(
                height: 80,
                width: Get.width,
                decoration: BoxDecoration(
                  color: softGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: greenColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_downward_rounded,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => Text(
                              '${controller.totalIncome}',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: greyColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Income',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: greyColor,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              // section 4
              Container(
                height: 80,
                width: Get.width,
                decoration: BoxDecoration(
                  color: softPurple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: purpleColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_upward_rounded,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Rp. 4.000.000',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: greyColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Expense',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: greyColor,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // section 5
              const SizedBox(
                height: 18,
              ),
              Text(
                'Activies',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: greyColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),

              FloatingActionButton(
                onPressed: () => Get.toNamed(Routes.TRANSACTION),
                child: Icon(Icons.arrow_circle_left_rounded),
              )
            ],
          ),
        ],
      ),
    );
  }
}
