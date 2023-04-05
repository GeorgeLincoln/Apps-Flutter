import 'package:diacritic/diacritic.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/models/uf.dart';
import 'package:xlo_mobx/repositories/ibge_repository.dart';

part 'uf_city_store.g.dart';

class UfCityStore = _UfCityStore with _$UfCityStore;

abstract class _UfCityStore with Store {
  _UfCityStore(UF uf, this.showAll) {
    setItem(uf);
  }

  final IBGERepository ibge = IBGERepository();

  bool showAll;

  ObservableList outList = ObservableList();

  @action
  void setOutList(List items) {
    outList.addAll(items);
  }

  @observable
  String search = "";

  @action
  void setSearch(String value) =>
      search = removeDiacritics(value.toLowerCase());

  @observable
  UF uf;

  @observable
  City city;

  @action
  void setItem(dynamic value) {
    if (value == null) {
      uf = null;
      outList.clear();
      ibge.getUFList().then(setOutList).catchError(setError);
    } else if (uf == null) {
      uf = value;
      outList.clear();
      ibge.getCityList(uf).then(setOutList).catchError(setError);
    } else {
      city = value;
    }
    setSearch('');
  }

  @computed
  List get outFiltered {
    if (search.isEmpty) if (!showAll)
      return outList;
    else if (uf == null)
      return List.from(outList)..insert(0, UF(name: 'Todos', id: -1));
    else
      return List.from(outList)..insert(0, City(name: 'Todas', id: -1));
    else
      return outList
          .where(
              (uf) => removeDiacritics(uf.name.toLowerCase()).contains(search))
          .toList();
  }

  @observable
  String error;

  void setError(var value) => error = value;
}
