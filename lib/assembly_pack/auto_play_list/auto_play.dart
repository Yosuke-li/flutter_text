import '../../init.dart';
import '../video_player/video_widget.dart';

class AutoPlayListPage extends StatefulWidget {
  const AutoPlayListPage({Key? key}) : super(key: key);

  @override
  State<AutoPlayListPage> createState() => _AutoPlayListPageState();
}

class _AutoPlayListPageState extends State<AutoPlayListPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollListenerWidget(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return _buildItem(index);
              }, childCount: 100000),
            ),
          ],
        ),
        callback: (int firstIndex, int lastIndex) {
          Log.info('firstIndex - lastIndex: $firstIndex - $lastIndex');
          Log.info('centerIndex: ${((firstIndex + lastIndex) / 2).floor()}');
          currentIndex = ((firstIndex + lastIndex) / 2).floor();
          setState(() {});
        },
      ),
    );
  }

  Widget _buildItem(int index) {
    return RepaintBoundary(
      child: Container(
        height: 250,
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: VideoWidget(
            play: index == currentIndex,
            url:
            'https://video.pearvideo.com/mp4/adshort/20200520/cont-1675664-15155134_adpkg-ad_hd.mp4'),
      ),
    );
  }
}
