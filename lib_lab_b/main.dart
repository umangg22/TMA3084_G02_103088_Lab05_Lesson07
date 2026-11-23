import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class Car {
  Car(this.make, this.model, this.price);

  final String make;
  final int model;
  final int price;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const CarTablePage(),
    );
  }
}

class CarTablePage extends StatefulWidget {
  const CarTablePage({super.key});

  @override
  State<CarTablePage> createState() => _CarTablePageState();
}

class _CarTablePageState extends State<CarTablePage> {
  final List<Car> cars = [
    Car('Honda', 2021, 35000),
    Car('Toyota', 2011, 6000),
    Car('BMW', 2010, 9000),
  ];

  int? sortColumnIndex;
  bool sortAscending = true;

  void sortBy(
    int columnIndex,
    bool ascending,
    int Function(Car a, Car b) compare,
  ) {
    setState(() {
      cars.sort((a, b) => ascending ? compare(a, b) : compare(b, a));
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
  }

  // Header text: big, bold, dark blue.
  Widget header(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.indigo.shade900,
      ),
    );
  }

  // Cell text: big; the sorted column is bold and coloured.
  Widget cell(String text, int column) {
    final bool isSorted = sortColumnIndex == column;
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: isSorted ? FontWeight.bold : FontWeight.normal,
        color: isSorted ? Colors.indigo : Colors.black87,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Car Price List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Tap a column title to sort',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: DataTable(
                sortColumnIndex: sortColumnIndex,
                sortAscending: sortAscending,
                headingRowColor: WidgetStateProperty.all<Color>(
                  Colors.indigo.shade100,
                ),
                headingRowHeight: 64,
                dataRowMinHeight: 60,
                dataRowMaxHeight: 60,
                columnSpacing: 16,
                horizontalMargin: 16,
                dividerThickness: 1.5,
                columns: [
                  DataColumn(
                    label: header('Car Make'),
                    onSort: (i, asc) =>
                        sortBy(i, asc, (a, b) => a.make.compareTo(b.make)),
                  ),
                  DataColumn(
                    label: header('Model'),
                    onSort: (i, asc) =>
                        sortBy(i, asc, (a, b) => a.model.compareTo(b.model)),
                  ),
                  DataColumn(
                    label: header('Price'),
                    onSort: (i, asc) =>
                        sortBy(i, asc, (a, b) => a.price.compareTo(b.price)),
                  ),
                ],
                rows: [
                  for (int i = 0; i < cars.length; i++)
                    DataRow(
                      // Striped rows: white and light blue.
                      color: WidgetStateProperty.all<Color>(
                        i.isEven ? Colors.white : Colors.indigo.shade50,
                      ),
                      cells: [
                        DataCell(cell(cars[i].make, 0)),
                        DataCell(cell('${cars[i].model}', 1)),
                        DataCell(cell('${cars[i].price}', 2)),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
