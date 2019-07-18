import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foresight/screens/stats.dart';
import 'package:foresight/wigets/Card.dart';
import 'package:foresight/wigets/exchange_tile.dart';
import 'package:foresight/wigets/fancy_header.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/bloc/simple_hidden_drawer_bloc.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class ProfileView extends StatefulWidget {
  final SimpleHiddenDrawerBloc controller;

  const ProfileView({Key key, this.controller}) : super(key: key);
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }

  turnPage() {
    switch (_controller.index) {
      case 0:
        print("store");
        return StoreView();
      case 1:
        print("charts");

        return ChartView();
      case 2:
        print("history");
        return HistoryView();
      default:
        StoreView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              AppBar(
                actionsIconTheme: IconThemeData(color: Colors.white),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.bars),
                    onPressed: () {
                      widget.controller.toggle();
                    },
                  )
                ],
                elevation: 0,
                backgroundColor: Colors.white,
                flexibleSpace: PreferredSize(
                    preferredSize: Size(2, 10),
                    child: Column(
                      children: <Widget>[
                        Header(),
                        FancyTabBar(
                          controller: _controller,
                        ),
                      ],
                    )),
              ),
              Container(
                color: Colors.grey,
                child: turnPage(),
              )
            ]),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class StoreView extends StatelessWidget {
  const StoreView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List<Widget>.generate(10, (index) => Tile()));
  }
}

class ChartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          elevation: 3,
          child: ListTile(
            title: Text("Sales"),
            onTap: () {
              var child = FancyLineChart(createSampleData());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (cont) => LandscapeView(
                            child: child,
                          )));
            },
          ),
        ),
        Card(
          elevation: 3,
          child: ListTile(
            title: Text("Stock"),
            onTap: () {
              var child = DonutAutoLabelChart(createSampleData());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (cont) => LandscapeView(
                            child: child,
                          )));
            },
          ),
        ),
      ],
    );
  }
}

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.green,
      child: Column(
        children: <Widget>[
          ExchangeTile(),
          ExchangeTile(),
          ExchangeTile(),
          ExchangeTile(),
          ExchangeTile(),
        ],
      ),
    );
  }
}

class FancyTabBar extends StatefulWidget {
  final TabController controller;
  const FancyTabBar({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  _FancyTabBarState createState() => _FancyTabBarState();
}

class _FancyTabBarState extends State<FancyTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey, Colors.white],
          begin: Alignment.bottomRight,
          //stops: [1.0,7.0]
        ),
      ),
      child: TabBar(
        indicatorWeight: 10,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          //color: Colors.green
        ),
        controller: widget.controller,
        labelColor: Colors.green,
        indicatorColor: Colors.white,
        indicatorPadding: EdgeInsets.all(0),
        unselectedLabelColor: Colors.grey,
        tabs: <Widget>[
          Tab(
            icon: Icon(
              FontAwesomeIcons.store,
            ),
          ),
          Tab(
            icon: Icon(FontAwesomeIcons.chartBar),
          ),
          Tab(
            icon: Icon(FontAwesomeIcons.history),
          ),
        ],
      ),
    );
  }
}
