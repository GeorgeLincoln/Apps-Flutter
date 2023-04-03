import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/models/uf.dart';

import 'home_store.dart';

part 'filter_store.g.dart';

enum OrderBy { DATE, PRICE }

const VENDOR_TYPE_PARTICULAR = 1 << 0;
const VENDOR_TYPE_PROFESSIONAL = 1 << 1;

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {
  _FilterStore(
      {this.orderBy = OrderBy.DATE,
      this.minPrice,
      this.maxPrice,
      this.vendorType = VENDOR_TYPE_PARTICULAR,
      this.uf,
      this.city});

  @observable
  OrderBy orderBy;

  @action
  void serOrderBy(OrderBy value) => orderBy = value;

  @observable
  int minPrice;

  @action
  void setMinPrice(int value) => minPrice = value;

  @observable
  int maxPrice;

  @action
  void setMaxPrice(int value) => maxPrice = value;

  @computed
  String get priceError =>
      maxPrice != null && minPrice != null && maxPrice < minPrice
          ? 'Faixa de preço inválida'
          : null;

  @observable
  int vendorType;

  @action
  void selectVendorType(int value) => vendorType = value;
  void setVendorType(int type) => vendorType = vendorType | type;
  void resetVendorType(int type) => vendorType = vendorType & ~type;

  @computed
  bool get isTypeParticular => (vendorType & VENDOR_TYPE_PARTICULAR) != 0;
  bool get isTypeProfessional => (vendorType & VENDOR_TYPE_PROFESSIONAL) != 0;

  @computed
  bool get isFormValid => priceError == null;

  void save() {
    GetIt.I<HomeStore>().setFilter(this);
  }

  FilterStore clone() {
    return FilterStore(
      orderBy: orderBy,
      minPrice: minPrice,
      maxPrice: maxPrice,
      vendorType: vendorType,
    );
  }

  @observable
  UF uf;

  @action
  void setUf(UF value) => uf = value;

  @observable
  City city;

  @action
  void setCity(City value) => city = value;

  copyWith(
      {int minPrice,
      int maxPrice,
      OrderBy orderBy,
      int vendorType,
      UF uf,
      City city}) {
    return FilterStore(
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
        orderBy: orderBy ?? this.orderBy,
        vendorType: vendorType ?? this.vendorType,
        uf: uf ?? this.uf,
        city: city ?? this.city);
  }

  @override
  String toString() {
    return '$minPrice, $maxPrice, ${orderBy.toString()},  ${vendorType.toString()}, ${uf.initials}, $city';
  }
}
