import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../init.dart';
import '../../widget/chat/helper/user/user.dart';
import 'notifier.dart';

// class RiverPodTest extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final count = ref.watch(countProvider.select((value) => value));
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('$count'),
//           ElevatedButton(
//             onPressed: () {
//               ref.read(countProvider.notifier).increment();
//             },
//             child: const Text('Add 1'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // ref.
//             },
//             child: const Text('other'),
//           )
//         ],
//       ),
//     );
//   }
// }

class RiverPodTestPage extends StatefulWidget {
  const RiverPodTestPage({Key? key}) : super(key: key);

  @override
  State<RiverPodTestPage> createState() => _RiverPodTestPageState();
}

class _RiverPodTestPageState extends State<RiverPodTestPage> {

  User? user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('River Pod Test Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (BuildContext context, WidgetRef ref, _) {
                final User? user =
                ref.watch(loginProvider.select((value) => value.user));
                return Text('${user?.name}');
              },
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, _) {
                final Object? count =
                    ref.watch(countProvider.select((value) => value));
                return Text('$count');
              },
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, _) {
                return ElevatedButton(
                  onPressed: () {
                    ref.read(countProvider.notifier).increment();
                  },
                  child: const Text('add'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
