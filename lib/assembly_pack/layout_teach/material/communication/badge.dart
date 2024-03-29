import 'package:flutter/material.dart';

class MBadge extends StatelessWidget {
  const MBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Badge.count(count: 999,
              child: const Icon(Icons.ac_unit),
            ),
            const SizedBox(width: 50,),
            Badge.count(count: 112,
              child: const Text('12'),
            ),
          ],
        ),
      ),
    );
  }
}
