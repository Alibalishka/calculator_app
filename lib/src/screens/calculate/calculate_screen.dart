import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({Key? key}) : super(key: key);

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {

  Widget calcButton(String btnText, Color btnColor, Color txtColor){
    return Container(
      child: RaisedButton(
        child: Text(
          btnText,
          style: TextStyle(
            color: txtColor,
            fontSize: 35,
          ),
        ),
        color: btnColor,
        shape: CircleBorder(),
        padding: const EdgeInsets.all(20),
        onPressed: () {
          // TODO add action 
          calculation(btnText);
        },  
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      navigationBar: CupertinoNavigationBar(
        middle: Text('Calculator'),
        border: Border(),
        backgroundColor: CupertinoColors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Calculator display
            
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AutoSizeText(
                      text,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 100,                    
                      ),
                      maxLines: 1,
                      minFontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Here buttons actions will be called where we will pass some arguments
                calcButton('AC', CupertinoColors.inactiveGray, CupertinoColors.black),
                calcButton('+/-', CupertinoColors.inactiveGray, CupertinoColors.black),
                calcButton('%', CupertinoColors.inactiveGray, CupertinoColors.black),
                calcButton('/', Colors.amber, CupertinoColors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Here buttons actions will be called where we will pass some arguments
                calcButton('7', Color(0xFF303030), CupertinoColors.white),
                calcButton('8', Color(0xFF303030), CupertinoColors.white),
                calcButton('9', Color(0xFF303030), CupertinoColors.white),
                calcButton('x', Colors.amber, CupertinoColors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Here buttons actions will be called where we will pass some arguments
                calcButton('4', Color(0xFF303030), CupertinoColors.white),
                calcButton('5', Color(0xFF303030), CupertinoColors.white),
                calcButton('6', Color(0xFF303030), CupertinoColors.white),
                calcButton('-', Colors.amber, CupertinoColors.white),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Here buttons actions will be called where we will pass some arguments
                calcButton('1', Color(0xFF303030), CupertinoColors.white),
                calcButton('2', Color(0xFF303030), CupertinoColors.white),
                calcButton('3', Color(0xFF303030), CupertinoColors.white),
                calcButton('+', Colors.amber, CupertinoColors.white),
              ],
            ),
            SizedBox(height: 10),
            // Now lasr row is different as it has 0 button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // This is button 0
                RaisedButton(
                  child: Text(
                    '0',
                    style: TextStyle(
                      fontSize: 35,
                      color: CupertinoColors.white,
                    ),
                  ),
                  color: Color(0xFF303030),
                  padding: const EdgeInsets.fromLTRB(34, 20, 128, 20),
                  onPressed: (){
                    // button function
                    calculation('0');
                  },
                  shape: StadiumBorder(),
                ),
                calcButton('.', Color(0xFF303030), CupertinoColors.white),
                calcButton('=', Colors.amber, CupertinoColors.white),
              ],
            )
          ],
        )
      ),
    );
  }
  
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
   
   void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    
    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
         finalResult = add();
      } else if( preOpr == '-') {
          finalResult = sub();
      } else if( preOpr == 'x') {
          finalResult = mul();
      } else if( preOpr == '/') {
          finalResult = div();
      } 

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
          numOne = double.parse(result);
      } else {
          numTwo = double.parse(result);
      }

      if(opr == '+') {
          finalResult = add();
      } else if( opr == '-') {
          finalResult = sub();
      } else if( opr == 'x') {
          finalResult = mul();
      } else if( opr == '/') {
          finalResult = div();
      } 
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
     result = numOne / 100;
     finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }
    
    else if(btnText == '+/-') {
        result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();        
        finalResult = result;        
    
    } 
    
    else {
        result = result + btnText;
        finalResult = result;        
    }


    setState(() {
          text = finalResult;
        });

  }


  String add() {
         result = (numOne + numTwo).toString();
         numOne = double.parse(result);           
         return doesContainDecimal(result);
  }

  String sub() {
         result = (numOne - numTwo).toString();
         numOne = double.parse(result);
         return doesContainDecimal(result);
  }
  String mul() {
         result = (numOne * numTwo).toString();
         numOne = double.parse(result);
         return doesContainDecimal(result);
  }
  String div() {
          result = (numOne / numTwo).toString();
          numOne = double.parse(result);
          return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {
    
    if(result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if(!(int.parse(splitDecimal[1]) > 0))
         return result = splitDecimal[0].toString();
    }
    return result; 
  }
}