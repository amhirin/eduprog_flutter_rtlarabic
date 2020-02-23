import 'dart:collection';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eduprog RTL Arab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: PageAyatChooser(),
    );
  }
}

class PageAyatChooser extends StatefulWidget {
  PageAyatChooser({Key key}) : super(key: key);

  @override
  _PageAyatChooserState createState(){
    return _PageAyatChooserState();
  }

}


class _PageAyatChooserState extends State<PageAyatChooser> {
  final TextEditingController _filterController = TextEditingController();
  String _switchText = "indo";
  bool isRTL = false;
  String _filter = "";

  List<Map<String, String>> lstAyat = [];

  void initAyat(){
    lstAyat.clear();
    lstAyat.add({
      "id": "Al-Fatihah (7)",
      "ar": "الفاتحة"
    });
    lstAyat.add({
      "id": "Al-Baqarah (286)",
      "ar": "االبقرة"
    });
    lstAyat.add({
      "id": "Ali 'Imran (200)",
      "ar": "اٰل عمران"
    });
    lstAyat.add({
      "id": "An-Nisa' (176)",
      "ar": "النساۤء"
    });
    lstAyat.add({
      "id": "Al-Ma'idah (120)",
      "ar": "الماۤئدة"
    });
    lstAyat.add({
      "id": "Al-An'am (165)",
      "ar": "الانعام"
    });
    lstAyat.add({
      "id": "Al-A'raf (206)",
      "ar": "الاعراف"
    });
    lstAyat.add({
      "id": "Al-Anfal (75)",
      "ar": "الانفال"
    });
  }

  @override
  void initState() {
    initAyat();
    super.initState();
  }

  List<Widget> buildListAyat(){
    List<Widget> lstRes = [];
    for(int i = 0; i < lstAyat.length; i++){
      Map<String, String> mAyat = lstAyat[i];

      if (_filter != ""){
        if (_switchText == "indo"){
          if (mAyat["id"].toString().toLowerCase().indexOf(_filter.toLowerCase()) < 0) continue; //. skip
        }else if (_switchText == "arab"){
          if (mAyat["ar"].toString().indexOf(_filter) < 0) continue; //. skip
        }
      }

      lstRes.add(Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: TextHighlight(
                            text:  mAyat["id"],
                            word: _filter,
                            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("Keterangan ayat disini...", style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),),
                      )
                    ],
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text("${mAyat["ar"]}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(color: Colors.black87,)
        ],
      ));
    }
    return lstRes;
  }


  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  void processFilterChange(filterText){

    setState(() {
      _filter = filterText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTextStyle(
          style: TextStyle(color: Colors.black),
          child: Container(
            color: Colors.blueAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 60,
                  padding: EdgeInsets.fromLTRB(0, 5, 10, 5) ,
                  color: Colors.blueAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          //color: Colors.black45,
                            child: Center(
                                child: Text("Daftar Ayat", style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold
                                ),)
                            )
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right:20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 10,
                          child: Container(
                            color: Colors.white,
                            child: Directionality(
                              textDirection: isRTL ?  TextDirection.rtl : TextDirection.ltr,
                              child: TextField(
                                  controller: _filterController,
                                  onChanged: (filterText){
                                    processFilterChange(filterText);
                                  },
                                  textCapitalization: TextCapitalization.characters,
                                  //autofocus: true,
                                  style: TextStyle(color: Colors.black87),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                                      prefixIcon: Icon(Icons.search),
                                      prefixStyle: TextStyle(color: Colors.blue),
                                      hintText:  isRTL ? "جر ايت" : "Cari Ayat..",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white, width: 32.0),
                                          borderRadius: BorderRadius.circular(0.0)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.white, width: 32.0),
                                          borderRadius: BorderRadius.circular(0.0)))
                              ),
                            ),
                          )
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(top: 1, bottom: 1),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Material(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: (){
                                    _switchText="indo";
                                    isRTL = false;
                                    setState(() {
                                      processFilterChange(_filterController.text);
                                    });
                                  },
                                  child: Container(
                                      width: 70,
                                      padding: EdgeInsets.only(left: 3),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _switchText == "indo"? Colors.red : Colors.transparent,
                                      ),
                                      child: Text("INDO",
                                        style: TextStyle(color: _switchText == "indo"? Colors.white : Colors.grey),
                                      )
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Material(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: (){
                                    _switchText="arab";
                                    isRTL = true;
                                    setState(() {
                                      processFilterChange(_filterController.text);
                                    });
                                  },
                                  child: Container(
                                        width: 70,
                                        alignment: Alignment.center,

                                        decoration: BoxDecoration(
                                          color: _switchText == "arab"? Colors.red : Colors.transparent,
                                        ),
                                        child: Text("ARAB",
                                          style: TextStyle(color: _switchText == "arab"? Colors.white : Colors.grey),
                                      ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  height: 30,
                  color: Color.fromARGB(255, 220, 220, 220),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text("Teks Indonesia",
                            style: TextStyle(color: Color.fromARGB(222, 50, 50, 50), fontWeight: FontWeight.bold), ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(right: 20),
                          alignment: Alignment.centerRight,
                          child: Text("Teks Arab",
                            style: TextStyle(color: Color.fromARGB(222, 50, 50, 50), fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],

                  ),

                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: buildListAyat(),
                          ),
                        )
                      ],

                    ),
                  ),
                )
              ],

            ),

          ),
        ),
      ),
    );
  }
}

//. modify from source https://github.com/desconexo/highlight_text

class TextHighlight extends StatelessWidget {
  final String text;
  final String word;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int maxLines;
  final Locale locale;
  final StrutStyle strutStyle;

  TextHighlight({
    @required this.text,
    @required this.word,
    this.textStyle = const TextStyle(
      fontSize: 16.0,
      color: Colors.black,
    ),
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.maxLines,
    this.locale,
    this.strutStyle,
  });

  @override
  Widget build(BuildContext context) {
    List<String> _textWords = List();
    if (!word?.isEmpty)
      _textWords = text.split(word);
    return RichText(
      text: buildSpan(_textWords),
      locale: locale,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      textScaleFactor: textScaleFactor,
    );
  }

  TextSpan buildSpan(List<String> words) {
    List<TextSpan> lstSpan = [];
    for (int i = 0; i < words.length; i++){
      String m = words[i];
      if (m == null || m?.isEmpty){
        lstSpan.add(TextSpan(
          text: this.word,  style: TextStyle(fontSize: this.textStyle.fontSize, backgroundColor: Colors.yellowAccent)
        ));
      }else{
        lstSpan.add(TextSpan(
            text: m,  style: this.textStyle
        ));
        if (i >= 0 && i < (words.length - 1)){
          lstSpan.add(TextSpan(
              text: this.word,  style: TextStyle(fontSize: this.textStyle.fontSize, backgroundColor: Colors.yellowAccent)
          ));
        }
      }
    }
    if (!(this.word == null || this.word?.isEmpty)){
      return TextSpan(
        text: '',
        style: this.textStyle,
        children: lstSpan,
      );
    }else{
      return TextSpan(
        text: this.text,
        style: this.textStyle,
      );
    }

  }
}