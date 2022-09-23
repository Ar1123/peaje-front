import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:peaje/Pages/home/home_admin/home_admin.dart';
import 'package:peaje/Pages/login/login_page.dart';
import 'package:peaje/config/shared/preferences.dart';
import 'package:peaje/providers/login.dart';
import 'package:peaje/widgets/widgets.dart';

import '../home/home_tunert/home_tuner.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  late Size _size;
  final _loginProviser = LoginProvider();

  late Future<bool> _future;
  @override
  void initState() {
    super.initState();
    _init();
  }

  final _pref = Preferences();
  void _init() {
    _future = _loginProviser.sessionActive();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: FutureBuilder<bool>(
          future: _future,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const LoadingW();
            }

            if (!snapshot.data!) {
              Future.delayed(const Duration(seconds: 2), () {
                final decode = JwtDecoder.decode(_pref.getKeyString("token")!);
                if (decode["rol"] == "ADMIN") {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeAdminage()),
                      (route) => false);
                } else {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeTunero()),
                      (route) => false);
                }
              });
              return const LoadingW();
            }
            return Column(
              children: [
                SizedBox(
                  height: _size.height * .1,
                ),
                Image.asset(
                  "assets/PEAJE_UNICORDOBA.png",
                ),
                SizedBox(
                  height: _size.height * .04,
                ),
                Image.asset(
                  "assets/logo_unicor.png",
                  height: _size.height * .3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: (() => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginPage(rol: "ADMIN")))),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/admin.png",
                          ),
                          const Text("Soy Admin")
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (() => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  const LoginPage(rol: "TURNERO")))),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/turnero.png",
                          ),
                          const Text("Soy Turnero")
                        ],
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
    ));
  }
}
