import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class Medicine {
  final int id; // Primary key
  final String name;
  final int dosage;

  Medicine(this.id, this.name, this.dosage);

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      json['id'],
      json['name'],
      json['dosage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
    };
  }
}

class MedicineListPage extends StatefulWidget {
  @override
  _MedicineListPageState createState() => _MedicineListPageState();
}

class _MedicineListPageState extends State<MedicineListPage> {
  List<Medicine> medicines = [];
  List<Medicine> filteredMedicines = [];
  TextEditingController searchController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMedicines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine List'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(80, 8, 80, 8),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                filterMedicines(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMedicines.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.black, width: 1.0), // Kenar rengi ve genişliği
                    ),
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        filteredMedicines[index].name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        filteredMedicines[index].dosage.toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMedicinePage()),
          ).then((value) {
            if (value != null) {
              setState(() {
                medicines.add(value);
                filteredMedicines.add(value);
              });
              _addMedicineToServer(value);
            }
          });
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.healing),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  void filterMedicines(String query) {
    setState(() {
      filteredMedicines = medicines
          .where((medicine) =>
      medicine.name.toLowerCase().contains(query.toLowerCase()) ||
          medicine.dosage.toString().contains(query))
          .toList();
    });
  }

  void _fetchMedicines() async {
    String url = 'http://10.7.255.177:8080/medicament';

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'authorization': globalAuth,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data']; // Veriyi haritadan al
        List<Medicine> fetchedMedicines = [];

        data.forEach((medicine) {
          fetchedMedicines.add(
            Medicine.fromJson(medicine),
          );
        });

        setState(() {
          medicines = fetchedMedicines;
          filteredMedicines = fetchedMedicines;
          _isLoading = false;
        });
      } else {
        print('Failed to fetch medicines');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addMedicineToServer(Medicine medicine) async {
    try {
      String url = 'http://10.7.255.177:8080/medicament';
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': globalAuth,
        },
        body: jsonEncode(medicine.toJson()),
      );

      if (response.statusCode == 200) {
        print('Medicine added successfully');
      } else {
        print('Failed to add medicine');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}

class AddMedicinePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Medicine'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Medicine Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: dosageController,
              decoration: InputDecoration(
                labelText: 'Dosage',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    dosageController.text.isNotEmpty) {
                  Medicine newMedicine = Medicine(
                    -1, // Temporary id value
                    nameController.text,
                    int.parse(dosageController.text),
                  );
                  Navigator.pop(context, newMedicine);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill all fields.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MedicineListPage(),
  ));
}
