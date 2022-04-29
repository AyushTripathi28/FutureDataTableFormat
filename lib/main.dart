import 'package:flutter/material.dart';
import 'apimanager.dart';
import 'modalclass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App',
        theme: ThemeData(primarySwatch: Colors.amber),
        home: const HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('DataTable getting Future type data')),
        // Geting Future data from API
        body: FutureBuilder<List<Country>>(
            future: ApiManager().fetchData(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Country>> snapshot) {
              if (!snapshot.hasData) {
                // checking if API has data & if no data then loading bar
                return const Center(child: CircularProgressIndicator());
              } else {
                // return data after recieving it in snapshot.
                return Container(
                    padding: const EdgeInsets.all(5),
                    // Data Table logic and code is in DataClass
                    child: DataClass(datalist: snapshot.data as List<Country>));
              }
            }));
  }
}

class DataClass extends StatelessWidget {
  const DataClass({Key? key, required this.datalist}) : super(key: key);
  final List<Country> datalist;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        // Using scrollView for scrolling and formating
        scrollDirection: Axis.vertical,
        // using FittedBox for fitting complte table in screen horizontally.
        child: FittedBox(
            child: DataTable(
          sortColumnIndex: 1,
          showCheckboxColumn: false,
          border: TableBorder.all(width: 1.0),
          // Data columns as required by APIs data.
          columns: const [
            DataColumn(
                label: Text(
              "Country Name",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              "Total Confirmed",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
            DataColumn(
                label: Text(
              "Total Death",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
          ],
          // Main logic and code for geting data and shoing it in table rows.
          rows: datalist
              .map(
                  //maping each rows with datalist data
                  (data) => DataRow(cells: [
                        DataCell(
                          Text(data.country,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500)),
                        ),
                        DataCell(Text(data.totalConfirmed.toString(),
                            style: const TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w500))),
                        DataCell(
                          Text(data.totalDeaths.toString(),
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.w500)),
                        ),
                      ]))
              .toList(), // converting at last into list.
        )));
  }
}
