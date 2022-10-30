import 'package:flutter/material.dart';

class DestinationsPage extends StatefulWidget {
  @override
  _DestinationsPageState createState() => _DestinationsPageState();
}

class _DestinationsPageState extends State<DestinationsPage> {
  late PageController _pageController;
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
    )..addListener(() {});
  }

  void _updateSelectedPage() {
    if (_pageController.page == null) {
      print('_pageController.pageがnull');
      return;
    }

    final closestPage = _pageController.page!.round();
    // print('_pageController.page: ${_pageController.page}');
    // print('closestPage: $closestPage');
    final isClosestPageSelected =
        (_pageController.page! - closestPage).abs() < 0.2;
    final selectedPage = isClosestPageSelected ? closestPage : null;
    if (_selectedPage != selectedPage) {
      setState(() {
        _selectedPage = selectedPage ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Destinations')),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 200.0,
              child: PageView.builder(
                itemCount: 3,
                controller: _pageController,
                padEnds: false, // ←ここが超重要っぽい感じがある
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.orange,
                    margin: EdgeInsets.only(
                      left: 18.0,
                      right: index == 2 ? 18 : 0,
                    ),
                    child: Center(
                      child: Text('Image ${index}'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                switchInCurve: Interval(0.5, 1.0, curve: Curves.ease),
                switchOutCurve: Interval(0.5, 1.0, curve: Curves.ease),
                child: _buildSelectedPageText(),
              ),
            )
          ],
        ));
  }

  Widget _buildSelectedPageText() {
    return Text(
      'Text for page ${_selectedPage}!',
      // key: ValueKey(
      //     _selectedPage), // setting key is important, see switcher docs
    );
  }
}
