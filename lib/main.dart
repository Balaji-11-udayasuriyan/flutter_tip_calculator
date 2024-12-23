import 'package:flutter/material.dart';

void main() => runApp(TipCalculatorApp());

class TipCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TipCalculator(),
    );
  }
}

class TipCalculator extends StatefulWidget {
  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  final TextEditingController _billController = TextEditingController();
  double _billAmount = 0.0;
  double _tipPercentage = 10.0; // Default percentage
  double _tipAmount = 0.0;
  double _totalAmount = 0.0;
  int _splitCount = 1;

  void _calculateTip() {
    setState(() {
      _billAmount = double.tryParse(_billController.text) ?? 0.0;
      _tipAmount = (_billAmount * _tipPercentage) / 100;
      _totalAmount = _billAmount + _tipAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip Calculator'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bill Amount Input
              TextField(
                controller: _billController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Bill Amount',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _calculateTip(),
              ),
              SizedBox(height: 20),
              // Tip Percentage Slider
              Text(
                'Tip Percentage: ${_tipPercentage.toStringAsFixed(0)}%',
                style: TextStyle(fontSize: 18.0),
              ),
              Slider(
                value: _tipPercentage,
                min: 0,
                max: 50,
                divisions: 50,
                label: '${_tipPercentage.toStringAsFixed(0)}%',
                onChanged: (value) {
                  setState(() {
                    _tipPercentage = value;
                    _calculateTip();
                  });
                },
              ),
              SizedBox(height: 20),
              // Split Between People
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Split Between:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (_splitCount > 1) _splitCount--;
                          });
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text(
                        '$_splitCount',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _splitCount++;
                          });
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Result Card
              Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tip Amount:',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Text(
                            '₹${_tipAmount.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount:',
                            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '₹${_totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Amount Per Person Card
              Card(
                color: Colors.lightBlueAccent,
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount Per Person:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '₹${(_totalAmount / _splitCount).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
