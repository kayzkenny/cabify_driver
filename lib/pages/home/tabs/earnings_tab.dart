import 'package:flutter/material.dart';

class EarningsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.black12,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 70.0),
            child: Column(
              children: [
                Text(
                  'Total Earnings',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  // '\$${Provider.of<AppData>(context).earnings}',
                  'earning',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
        FlatButton(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
          onPressed: () => Navigator.pushNamed(context, '/triphistory'),
          child: Row(
            children: [
              Image.asset(
                'images/taxi.png',
                width: 70,
              ),
              SizedBox(width: 16),
              Text(
                'Trips',
                style: TextStyle(fontSize: 16),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    // Provider.of<AppData>(context).tripCount.toString(),
                    'tripCount',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
