import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/my_sizedbox.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/core/widgets/my_text_field.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/checkout.dart';
import 'package:e_commerce_school_project/features/products/presentation/blocs/cart_cubit.dart/cubit/cart_cubit.dart';
import 'package:e_commerce_school_project/features/products/presentation/blocs/complete_checkout_cubit/complete_checkout_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CompleteCheckout extends StatefulWidget {
  CompleteCheckout({super.key});

  @override
  State<CompleteCheckout> createState() => _CompleteCheckoutState();
}

class _CompleteCheckoutState extends State<CompleteCheckout> {
  late TextEditingController phoneNumber;
  late TextEditingController streetAddress;
  late TextEditingController houseNumber;
  late TextEditingController city;
  late TextEditingController province;
  late TextEditingController postalCode;

  @override
  void initState() {
    super.initState();
    phoneNumber = TextEditingController();
    streetAddress = TextEditingController();
    houseNumber = TextEditingController();
    city = TextEditingController();
    province = TextEditingController();
    postalCode = TextEditingController();
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    streetAddress.dispose();
    houseNumber.dispose();
    city.dispose();
    province.dispose();
    postalCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.themes();
    final lang = context.lang();
    void showCompleteCheckoutDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: theme.colorScheme.primary,
            title: Text(
              context.lang().thankYouForYourPurchase,
              style: TextStyles.blackW600(context).copyWith(fontSize: 15.sp),
              textAlign: TextAlign.center,
            ),
            content: Icon(
              Icons.check_circle_outline_sharp,
              color: theme.colorScheme.secondary,
              size: 80.sp,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  'OK',
                  style:
                      TextStyles.blackW600(context).copyWith(fontSize: 15.sp),
                ),
              ),
            ],
          );
        },
      );
    }

    return BlocListener<CompleteCheckoutCubit, CompleteCheckoutState>(
      listener: (context, state) {
        if (state is CompleteCheckoutSuccess) {
          showCompleteCheckoutDialog(context);
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: theme.colorScheme.primary,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: StatefulBuilder(
            builder: (BuildContext context, setState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightSize(60),
                    Text(
                      lang.shippingInformation,
                      style: TextStyles.blackW900(context)
                          .copyWith(fontSize: 25.sp),
                      maxLines: 1,
                    ),
                    heightSize(20),
                    Text(
                      lang.enterYourShippingInformationBelow,
                      style: TextStyles.blackW400(context)
                          .copyWith(fontSize: 12.sp),
                    ),
                    heightSize(20),
                    MyTextField(
                        onChanged: (p0) {
                          setState(
                            () => phoneNumber,
                          );
                        },
                        textInputAction: TextInputAction.next,
                        controller: phoneNumber,
                        maxLength: 10,
                        icon: Icon(Icons.phone),
                        prefixValue: '+39 ',
                        format: [FilteringTextInputFormatter.digitsOnly],
                        title: "123 456 7890"),
                    heightSize(20),
                    MyTextField(
                        onChanged: (p0) {
                          setState(
                            () => streetAddress,
                          );
                        },
                        textInputAction: TextInputAction.next,
                        icon: Icon(Icons.location_on),
                        controller: streetAddress,
                        title: lang.streetAddress),
                    heightSize(20),
                    MyTextField(
                        onChanged: (p0) {
                          setState(
                            () => houseNumber,
                          );
                        },
                        format: [FilteringTextInputFormatter.digitsOnly],
                        textInputAction: TextInputAction.next,
                        maxLength: 6,
                        icon: Icon(Icons.house),
                        controller: houseNumber,
                        title: lang.houseNumber),
                    heightSize(20),
                    MyTextField(
                        onChanged: (p0) {
                          setState(
                            () => city,
                          );
                        },
                        textInputAction: TextInputAction.next,
                        icon: Icon(Icons.location_city),
                        controller: city,
                        title: lang.city),
                    heightSize(20),
                    MyTextField(
                        onChanged: (p0) {
                          setState(
                            () => province,
                          );
                        },
                        textInputAction: TextInputAction.next,
                        icon: Icon(Icons.map),
                        controller: province,
                        title: lang.province),
                    heightSize(20),
                    MyTextField(
                        onChanged: (p0) {
                          setState(
                            () => postalCode,
                          );
                        },
                        textInputAction: TextInputAction.next,
                        icon: Icon(Icons.local_post_office),
                        controller: postalCode,
                        maxLength: 6,
                        format: [FilteringTextInputFormatter.digitsOnly],
                        title: lang.postalCode),
                    heightSize(30),
                    GestureDetector(
                        onTap: () {
                          List<Checkout> checkouts =
                              BlocProvider.of<CartCubit>(context).checkouts;
                          final now = DateTime.now();
                          final italyTime =
                              now.toUtc().add(const Duration(hours: 2));
                          final formatterTime = DateFormat('HH:mm:ss');
                          final formattedItalyTime =
                              formatterTime.format(italyTime);

                          final formatter = DateFormat('yyyy-MM-dd');
                          final formattedDate = formatter.format(now);

                          for (var element in checkouts) {
                            // ignore: prefer_interpolation_to_compose_strings
                            element.shippingAddress = " shippingAddress: " +
                                streetAddress.text.trim() +
                                ' houseNumber: ' +
                                houseNumber.text.trim() +
                                ' city: ' +
                                city.text.trim() +
                                ' province: ' +
                                province.text.trim() +
                                ' postalCode: ' +
                                postalCode.text.trim();

                            element.time = formattedItalyTime;

                            element.date = formattedDate;
                            element.phoneNumber = phoneNumber.text.trim();
                          }
                          print(checkouts.first.time);
                          BlocProvider.of<CompleteCheckoutCubit>(context)
                              .uploadCheckouts(checkouts: checkouts);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50.h,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: theme.shadowColor,
                                    offset: Offset.fromDirection(4, -6),
                                    blurRadius: 4)
                              ],
                              color: phoneNumber.text.isNotEmpty &&
                                      streetAddress.text.isNotEmpty &&
                                      houseNumber.text.isNotEmpty &&
                                      province.text.isNotEmpty &&
                                      postalCode.text.isNotEmpty &&
                                      city.text.isNotEmpty
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.primary,
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(400.h),
                                  right: Radius.circular(400.h))),
                          alignment: Alignment.center,
                          child: FittedBox(
                              child: Text(
                            lang.checkout,
                            style: phoneNumber.text.isNotEmpty &&
                                    streetAddress.text.isNotEmpty &&
                                    houseNumber.text.isNotEmpty &&
                                    province.text.isNotEmpty &&
                                    postalCode.text.isNotEmpty &&
                                    city.text.isNotEmpty
                                ? TextStyles.whiteW500(context)
                                    .copyWith(fontSize: 13.sp)
                                : TextStyles.blackW500(context)
                                    .copyWith(fontSize: 13.sp),
                          )),
                        ))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
