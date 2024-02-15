import 'package:budget_tracker/app/routes/app_pages.dart';
import 'package:budget_tracker/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
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
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, bottom: 20),
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
                            child: SvgPicture.asset(
                              "assets/images/income.svg",
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
                            child: SvgPicture.asset(
                              "assets/images/wallet.svg",
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
      ),
    );
  }
}
