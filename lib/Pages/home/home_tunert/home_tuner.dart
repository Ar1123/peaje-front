import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:peaje/config/shared/preferences.dart';
import 'package:peaje/models/category.dart';
import 'package:peaje/providers/arrivals.dart';
import 'package:peaje/providers/category.dart';
import 'package:peaje/providers/login.dart';
import 'package:peaje/providers/vehicle.dart';
import 'package:peaje/widgets/widgets.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../models/vehicle.dart';
import '../../index/index_page.dart';

class HomeTunero extends StatefulWidget {
  const HomeTunero({Key? key}) : super(key: key);
  @override
  State<HomeTunero> createState() => _HomeTuneroState();
}

class _HomeTuneroState extends State<HomeTunero> {
  late Size _size;
  final _vehicleProvider = VehicleProvider();
  final _categoryProvider = CategoryProvider();
  late Future<VehicleModel> _vehicle;
  BodyV _vehicleSelected = BodyV();
  Category _category = Category();
  final _loginProvider = LoginProvider();
  final _arrivalProvider = ArrivalsProvider();
  bool _loading = false;
  final _pref = Preferences();
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _vehicle = _vehicleProvider.geVehicled();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: _size.height * .05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: _size.width * .45,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Vehiculos",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xff020202),
                              fontSize: _size.height * .05,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _size.height * .02,
                        ),
                        Container(
                          width: _size.width,
                          height: _size.height * .8,
                          padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(
                            horizontal: _size.width * .02,
                            vertical: _size.height * .02,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xff066124),
                              width: 1,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x3f000000),
                                blurRadius: 0.30,
                                offset: Offset(-3, 4),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: FutureBuilder<VehicleModel>(
                            future: _vehicle,
                            builder: (_, snp) {
                              if (!snp.hasData) {
                                return const LoadingW();
                              }
                              if (snp.data!.body!.isNotEmpty) {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 250,
                                    childAspectRatio: 2 / 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemCount: snp.data!.body!.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return Column(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () async {
                                              _vehicleSelected =
                                                  snp.data!.body![index];

                                              _category =
                                                  await _categoryProvider
                                                      .getCategoryById(
                                                id: snp.data!.body![index]
                                                    .idCategoy!,
                                              );
                                              setState(() {});
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text("$index"),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Categoria: ${snp.data!.body![index].category}",
                                        )
                                      ],
                                    );
                                  },
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: _size.width * .04),
                    padding: const EdgeInsets.all(7),
                    alignment: Alignment.centerLeft,
                    width: _size.width * .5,
                    child: Column(
                      children: [
                        Text(
                          "Descripción",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xff020202),
                            fontSize: _size.height * .05,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: _size.height * .02,
                        ),
                        Container(
                          width: _size.width * .7,
                          height: _size.height * .25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xff066124),
                              width: 1,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x3f000000),
                                blurRadius: 2,
                                offset: Offset(10, 10),
                              ),
                            ],
                            color: const Color(0xfffffcfc),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  left: _size.width * .02,
                                ),
                                width: _size.width * .17,
                                height: _size.height * .2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xffd9d9d9),
                                ),
                              ),
                              SizedBox(
                                width: _size.width * .01,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: _size.height * .07,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: "Categoria: ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text:
                                              "${(_vehicleSelected.axles != null) ? _vehicleSelected.category : ""}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: _size.width * .2,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: "Descripción: ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextSpan(
                                            text:
                                                "${(_vehicleSelected.axles != null) ? _vehicleSelected.description : ""}",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: "Ejes: ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text:
                                              "${(_vehicleSelected.axles != null) ? _vehicleSelected.axles : ""}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: _size.height * .1,
                        ),
                        Text(
                          "Costo peaje",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: _size.height * .06,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "\$${(_category.msg != null) ? _category.body!.price.toString() : ""}",
                          style: TextStyle(
                            fontSize: _size.height * .06,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ButtonEidget(
                          width: _size.width * .3,
                          action: () async {
                            if (_category.body == null) {
                              showTopSnackBar(
                                context,
                                const CustomSnackBar.error(
                                  message: "Selecciona un vehiculo",
                                ),
                              );
                              return;
                            }
                            final token = _pref.getKeyString("token");
                            final decodeToken = JwtDecoder.decode(token!);
                            _loading = true;

                            setState(() {});
                            await Future.delayed(const Duration(seconds: 2));
                            final sendData = await _arrivalProvider.addArrival(
                              data: {
                                "date": DateTime.now().toIso8601String(),
                                "hora": TimeOfDay.now().format(context),
                                "idCategory": _category.body!.id,
                                "category": _category.body!.category,
                                "price": _category.body!.price,
                                "idTurnero": decodeToken["userId"]
                              },
                            );
                            if (sendData) {
                              _loading = false;
                              _category = Category();
                              _vehicleSelected = BodyV();
                              setState(() {});
                            }
                          },
                          txt: "Pagar",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: _size.height * .02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/logo_unicor.png",
                    height: _size.height * .1,
                  ),
                  GestureDetector(
                    onTap: () async {
                      _loading = true;
                      setState(() {});
                      final result =
                          await _loginProvider.closeSession(context: context);
                      await Future.delayed(const Duration(seconds: 2));
                      if (result) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const IndexPage()),
                            (route) => false);
                      } else {
                        showTopSnackBar(
                          context,
                          CustomSnackBar.error(
                            message: "Ups, no se pudo cerrar sesión ",
                          ),
                        );
                      }
                      _loading = false;
                      setState(() {});
                    },
                    child: Image.asset(
                      "assets/exit.png",
                      height: _size.height * .1,
                    ),
                  ),
                ],
              ),
            ),
            (_loading)
                ? Container(
                    color: Colors.black.withOpacity(.7),
                    child: const LoadingW(),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
