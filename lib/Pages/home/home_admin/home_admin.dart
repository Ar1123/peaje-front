import 'dart:developer';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peaje/models/user.dart';
import 'package:peaje/providers/arrivals.dart';
import 'package:peaje/providers/login.dart';
import 'package:peaje/providers/user.dart';
import 'package:peaje/widgets/widgets.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../models/arrive.dart';
import '../../index/index_page.dart';

class HomeAdminage extends StatefulWidget {
  const HomeAdminage({Key? key}) : super(key: key);

  @override
  State<HomeAdminage> createState() => _HomeAdminageState();
}

class _HomeAdminageState extends State<HomeAdminage> {
  late Size _size;
  final _arrivalProvider = ArrivalsProvider();
  final _userProvider = UserProvider();
  late Future<Arrive> _future;
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    _future = _arrivalProvider.getReport();
  }

  bool lleno = false;
  int totalCatA = 0;
  int totalCatB = 0;
  int totalCatC = 0;
  int totalTurn1 = 0;
  int totalCata = 0;
  int totalCatb = 0;
  int totalCatc = 0;

  List<String> tTurnos = [];
  List<int> vTurnos = [];
  List<Map<String, dynamic>> lisT = [];

  final formatter = NumberFormat("#,##0", "es_AR");

  void _llenarCategorias({required List<PorCate> body}) {
    totalTurn1 = 0;
    for (var element in body) {
      totalTurn1 += element.count!;
      if (element.id!.category == "A") {
        totalCatA = element.count!;
      }
      if (element.id!.category == "B") {
        totalCatB = element.count!;
      }
      if (element.id!.category == "C") {
        totalCatC = element.count!;
      }
    }
  }

  void _llenarTotoalCategorias({required List<PorCate> body}) {
    for (var element in body) {
      if (element.id!.category == "A") {
        totalCata = element.count!;
      }
      if (element.id!.category == "B") {
        totalCatb = element.count!;
      }
      if (element.id!.category == "C") {
        totalCatc = element.count!;
      }
    }
  }

  void _llenarTotalTurnos({required List<ValTurno> body}) {
    for (var element in body) {
      lisT.add({
        'measure': element.count!.toInt(),
        'domain': element.id!.idTurno,
      });
    }
  }

  bool _loading = false;
  final _loginProvider = LoginProvider();

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            FutureBuilder<Arrive>(
                future: _future,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return LoadingW();
                  }
                  if (snapshot.data!.body!.porCate!.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: _size.height * .1,
                          ),
                          Text(
                            "Sin reportes aun",
                            style: TextStyle(
                                fontSize: _size.height * .07,
                                fontWeight: FontWeight.bold),
                          ),
                          Image.asset("assets/404.png"),
                          ButtonEidget(
                            width: _size.width * .3,
                            action: () {},
                            txt: "Refrescar",
                          )
                        ],
                      ),
                    );
                  }
                  if (!lleno) {
                    _llenarCategorias(
                      body: snapshot.data!.body!.priceByCar!,
                    );

                    _llenarTotoalCategorias(
                      body: snapshot.data!.body!.porCate!,
                    );
                    _llenarTotalTurnos(
                      body: snapshot.data!.body!.vehiT!,
                    );
                    lleno = true;
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: _size.height * .1,
                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                      "Recaudo por categoria y turnos")),
                              SizedBox(
                                height: _size.height * .03,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: _size.height * .3,
                                    width: _size.width * .3,
                                    child: DChartPie(
                                      labelPosition: PieLabelPosition.outside,
                                      data: [
                                        {
                                          'domain': 'A',
                                          // ignore: unrelated_type_equality_checks
                                          'measure': totalCatA,
                                        },
                                        {'domain': 'B', 'measure': totalCatB},
                                        {'domain': 'C', 'measure': totalCatC},
                                      ],
                                      fillColor: (pieData, index) {
                                        switch (pieData['domain']) {
                                          case 'A':
                                            return Colors.green;
                                          case 'B':
                                            return Colors.blue;
                                          case 'C':
                                            return Colors.red;
                                          default:
                                            return Colors.red;
                                        }
                                      },
                                      animate: true,
                                      showLabelLine: true,
                                      strokeWidth: 4,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 29,
                                            height: 19,
                                            color: Colors.green,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              "Categoria A: \$ ${formatter.format(totalCatA)}")
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 29,
                                            height: 19,
                                            color: Colors.blue,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              "Categoria B: \$ ${formatter.format(totalCatB)}")
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 29,
                                            height: 19,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              "Categoria C: \$ ${formatter.format(totalCatC)}")
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: _size.height * .03,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: _size.height * .2,
                                    width: _size.width * .3,
                                    child: ListView.builder(
                                      itemCount:
                                          snapshot.data!.body!.valTurno!.length,
                                      itemBuilder: (_, index) => ListTile(
                                        title: FutureBuilder<UserModel>(
                                          future: _userProvider.getUser(
                                              id: snapshot
                                                  .data!
                                                  .body!
                                                  .valTurno![index]
                                                  .id!
                                                  .idTurno!),
                                          builder: (_, snp2) {
                                            if (snapshot.hasData) {
                                              if (snp2.data == null) {
                                                return SizedBox();
                                              } else {
                                                return Text(
                                                    "${snp2.data!.user}:\$ ${formatter.format(snapshot.data!.body!.valTurno![index].count)}");
                                              }
                                            } else {
                                              return SizedBox();
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: _size.width * .3,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        "Total: \$ ${formatter.format(totalTurn1)}"),
                                  ),
                                ],
                              )
                            ],
                          ),

                          //________________*****

                          Column(
                            children: [
                              SizedBox(
                                height: _size.height * .1,
                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text("Total vehiculos hoy")),
                              SizedBox(
                                height: _size.height * .03,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: _size.height * .3,
                                    width: _size.width * .3,
                                    child: DChartPie(
                                      labelPosition: PieLabelPosition.outside,
                                      data: lisT,
                                      fillColor: (pieData, index) {
                                        if (lisT.length == 1 &&
                                            pieData.containsValue(snapshot.data!
                                                .body!.vehiT![0].id!.idTurno)) {
                                          return Colors.green;
                                        } else if (lisT.length == 2 &&
                                            pieData.containsValue(snapshot.data!
                                                .body!.vehiT![1].id!.idTurno)) {
                                          return Colors.blue;
                                        } else {
                                          return Colors.green;
                                        }
                                      },
                                      animate: true,
                                      showLabelLine: true,
                                      strokeWidth: 4,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 29,
                                            height: 19,
                                            color: Colors.green,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text("Turno 1")
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 29,
                                            height: 19,
                                            color: Colors.blue,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text("Turno 2")
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: _size.height * .03,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Categoria A: $totalCata"),
                                  ),
                                  SizedBox(
                                    height: _size.height * .03,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Categoria B:  $totalCatb"),
                                  ),
                                  SizedBox(
                                    height: _size.height * .03,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Categoria C:  $totalCatc"),
                                  ),
                                  SizedBox(
                                    height: _size.height * .03,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        "Total: ${snapshot.data!.body!.totalV!}"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _size.height * .1,
                      ),
                      ButtonEidget(
                        width: _size.width * .3,
                        action: () {},
                        txt: "Refrescar",
                      )
                    ],
                  );
                }),
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
          ],
        ),
      ),
    );
  }
}
