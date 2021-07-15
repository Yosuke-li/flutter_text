import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text/utils/lock.dart';
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

  test('', () {

  });
}
