import 'package:cabify_driver/models/vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cabify_driver/models/user_data_model.dart';
import 'package:cabify_driver/providers/database_provider.dart';

class VehicleInfoPage extends StatefulWidget {
  VehicleInfoPage({Key key}) : super(key: key);

  @override
  _VehicleInfoPageState createState() => _VehicleInfoPageState();
}

class _VehicleInfoPageState extends State<VehicleInfoPage> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _vehicleModelController = TextEditingController();
  final _vehicleColorController = TextEditingController();
  final _vehicleNumberController = TextEditingController();

  Future<void> updateUserData(Vehicle vehicle) async {
    setState(() => loading = true);
    await context.read(databaseProvider).setUserVehicle(vehicle: vehicle);
    setState(() => loading = false);
  }

  void dispose() {
    _vehicleModelController.dispose();
    _vehicleColorController.dispose();
    _vehicleNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Vehicle Info',
          style: Theme.of(context).textTheme.headline5,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Car Model',
                    hintText: 'Car Model',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) => value.isEmpty
                      ? 'Enter a car model name at least 3 characters long'
                      : null,
                  controller: _vehicleModelController,
                ),
                SizedBox(height: 32.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Car Color',
                    hintText: 'Car Color',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) => value.isEmpty
                      ? 'Enter a color at least 3 characters long'
                      : null,
                  controller: _vehicleColorController,
                ),
                SizedBox(height: 32.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Vehicle Number',
                    hintText: 'Vehicle Number',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) => value.isEmpty
                      ? 'Enter a vehicle number at least 3 characters long'
                      : null,
                  controller: _vehicleNumberController,
                ),
                SizedBox(height: 48.0),
                SizedBox(
                  height: 64.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {}
                      final vehicle = Vehicle(
                        color: _vehicleColorController.text.trim(),
                        model: _vehicleModelController.text.trim(),
                        number: _vehicleNumberController.text.trim(),
                      );
                      await updateUserData(vehicle);
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: loading
                        ? CircularProgressIndicator()
                        : Text(
                            "UPDATE",
                            style: TextStyle(color: Colors.white),
                          ),
                    elevation: 2.0,
                    color: Colors.greenAccent,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
