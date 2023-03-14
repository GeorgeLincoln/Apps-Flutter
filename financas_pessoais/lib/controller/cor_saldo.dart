import 'package:flutter/material.dart';

Color corSaldo(double saldo) {
  if (saldo < 0) {
    return const Color.fromARGB(255, 125, 50, 45);
  } else if (saldo == 0) {
    return const Color.fromARGB(255, 45, 125, 89);
  } else {
    return const Color.fromARGB(255, 45, 101, 125);
  }
}
