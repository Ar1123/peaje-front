// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:peaje/providers/login.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../providers/open_or_close_turno.dart';
import '../../widgets/widgets.dart';
import '../home/home_admin/home_admin.dart';
import '../home/home_tunert/home_tuner.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.rol}) : super(key: key);
  final String rol;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Size _size;
  final _loginProvider = LoginProvider();
  final _opelTurno = OpenOrCloseTurno();
  final userCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: Stack(
          children: [
            Center(
              child: Image.asset(
                "assets/fondo.png",
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                "assets/admin.png",
                height: _size.height * .14,
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
                    height: _size.height * .14,
                  ),
                  Image.asset(
                    "assets/turnero.png",
                    height: _size.height * .14,
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/PEAJE_UNICORDOBA.png",
                    height: _size.height * .10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      // ignore: sort_child_properties_last
                      child: Column(
                        children: [
                          SizedBox(
                            height: _size.height * .01,
                          ),
                          Image.asset(
                            "assets/icono.png",
                            height: _size.height * .10,
                          ),
                          SizedBox(
                            height: _size.height * .01,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: _size.width * .03,
                            ),
                            child: InputWidget(
                              textEditingController: userCtrl,
                              text: "Usuario",
                            ),
                          ),
                          SizedBox(
                            height: _size.height * .02,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: _size.width * .03,
                            ),
                            child: InputWidget(
                              textEditingController: passCtrl,
                              text: "Contraseña",
                            ),
                          ),
                          SizedBox(
                            height: _size.height * .02,
                          ),
                          ButtonEidget(
                            action: () async {
                              final result = await _loginProvider.sendInfoLogin(
                                  data: {
                                    "user": userCtrl.text,
                                    "password": passCtrl.text,
                                    "rol": widget.rol
                                  });
                              if (result) {
                                if (widget.rol == "TURNERO") {
                                  await _opelTurno.openTurn(data: {
                                    "inicio": {
                                      // ignore: use_build_context_synchronously
                                      "hora": TimeOfDay.now().format(context),
                                      "fecha": DateTime.now().toIso8601String(),
                                    }
                                  });
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const HomeTunero(),
                                      ),
                                      (route) => false);
                                } else {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const HomeAdminage(),
                                      ),
                                      (route) => false);
                                }
                              } else {
                                showTopSnackBar(
                                  context,
                                  const CustomSnackBar.error(
                                    message: "Ups, revisa tus datos ",
                                  ),
                                );
                              }
                            },
                            txt: "Ingresar",
                            width: _size.width * .2,
                          )
                        ],
                      ),
                      height: _size.height * .41,
                      width: _size.width * .4,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.15),
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: const Offset(
                                10,
                                10,
                              ))
                        ],
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                          stops: [0, 1],
                          colors: [
                            Color.fromRGBO(145, 176, 241, 100),
                            Color.fromRGBO(145, 176, 241, 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
