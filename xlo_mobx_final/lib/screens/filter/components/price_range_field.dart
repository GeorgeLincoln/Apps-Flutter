import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filter/components/price_field.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class PriceRangeField extends StatelessWidget {
  PriceRangeField(this.filter);

  final FilterStore filter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('Preço'),
        Row(
          children: [
            PriceField(
              label: 'Min',
              onChanged: filter.setMinPrice,
              initialValue: filter.minPrice,
            ),
            const SizedBox(width: 12),
            PriceField(
              label: 'Max',
              onChanged: filter.setMaxPrice,
              initialValue: filter.maxPrice,
            ),
          ],
        ),
        Observer(builder: (_) {
          if (filter.priceError != null)
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                filter.priceError,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            );
          return Container();
        }),
      ],
    );
  }
}
