import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: FruitMatcher(),
      ),
    );
  }
}

class FruitMatcher extends StatefulWidget {
  @override
  _FruitMatcherState createState() => _FruitMatcherState();
}

class _FruitMatcherState extends State<FruitMatcher> {
  List<SvgPicture> cells = new List(16);
  List<Color> cellColors = List.filled(16, Color(0xFF7575EF));
  String selectedFruit = 'apple';
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('FG PERFECT MATCH', style: GoogleFonts.fredokaOne()),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/app_background.jpg'),
            fit: BoxFit.cover
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Wrap(
                spacing: 50,
                children: [
                  _buildFruitSelector('apple'),
                  _buildFruitSelector('grapes'),
                  _buildFruitSelector('banana'),
                  _buildFruitSelector('orange'),
                  _buildFruitSelector('watermelon'),
                  _buildFruitSelector('cherry'),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 16,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5,
                    color: cellColors[index],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _cellTapped(index);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFC366D1)),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: cells[index]
                        ),
                      ),
                    ),
                  );
                }),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 5),
              ),
              child: RaisedButton.icon(
                elevation: 5,
                padding: EdgeInsets.all(10),
                color: Colors.pink,
                onPressed: _resetCells,
                icon: Icon(Icons.clear, size: 35, color: Colors.white),
                label: Text('CLEAR', style: GoogleFonts.fredokaOne(fontSize: 26, color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildFruitSelector(String fruitValue) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.yellow, width: 2),
            color: Colors.yellow[600],
          ),
          child: SvgPicture.asset(
            'assets/svg/$fruitValue.svg',
            width: MediaQuery.of(context).size.width * 0.15,
          ),
        ),
        Radio(
          value: fruitValue,
          groupValue: selectedFruit,
          onChanged: (selectedFruit) {
            _fruitChanged(selectedFruit);
          },
        ),
      ],
    );
  }

  _resetCells() {
    setState(() {
      for(var i = 0; i < cells.length; i++) {
        cells[i] = null;
        cellColors[i] = Color(0xFF7575EF);
      }
    });
  }

  _fruitChanged(String newSelectedFruit) {
    setState(() {
      selectedFruit = newSelectedFruit;
    });
  }

  _cellTapped(int index) {
    setState(() {
      if(cells[index] != null) {
        cells[index] = null;
      } else {
        cells[index] = SvgPicture.asset('assets/svg/$selectedFruit.svg');

        switch(selectedFruit) {
          case 'apple':
            cellColors[index] = ColorConstants.appleColor;
            break;
          case 'grapes':
            cellColors[index] = ColorConstants.grapesColor;
            break;
          case 'banana':
            cellColors[index] = ColorConstants.bananaColor;
            break;
          case 'orange':
            cellColors[index] = ColorConstants.orangeColor;
            break;
          case 'cherry':
            cellColors[index] = ColorConstants.cherryColor;
            break;
          case 'watermelon':
            cellColors[index] = ColorConstants.watermelonColor;
            break;
        }
      }
    });
  }
}
