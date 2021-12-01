import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../init.dart';

class ExampleTwoPage extends StatefulWidget {
  ExampleTwoPage({Key key}) : super(key: key);

  @override
  _WidgetPageState createState() => _WidgetPageState();
}

class _WidgetPageState extends State<ExampleTwoPage> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: const NeumorphicThemeData(
        lightSource: LightSource.topLeft,
        accentColor: NeumorphicColors.accent,
        depth: 4,
        intensity: 0.5,
      ),
      child: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('radio'),
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _DefaultWidget(),
              CircleRadios(),
              _EnabledDisabledWidget(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _DefaultWidget extends StatefulWidget {
  @override
  _DefaultWidgetState createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<_DefaultWidget> {
  int groupValue;

  Widget _buildCode(BuildContext context) {
    return Container();
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Default",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            //uncomment to test colors
            //style: NeumorphicRadioStyle(
            //  selectedColor: Colors.black,
            //  unselectedColor: Colors.blue
            //),
            groupValue: groupValue,
            value: 1991,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: EdgeInsets.all(8.0),
            child: Text("1991"),
          ),
          SizedBox(width: 12),
          NeumorphicRadio(
            value: 2000,
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: EdgeInsets.all(8.0),
            child: Text("2000"),
          ),
          SizedBox(width: 12),
          NeumorphicRadio(
            groupValue: groupValue,
            value: 2012,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: EdgeInsets.all(8.0),
            child: Text("2012"),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}

class CircleRadios extends StatefulWidget {
  @override
  _CircleRadiosState createState() => _CircleRadiosState();
}

class _CircleRadiosState extends State<CircleRadios> {
  String groupValue;

  Widget _buildCode(BuildContext context) {
    return Container();
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Circle",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            style: const NeumorphicRadioStyle(
              boxShape: NeumorphicBoxShape.circle(),
            ),
            groupValue: groupValue,
            value: "A",
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: const EdgeInsets.all(18.0),
            child: const Text("A"),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            value: "B",
            style: const NeumorphicRadioStyle(
              boxShape: NeumorphicBoxShape.circle(),
            ),
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: const EdgeInsets.all(18.0),
            child: const Text("B"),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            style: const NeumorphicRadioStyle(
              boxShape: NeumorphicBoxShape.circle(),
            ),
            groupValue: groupValue,
            value: "C",
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
            padding: const EdgeInsets.all(18.0),
            child: const Text("C"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}

class _EnabledDisabledWidget extends StatefulWidget {
  @override
  _EnabledDisabledWidgetState createState() => _EnabledDisabledWidgetState();
}

class _EnabledDisabledWidgetState extends State<_EnabledDisabledWidget> {
  int groupValue;

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Enabled :",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            groupValue: groupValue,
            value: 1,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            child: const Text("First"),
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
          ),
          const SizedBox(width: 24),
          Text(
            "Disabled :",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            isEnabled: false,
            groupValue: groupValue,
            value: 2,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            child: const Text("Second"),
            onChanged: (value) {
              setState(() {
                groupValue = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCode(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}