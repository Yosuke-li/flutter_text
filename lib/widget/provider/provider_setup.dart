import 'package:flutter_text/global/global.dart';
import 'package:flutter_text/widget/provider/provider_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = <SingleChildWidget>[
  Provider<TextModel>(create: (_) => TextModel()),
];
