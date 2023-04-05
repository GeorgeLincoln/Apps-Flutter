import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/connectivity_store.dart';
import 'package:xlo_mobx/stores/filter_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import 'location_store.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();
  final LocationStore locationStore = GetIt.I<LocationStore>();
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  _HomeStore() {
    reaction((_) => locationStore.location, (location) {
      if (location != null) {
        setFilter(filter.copyWith(city: location.city, uf: location.uf));
      }
    });

    autorun((_) async {
      setLoading(true);
      //Aguardar até que a localização seja obtida
      if (!locationStore.readyToFetchAds) return;
      //Aguardar até que a sessão do usuário
      // seja validada e impede erros de sessão
      if (!userManagerStore.readyToFetchAds) return;
      try {
        final newAds = await AdRepository().getHomeAdList(
          filter: filter,
          search: search,
          category: category,
          page: page,
        );
        addNewAds(newAds);
        setError(null);
        setLoading(false);
      } catch (e) {
        setError(e.toString());
      }
    });
  }

  ObservableList<Ad> adList = ObservableList<Ad>();

  @observable
  String search = '';

  @action
  void setSearch(String value) {
    search = value;
    resetPage();
  }

  @observable
  Category category;

  @action
  void setCategory(Category value) {
    category = value;
    resetPage();
  }

  @observable
  FilterStore filter = FilterStore();

  FilterStore get clonedFilter => filter.clone();

  @action
  void setFilter(FilterStore value) {
    resetPage();
    filter = value;
  }

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  int page = 0;

  @observable
  bool lastPage = false;

  @action
  void loadNextPage() {
    page++;
  }

  @action
  void addNewAds(List<Ad> newAds) {
    if (newAds.length < 10) lastPage = true;
    adList.addAll(newAds);
  }

  @computed
  int get itemCount => lastPage ? adList.length : adList.length + 1;

  void resetPage() {
    page = 0;
    adList.clear();
    lastPage = false;
  }

  @computed
  bool get showProgress => loading && adList.isEmpty;

  void incrementViews(Ad ad) {
    try {
      AdRepository().incrementViews(ad);
    } catch (e) {
      print(e);
    }
  }

  Future<Ad> getAdById(String id) async {
    return await AdRepository().getAdById(id);
  }
}
