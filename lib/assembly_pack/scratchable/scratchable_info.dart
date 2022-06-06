import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/scratchable/scratch_model.dart';
import 'package:flutter_text/init.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:k_chart/flutter_k_chart.dart';

import 'fake.dart';

class ScratchInfo extends StatefulWidget {
  const ScratchInfo({Key? key}) : super(key: key);

  @override
  State<ScratchInfo> createState() => _ScratchInfoState();
}

class _ScratchInfoState extends State<ScratchInfo> {
  List<ScratchModel> result = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _getList();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (t) {
      update();
    });
  }

  void _getList() {
    result.addAll(fake);
    setState(() {});
  }

  void update() {
    final List<ScratchModel> newList = [];
    result.map((e) => newList.add(_update(e))).toList();
    result = newList;
    setState(() {});
  }

  ScratchModel _update(ScratchModel scratchModel) {
    final int isUp = Random().nextInt(3);
    scratchModel.isUpdate = false;
    if (isUp != 2) {
      scratchModel.up = isUp == 1;
      if (scratchModel.up == true) {
        scratchModel.price += Random().nextInt(100);
      } else {
        scratchModel.price -= Random().nextInt(100);
      }
      scratchModel.side = Random().nextDouble();
      scratchModel.range = Random().nextDouble();
      scratchModel.isUpdate = true;
    }
    return scratchModel;
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('闪闪'),
      ),
      body: RepaintBoundary(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
                childAspectRatio: 1.8),
            itemBuilder: (BuildContext context, int index) {
              final ScratchModel item = ArrayHelper.get(result, index)!;
              return RepaintBoundary(
                child: _ScratchItemInfo(
                  scratch: item,
                  key: Key('${item.id}${item.price}${item.side}${item.range}'),
                ),
              );
            },
            itemCount: result.length,
          ),
        ),
      ),
    );
  }
}

class _ScratchItemInfo extends StatefulWidget {
  final ScratchModel scratch;

  const _ScratchItemInfo({required this.scratch, Key? key}) : super(key: key);

  @override
  State<_ScratchItemInfo> createState() => _ScratchItemInfoState();
}

class _ScratchItemInfoState extends State<_ScratchItemInfo>
    with SingleTickerProviderStateMixin {
  bool isUpdate = false;
  AnimationController? _animationController;
  Animation? _animation;

  @override
  void initState() {
    super.initState();
    if (widget.scratch.isUpdate == true) {

      _animationController = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 500));
      if (_animationController != null) {
        _animationController!.addListener(() {
          if (mounted) {
            setState(() {});
          }
        });
        _animationController!.addStatusListener((status) {
          AnimationStatus status = _animationController!.status;
          if (status == AnimationStatus.completed) {

          } else if (status == AnimationStatus.dismissed) {
            _animationController!.forward();
          }
        });
        _animation = ColorTween(begin: widget.scratch.up
            ? const Color(0x50f44336)
            : const Color(0x504caf50), end: null).animate(_animationController!);

        Future.delayed(Duration.zero, () {
          _animationController!.forward();
        });
      }
    }
  }

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController!.dispose();
    }
    super.dispose();
  }

  Future<void> _update() async {
    isUpdate = true;
    if (mounted) {
      setState(() {});
    }
    await Future.delayed(const Duration(milliseconds: 300));
    isUpdate = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _animation?.value,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text('${widget.scratch.title}'),
          ),
          const SizedBox(
            height: 1.0,
          ),
          Container(
            child: Text(
              '${widget.scratch.price.toStringAsFixed(2)}',
              style: TextStyle(
                color: widget.scratch.up ? Colors.red : Colors.green,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 2.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  '${widget.scratch.up ? '+' : '-'}${widget.scratch.side.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: widget.scratch.up ? Colors.red : Colors.green,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Container(
                child: Text(
                  '${widget.scratch.up ? '+' : '-'}${widget.scratch.range.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: widget.scratch.up ? Colors.red : Colors.green,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
