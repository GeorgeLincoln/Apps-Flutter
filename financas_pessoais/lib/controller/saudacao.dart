String saudacao() {
  int data = DateTime.now().hour;
  if (data > 0 && data < 12) {
    return 'Bom dia';
  }
  if (data >= 12 && data < 18) {
    return 'Boa tarde';
  }
  if (data >= 18 && data < 24) {
    return 'Boa noite';
  }
  return '';
}
