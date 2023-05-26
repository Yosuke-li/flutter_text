import '../../init.dart';
import 'up_animation.dart';

class UpAnimationExample extends StatefulWidget {
  const UpAnimationExample({Key? key}) : super(key: key);

  @override
  State<UpAnimationExample> createState() => _UpAnimationExampleState();
}

class _UpAnimationExampleState extends State<UpAnimationExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: UpAnimationLayout(
          child: Container(
            width: 200,
            height: 200,
            color: Colors.brown,
          ),
        ),
      ),
    );
  }
}
