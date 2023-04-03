import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/models/uf.dart';
import 'package:xlo_mobx/models/user_location.dart';
import 'package:xlo_mobx/repositories/ibge_repository.dart';

import 'connectivity_store.dart';

part 'location_store.g.dart';

enum LocationStatus { INIT, INIT_DONE, RETRIEVING, DONE, FAILED }

class LocationStore = _LocationStore with _$LocationStore;

abstract class _LocationStore with Store {
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  _LocationStore() {
    autorun((_) {
      if (connectivityStore.connected && status == LocationStatus.INIT) {
        Geolocator.checkPermission().then((permission) async {
          if (permission == LocationPermission.whileInUse ||
              permission == LocationPermission.always) {
            getLocation();
          } else {
            //Busca localização do usuário salva ou abre tela de seleção
            SharedPreferences.getInstance().then((prefs) {
              if (prefs.getKeys().contains('user_location')) {
                final userLocation = UserLocation.fromJson(
                    json.decode(prefs.getString('user_location')));

                Address _address =
                    Address(uf: userLocation.uf, city: userLocation.city);
                if (_address.city != null && _address.uf != null) {
                  setLocation(_address);
                  setStatus(LocationStatus.DONE);
                  return;
                }
              }
              print('setStatus(LocationStatus.INIT_DONE)');
              setStatus(LocationStatus.INIT_DONE);
            });
          }
        });
      }
    });
  }

  @observable
  Address location;

  @action
  void setLocation(Address value) {
    location = value;
    //salvar a última localização do usuário
    _saveAddress(value);
    status = LocationStatus.DONE;
  }

  @observable
  LocationStatus status = LocationStatus.INIT;

  @action
  void setStatus(LocationStatus value) => status = value;

  @computed
  bool get showLocationScreen => status == LocationStatus.INIT_DONE;

  @computed
  bool get exitLocationScreen =>
      status == LocationStatus.DONE && location != null;

  @computed
  bool get readyToFetchAds =>
      status == LocationStatus.DONE || status == LocationStatus.FAILED;

  Future<void> getLocation() async {
    if (status == LocationStatus.RETRIEVING) return;
    setStatus(LocationStatus.RETRIEVING);

    try {
      Future.delayed(Duration(seconds: 15)).then((_) {
        if (status != LocationStatus.DONE) {
          setStatus(LocationStatus.FAILED);
        }
      });

      final Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);

      if (status == LocationStatus.FAILED) return;

      final List<Placemark> places = await placemarkFromCoordinates(
          pos.latitude, pos.longitude,
          localeIdentifier: 'pt_BR');
      Placemark place = places?.first;

      if (place != null) {
        List<UF> ufs = await IBGERepository().getUFList();

        UF locationUF;
        City locationCity;

        //Diferença na API de localização entre as Plataformas e entre regioes
        if (place.locality.isNotEmpty) {
          locationCity = City(name: place.locality);
        } else {
          locationCity = City(name: place.subAdministrativeArea);
        }

        if (place.administrativeArea.length == 2) {
          locationUF =
              ufs.firstWhere((uf) => uf.initials == place.administrativeArea);
        } else {
          locationUF =
              ufs.firstWhere((uf) => uf.name == place.administrativeArea);
        }

        final Address address = Address(
            district: place.administrativeArea,
            cep: place.postalCode.formattedPostalCode(),
            city: locationCity,
            uf: locationUF);
        setLocation(address);
        print('Location DONE');
        setStatus(LocationStatus.DONE);
      } else {
        print('Location FAILED');
        setStatus(LocationStatus.FAILED);
      }
    } catch (e) {
      print('Location FAILED');
      print('getLocation failed: ${e.toString()}');
      setStatus(LocationStatus.FAILED);
    }
  }

  void _saveAddress(Address address) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('user_location',
          json.encode(UserLocation(city: address.city, uf: address.uf)));
    });
  }
}
