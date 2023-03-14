import 'package:financas_pessoais/controller/cor_saldo.dart';
import 'package:financas_pessoais/controller/saudacao.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    int altura = MediaQuery.of(context).size.height.toInt();
    double saldo = 2000;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: altura / 3.2,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 48, 128, 163),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 20,
                        right: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Container(
                            height: 40,
                            width: 40,
                            color: const Color.fromRGBO(250, 250, 250, 0.1),
                            child: const Icon(
                              Icons.notifications_none_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              saudacao(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                                color: Color.fromARGB(255, 224, 223, 223),
                              ),
                            ),
                            const Text(
                              'George Lincoln',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Center(
              heightFactor: 3,
              child: Container(
                padding: const EdgeInsets.only(left: 15),
                height: 170,
                width: 320,
                decoration: BoxDecoration(
                  color: corSaldo(saldo),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 7, left: 250),
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Text(
                        saldo.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 38,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(17),
                          child: Container(
                            height: 30,
                            width: 30,
                            color: const Color.fromRGBO(250, 250, 250, 0.1),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'icome',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
