// import 'package:media_kit/media_kit.dart';
// import 'package:media_kit_video/media_kit_video.dart';
//
// import '../../init.dart';
//
// class PlayVideoWindows extends StatefulWidget {
//   const PlayVideoWindows({Key? key}) : super(key: key);
//
//   @override
//   State<PlayVideoWindows> createState() => _PlayVideoWindowsState();
// }
//
// class _PlayVideoWindowsState extends State<PlayVideoWindows> {
//   final Player player = Player();
//   /// Store reference to the [VideoController].
//   VideoController? controller;
//
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() async {
//       /// Create a [VideoController] to show video output of the [Player].
//       controller = await VideoController.create(player);
//       /// Play any media source.
//       await player.open(Media('https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4'));
//       setState(() {});
//     });
//   }
//
//   @override
//   void dispose() {
//     Future.microtask(() async {
//       /// Release allocated resources back to the system.
//       await controller?.dispose();
//       await player.dispose();
//     });
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     /// Use [Video] widget to display the output.
//     return Video(
//       /// Pass the [controller].
//       controller: controller,
//     );
//   }
// }
