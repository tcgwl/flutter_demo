import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TabBar Demo',
      home: TabBarDemo(),
    );
  }
}

class TabBarDemo extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _TabBarDemo();
  }
}

class _TabBarDemo extends State<TabBarDemo> with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TabBar'),
          leading: Icon(Icons.home),
          backgroundColor: Colors.amber[1000],
          bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: <Widget>[
              Tab(text: 'Tabs 1',),
              Tab(text: 'Tabs 2',),
              Tab(text: 'Tabs 3',),
              Tab(text: 'Tabs 4',),
              Tab(text: 'Tabs 5',),
              Tab(text: 'Tabs 6',),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Text('TabsView 1'),
            Text('TabsView 2'),
            Text('TabsView 3'),
            Text('TabsView 4'),
            Text('TabsView 5'),
            Text('TabsView 6'),
          ],
        ),
      ),
    );
  }
}