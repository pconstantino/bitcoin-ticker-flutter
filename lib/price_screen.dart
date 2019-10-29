import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = "USD";
  double lastValueBtc;
  double lastValueEth;
  double lastValueLtc;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownMenuItemList = [];

    for (String currency in currenciesList) {
      dropdownMenuItemList
          .add(DropdownMenuItem(child: Text(currency), value: currency));
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownMenuItemList,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
          print(value);
        });
      },
    );
  }

  CupertinoPicker IOSPicker() {
    List<Text> dropdownMenuItemList = [];

    for (String currency in currenciesList) {
      dropdownMenuItemList.add(Text(currency));
    }

    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          print(selectedIndex);
        },
        children: dropdownMenuItemList);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getData();
    });

  }

  void getData() async {
    CoinData coinData = CoinData();

    for (String originalCurrency in cryptoList) {
      double coinValue = await coinData.getCoinPrice(originalCurrency, selectedCurrency);

      setState(() {
        switch (originalCurrency){
          case "BTC":
            lastValueBtc = coinValue;
            break;
          case "ETH":
            lastValueEth = coinValue;
            break;
          case "LTC":
            lastValueLtc = coinValue;
            break;
        }

      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
      new NewCoin(current: "BTC", lastValue: lastValueBtc, selectedCurrency: selectedCurrency),
          new NewCoin(current: "ETH",lastValue: lastValueEth, selectedCurrency: selectedCurrency),
          new NewCoin(current: "LTC", lastValue: lastValueLtc, selectedCurrency: selectedCurrency),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? IOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class NewCoin extends StatelessWidget {
  const NewCoin({
    @required this.current,
    @required this.lastValue,
    @required this.selectedCurrency,
  });

  final String current;
  final double lastValue;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
    child: Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $current = $lastValue $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    ),
    );
  }
}
