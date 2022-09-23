import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:peaje/config/shared/preferences.dart';
import 'package:peaje/widgets/widgets.dart';

class HomeAdminage extends StatefulWidget {
  const HomeAdminage({Key? key}) : super(key: key);

  @override
  State<HomeAdminage> createState() => _HomeAdminageState();
}

class _HomeAdminageState extends State<HomeAdminage> {
  late Size _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                        child: const Text("Recaudo por categoria y turnos")),
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
                            data: const [
                              {'domain': 'A', 'measure': 1250000},
                              {'domain': 'B', 'measure': 12500000},
                              {'domain': 'C', 'measure': 3500000},
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
                                const Text("Categoria A")
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
                                const Text("Categoria B")
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
                                const Text("Categoria C")
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
                          child: Text("Turno 1: \$ 120.000.000"),
                        ),
                        SizedBox(
                          height: _size.height * .03,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Turno 2: \$ 120.000.000"),
                        ),
                        SizedBox(
                          height: _size.height * .03,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Total: \$ 240.000.000"),
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
                            data: const [
                              {'domain': 'A', 'measure': 1250000},
                              {'domain': 'B', 'measure': 1500000},
                            ],
                            fillColor: (pieData, index) {
                              switch (pieData['domain']) {
                                case 'A':
                                  return Colors.green;
                                case 'B':
                                  return Colors.blue;

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
                          child: Text("Categoria A: \$ 12"),
                        ),
                        SizedBox(
                          height: _size.height * .03,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Categoria B: \$ 12"),
                        ),
                        SizedBox(
                          height: _size.height * .03,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Categoria C: \$ 12"),
                        ),
                        SizedBox(
                          height: _size.height * .03,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("Total: \$ 36"),
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
        ),
      ),
    );
  }
}
