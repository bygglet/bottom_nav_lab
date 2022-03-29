import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> pages = [Page1(), const Page2(), const Page3()];

  final pageOneScreen = GlobalKey<NavigatorState>();
  final pageTwoScreen = GlobalKey<NavigatorState>();
  final pageThreeScreen = GlobalKey<NavigatorState>();
  final modalPageScreen = GlobalKey<NavigatorState>();

  int currentIndex = 0;
  late Widget activeWidget;

  void navigateByInt(index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _onTap(int val, BuildContext context) {
    if (currentIndex == val) {
      switch (val) {
        case 0:
          pageOneScreen.currentState?.popUntil((route) => route.isFirst);
          break;
        case 1:
          pageTwoScreen.currentState?.popUntil((route) => route.isFirst);
          break;
        case 2:
          pageThreeScreen.currentState?.popUntil((route) => route.isFirst);
          break;
        default:
      }
    } else {
      if (mounted) {
        setState(() {
          currentIndex = val;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    activeWidget = pages[currentIndex];
    return Scaffold(
      floatingActionButton: const Modal(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        onTap: (val) => _onTap(val, context),
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            label: '0',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stream),
            label: '2',
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [Page1(), const Page2(), const Page3()],
      ),
    );
  }
}

class Modal extends StatelessWidget {
  const Modal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.star),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                  height: 100,
                  width: 100,
                  color: Colors.yellow,
                  child: ElevatedButton(
                      child: const Text("lägg till"),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Page3()));
                      }));
            });
      },
    );
  }
}

class Page1 extends StatelessWidget {
  Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: GestureDetector(
          child: Container(
            height: 100,
            width: 100,
            color: Colors.red,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Details(),
              ),
            );
          }),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menu")),
      body: Container(
        height: 100,
        width: 100,
        color: Colors.blue,
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PAGE 3")),
      body: Container(
        height: 100,
        width: 100,
        color: Colors.green,
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeregistration'),
      ),
      body: Container(
        child: const Text('Whatever'),
      ),
    );
  }
}
