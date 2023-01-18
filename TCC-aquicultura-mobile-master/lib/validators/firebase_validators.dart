import 'package:firebase_database/firebase_database.dart';

double temp, oxi;
final databaseReference = FirebaseDatabase.instance.reference();



void createTanque(id, temp, oxi){
  databaseReference.child('Tanque ' + id.toString()).set({
    'id': id,
    'oxi':  oxi,
    'temp': temp
  });
}

void getTanque(id){
  databaseReference.once().then((DataSnapshot snapshot) {
    print('Data : ${snapshot.value}');
    print('id aqui ' + id);
  });
}
// void getID(id){
//   final TanqueReference = FirebaseDatabase.instance.reference().child('Tanque ' + id.toString());
  
// }

void updateData(id){
  databaseReference.child('Tanque ' + id.toString()).update({
    'oxi':  0,
    'temp': 0
  });
}

void deleteTanque(id){
  databaseReference.child('Tanque ' + id.toString()).remove();
}

void getAllData() async{
  databaseReference.once().then((DataSnapshot snapshot) {
    print('Data : ${snapshot.value}');
  });
}