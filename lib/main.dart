import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as urllaunch;
import 'package:string_validator/string_validator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsWho - WhatsApp direct message',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'WhatsApp Direct Message'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final number = TextEditingController();
  final message = TextEditingController();
  bool _autovalidate = false;
  final _formKey = GlobalKey<FormState>();

  void _openwame() {
    urllaunch.launch('https://api.whatsapp.com/send?phone=' +
        number.text +
        '&text=' +
        Uri.encodeFull(message.text) +
        '&source=&data=&app_absent=');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 50),
                child: Center(
                  child: Text(
                    'This app can help you messaging a user that you haven\'t saved their number yet in WhatsApp.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: number,
                  decoration: new InputDecoration(
                    labelText: 'Phone number',
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10)),
                  ),
                  autovalidate: _autovalidate,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter a phone number';
                    } else if (val.length < 5) {
                      return 'Phone number is too short';
                    } else if (!isNumeric(val)) {
                      return 'Please enter a number only';
                    } else if (toInt(val.substring(0, 1)) < 1) {
                      return 'Please add country code as well';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: message,
                  maxLines: 5,
                  decoration: new InputDecoration(
                      labelText: 'Message',
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10))),
                  autovalidate: _autovalidate,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter a message';
                    }
                    return null;
                  },
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _autovalidate = true;
                  });
                  if (_formKey.currentState.validate()) {
                    _openwame();
                  }
                },
                child: new Text('Submit'),
                color: Colors.green[600],
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
