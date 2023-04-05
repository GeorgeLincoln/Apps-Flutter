import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/empty_card.dart';
import 'package:xlo_mobx/stores/myads_store.dart';

import 'components/active_tile.dart';
import 'components/pending_tile.dart';
import 'components/sold_tile.dart';

class MyAdsScreen extends StatefulWidget {
  MyAdsScreen({this.initialPage = 0});

  final int initialPage;

  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen>
    with SingleTickerProviderStateMixin {
  final MyAdsStore store = MyAdsStore();

  TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Anúncios'),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.orange,
          tabs: [
            Tab(child: Text('ATIVOS')),
            Tab(child: Text('PENDENTES')),
            Tab(child: Text('VENDIDOS')),
          ],
        ),
      ),
      body: Observer(builder: (_) {
        if (store.loading)
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          );
        return TabBarView(
          controller: tabController,
          children: [
            Observer(builder: (_) {
              if (store.activeAds.isEmpty)
                return EmptyCard('Você não possui nenhum anúncio ativo.');

              return ListView.builder(
                itemCount: store.activeAds.length,
                itemBuilder: (_, index) {
                  return ActiveTile(store.activeAds[index], store);
                },
              );
            }),
            Observer(builder: (_) {
              if (store.pendingAds.isEmpty)
                return EmptyCard('Você não possui nenhum anúncio pendente.');

              return ListView.builder(
                itemCount: store.pendingAds.length,
                itemBuilder: (_, index) {
                  return PendingTile(store.pendingAds[index]);
                },
              );
            }),
            Observer(builder: (_) {
              if (store.soldAds.isEmpty)
                return EmptyCard('Você não possui nenhum anúncio vendido.');

              return ListView.builder(
                itemCount: store.soldAds.length,
                itemBuilder: (_, index) {
                  return SoldTile(store.soldAds[index], store);
                },
              );
            }),
          ],
        );
      }),
    );
  }
}
