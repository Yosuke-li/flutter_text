import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text/utils/encrypt.dart';
import 'package:flutter_text/utils/lock.dart';
import 'package:flutter_text/utils/singleton.dart';
import 'package:lpinyin/lpinyin.dart';

void main() {
  test('io操作文件--修改文件名 测试', () async {
    ///path 文档路径
   final directory = await Directory('path');
   assert(await directory.exists() == true);

   Stream<FileSystemEntity> fileList = directory.list(recursive: false, followLinks: false);
   await for(FileSystemEntity file in fileList) {
     final String pinyin = PinyinHelper.getPinyinE(file.path);
     final String newName = pinyin.replaceAll(' ', '').replaceAll('·', '');
     await file.rename('$newName');
     print(file.path);
   }
  });

  ///Lock
  test('lock test', () async {
    Lock lock = Lock();
    int count=0;
    int i=0;

    await Future.wait(Iterable.generate(5,(_)=>Future(()async{
      await lock.lock();

      ///Func
      count ++;
      await Future.delayed(Duration(milliseconds: 10));
      count --;
      expect(count, 0);

      lock.unlock();
      i++;

    })));
    expect(i,5);
  });

  //单例
  test('SingleTon', () async {
    final SingleTon a = SingleTon('a');
    final SingleTon b = SingleTon('b');
    final SingleTon c = SingleTon('c');

    a.test();
    b.test();
    c.test();

    // print(identical(a, b));
    // print(a == b);

    // a 测试
    // a 测试
    // a 测试
  });

  test('解密', () {
    const String password = 'Love0823';
    final String base = Encrypt.encryptToBase64(password); // L4Sye2/O0ecveY5QW7okBA==

    print(base);
    final String decrypt = Encrypt.decryptWithBase64(base);
    print(decrypt==password);
  });
}
