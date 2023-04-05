import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';
import 'package:xlo_mobx/screens/uf_city/uf_city_screen.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class LocationField extends StatelessWidget {
  LocationField(this.filter);

  final FilterStore filter;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SectionTitle(
              'Localização',
            ),
            GestureDetector(
              onTap: () async {
                final result =
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => UfCityScreen(
                              showAll: true,
                            )));
                if (result == null) return;
                filter.setUf(result['uf']);
                filter.setCity(result['city']);
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      filter.uf?.name ?? 'Selecionar Estado',
                      style: const TextStyle(fontSize: 14),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.purple,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            if (filter.city != null)
              GestureDetector(
                onTap: () async {
                  final result =
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => UfCityScreen(
                                uf: filter.uf,
                                showAll: true,
                              )));
                  if (result == null) return;
                  filter.setUf(result['uf']);
                  filter.setCity(result['city']);
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        filter.city?.name ?? 'Selecionar Cidade',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.purple,
                      )
                    ],
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
