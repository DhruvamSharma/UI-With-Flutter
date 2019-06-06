import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttery_music_player/second_screen.dart';
import 'package:fluttery_music_player/second_screen_bloc.dart';

import 'bottom_list.dart';
import 'home_bottom_list.dart';

void main() => runApp(MyApp());

final routeObserver = RouteObserver<PageRoute>();
final duration = const Duration(milliseconds: 400);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    secondBloc.init();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      navigatorObservers: [routeObserver],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with RouteAware {
  final GlobalKey _globalKey = GlobalKey();
  bool _bottomButtonVisible = true;
  PageController _pageController;
  int _initialPage = 0;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: _initialPage, viewportFraction: 0.6, keepPage: true);
  }

  @override
  dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
    _pageController.dispose();
  }

  @override
  didPopNext() {
    // Show back the FAB on transition back ended
    Timer(duration, () {
      setState(() => _bottomButtonVisible = true);
    });
  }

  // Image.asset('assets/images/headphones.png', height: 300, fit: BoxFit.cover,),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 32, top: 48),
                        child: Text(
                          'Dhruvam',
                          style: Theme.of(context).textTheme.display2.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32),
                        child: Text(
                          'Good Morning',
                          style: Theme.of(context).textTheme.title.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    key: _globalKey,
                    margin: EdgeInsets.all(16),
                    height: 300,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      itemBuilder: (context, index) {
                        return AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            double value = 1.0;
                            if (_pageController.position.haveDimensions) {
                              value = _pageController.page - index;
                              value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
                            }

                            return Center(
                              child: SizedBox(
                                height: Curves.easeOut.transform(value) * 300,
                                width: Curves.easeOut.transform(value) * 250,
                                child: child,
                              ),
                            );
                          },
                          child: Visibility(
                              visible: _bottomButtonVisible,
                              child: _buildSlideCard()),
                        );
                      },
                      itemCount: 5,
                      controller: _pageController,
                      onPageChanged: (value) {
                        setState(() {
                          _initialPage = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Text(
                      'Favourite',
                      style: Theme.of(context).textTheme.display1.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: HomeBottomList(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              right: -100,
              top: -50,
              child: Image.asset(
                'assets/images/headphones.png',
                height: 300,
                fit: BoxFit.cover,
              )),
        ],
      ),
    );
  }

  Widget _buildSlideCard() {
    return GestureDetector(
      onTap: () => onPageClick(),
      child: Card(
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Ambient',
                style: Theme.of(context)
                    .textTheme
                    .display1
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        color: Colors.indigo,
      ),
    );
  }

  onPageClick() {
    setState(() {
      _bottomButtonVisible = false;
    });

    final RenderBox containerRenderBox =
        _globalKey.currentContext.findRenderObject();
    final containerSize = containerRenderBox.size;
    final containerOffset = containerRenderBox.localToGlobal(Offset.zero);

    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => SecondScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        print('page clicked');
        return _buildTransition(
            child, animation, containerSize, containerOffset);
      },
    ));
  }

  Widget _buildTransition(
    Widget page,
    Animation<double> animation,
    Size fabSize,
    Offset fabOffset,
  ) {
    if (animation.value == 1) return page;

    final borderTween = BorderRadiusTween(
      begin: BorderRadius.circular(fabSize.width / 2),
      end: BorderRadius.circular(0.0),
    );
    final sizeTween = SizeTween(
      begin: fabSize,
      end: MediaQuery.of(context).size,
    );
    final offsetTween = Tween<Offset>(
      begin: fabOffset,
      end: Offset.zero,
    );

    final easeInAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeIn,
    );
    final easeAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    );

    final radius = borderTween.evaluate(easeInAnimation);
    final offset = offsetTween.evaluate(animation);
    final size = sizeTween.evaluate(easeInAnimation);

    final transitionFab = Opacity(
      opacity: 1 - easeAnimation.value,
      child: _buildSlideCard(),
    );

    Widget positionedClippedChild(Widget child) => Positioned(
        width: size.width,
        height: size.height,
        left: offset.dx,
        top: offset.dy,
        child: ClipRRect(
          borderRadius: radius,
          child: child,
        ));

    return Stack(
      children: [
        positionedClippedChild(page),
        positionedClippedChild(transitionFab),
      ],
    );
  }
}
