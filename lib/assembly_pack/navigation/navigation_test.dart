import '../../init.dart';

class NavigationTest extends StatefulWidget {
  const NavigationTest({Key? key}) : super(key: key);

  @override
  State<NavigationTest> createState() => _NavigationTestState();
}

class _NavigationTestState extends State<NavigationTest> {
  List<NavigationRailDestination> _destinations = [];
  int currentIndex = 0;
  PageController _controller = PageController();
  bool _extended = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _destinations = [
      const NavigationRailDestination(
          icon: Icon(Icons.style), label: Text('style')),
      const NavigationRailDestination(
          icon: Icon(Icons.camera), label: Text('camera')),
    ];
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            leading: InkWell(
              onTap: () {
                _extended = !_extended;
                setState(() {});
              },
              child: const Icon(Icons.list),
            ),
            extended: _extended,
            onDestinationSelected: (int index) {
              currentIndex = index;
              _controller.jumpToPage(
                index,
              );
              setState(() {});
            },
            destinations: _destinations,
            selectedIndex: currentIndex,
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              children: const <Widget>[
                Center(
                  child: Text('style'),
                ),
                Center(
                  child: Text('camera'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
