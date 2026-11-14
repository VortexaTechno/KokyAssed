import 'package:ahlachat/shop/presentation/components/vertical_tapbar.dart';
import 'package:ahlachat/shop/presentation/controller/shop_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopButtomWidget extends StatefulWidget {
  @override
  State<ShopButtomWidget> createState() => _ShopButtomWidgetState();
}

class _ShopButtomWidgetState extends State<ShopButtomWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      buildWhen: (previous, current) =>
          previous.GetShopState != current.GetShopState,
      builder: (context, state) {
        if (state.ShopPackages.isEmpty) return const SizedBox.shrink();
        return DefaultTabController(
          length: state.ShopPackages.length,
          child: Column(
            children: <Widget>[
              TabBar(
                physics: BouncingScrollPhysics(),
                labelColor: Colors.black,
                indicatorColor: Colors.transparent,
                padding: EdgeInsets.zero,
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                unselectedLabelColor: Colors.black54,
                tabs: List.generate(
                  state.ShopPackages.length,
                  (index) => Tab(text: state.ShopPackages[index].name ?? ''),
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: List.generate(
                    state.ShopPackages.length,
                    (index) => Center(
                      child:
                          VerticalTapBar(Packages: state.ShopPackages[index]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
