import 'package:intl/intl.dart';

extension StringExtension on String {
  bool isEmailValid() {
    final RegExp regex = RegExp(
        r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
    return regex.hasMatch(this);
  }

  String formattedPostalCode() {
    String postalCode = this.trim().replaceAll('.', '').replaceAll('-', '');

    if (this.length != 8)
      postalCode = (postalCode + '000').substring(0, 8);
    else
      postalCode = this;
    return '${postalCode.substring(0, 2)}.${postalCode.substring(2, 5)}-${postalCode.substring(5, 8)}';
  }
}

extension NumberExtension on num {
  String formattedMoney() {
    return NumberFormat('R\$###,##0.00', 'pt-BR').format(this);
  }
}

extension DateTimeExtension on DateTime {
  String formattedDate() {
    return DateFormat('dd/MM/yyyy HH:mm', 'pt-BR').format(this.toLocal());
  }

  String formattedMessageDate() {
    final difference = this.difference(DateTime.now()).inDays;

    if (difference == 0) {
      return DateFormat('HH:mm', 'pt-BR').format(this.toLocal());
    } else if (difference == 1) {
      return 'Ontem';
    } else if (difference <= 7) {
      return DateFormat('EEEE', 'pt-BR').format(this.toLocal());
    } else {
      return DateFormat('dd/MM/yyyy', 'pt-BR').format(this.toLocal());
    }
  }

  String formattedChatDate() {
    final difference = this.difference(DateTime.now()).inDays;

    if (difference == 0) {
      return DateFormat('HH:mm', 'pt-BR').format(this.toLocal());
    } else if (difference == 1) {
      return 'Ontem';
    } else if (difference <= 7) {
      return DateFormat('EEEE', 'pt-BR').format(this.toLocal());
    } else {
      return DateFormat('E, dd/MM/yy', 'pt-BR').format(this.toLocal());
    }
  }
}
