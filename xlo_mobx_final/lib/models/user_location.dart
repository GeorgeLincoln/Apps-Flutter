import 'city.dart';
import 'uf.dart';

class UserLocation {
  City city;
  UF uf;

  UserLocation({this.city, this.uf});

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
        city: City.fromJson(json['city']), uf: UF.fromJson(json['uf']));
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'city': city.toJson(), 'uf': uf.toJson()};
  }
}
