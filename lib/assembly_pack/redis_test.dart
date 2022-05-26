import '../init.dart';
import 'package:redis/redis.dart';

class RedisTest extends StatefulWidget {
  const RedisTest({Key? key}) : super(key: key);

  @override
  State<RedisTest> createState() => _RedisTestState();
}

class _RedisTestState extends State<RedisTest> {

  final RedisConnection redisConn = RedisConnection();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final Command res = await redisConn.connect('localhost', 6379);
    final test = await res.get('qq_password');
    Log.info('$test');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('redis测试'),
      ),
      body: Container(),
    );
  }
}
