import 'package:flutter/material.dart';

class MealsScreen extends StatefulWidget {
  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  List<Map<String, String>> meals = [
    {
      'date': '12th August, 2019',
      'name': 'Cafe La Terrace',
      'amount': '\$40.00',
      'status': 'Approved'
    },
    {
      'date': '12th August, 2019',
      'name': 'Joe\'s Deli',
      'amount': '\$100.00',
      'status': 'Approved'
    },
    {
      'date': '10th August, 2019',
      'name': 'Chipotle',
      'amount': '\$500.00',
      'status': 'Pending'
    },
    {
      'date': '9th August, 2019',
      'name': 'Starbucks',
      'amount': '\$250.00',
      'status': 'Approved'
    },
    {
      'date': '9th August, 2019',
      'name': 'Dominos Pizza',
      'amount': '\$110.00',
      'status': 'Pending'
    },
    {
      'date': '13th August, 2019',
      'name': 'The Green Bowl',
      'amount': '\$60.00',
      'status': 'Approved',
    },
    {
      'date': '14th August, 2019',
      'name': 'Blue Lagoon',
      'amount': '\$35.00',
      'status': 'Rejected',
    },
  ];

  List<Map<String, String>> filteredMeals = [];
  String filter = '';

  @override
  void initState() {
    super.initState();
    filteredMeals = meals;
  }

  void updateFilter(String value) {
    setState(() {
      filter = value;
      filteredMeals = meals
          .where((meal) =>
              meal['name']!.toLowerCase().contains(filter.toLowerCase()) ||
              meal['status']!.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    });
  }

  DateTime parseDate(String dateString) {
    // Remove the ordinal suffix (e.g., "th", "st", "nd", "rd")
    String cleanedDateString =
        dateString.replaceAll(RegExp(r'(\d+)(st|nd|rd|th)'), r'$1');

    // Parse the cleaned date string
    return DateTime.parse(cleanedDateString);
  }

  void sortMeals(String? sortBy) {
    setState(() {
      if (sortBy == 'name') {
        filteredMeals.sort((a, b) => a['name']!.compareTo(b['name']!));
      } else if (sortBy == 'amount') {
        filteredMeals.sort((a, b) => double.parse(a['amount']!.substring(1))
            .compareTo(double.parse(b['amount']!.substring(1))));
      } else if (sortBy == 'date') {
        filteredMeals.sort(
            (a, b) => parseDate(a['date']!).compareTo(parseDate(b['date']!)));
      } else if (sortBy == 'status') {
        filteredMeals.sort((a, b) => a['status']!.compareTo(b['status']!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Meals',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: updateFilter,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Sort by'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text('Name'),
                                  onTap: () {
                                    sortMeals('name');
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: Text('Amount'),
                                  onTap: () {
                                    sortMeals('amount');
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: Text('Date'),
                                  onTap: () {
                                    sortMeals('date');
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: Text('Status'),
                                  onTap: () {
                                    sortMeals('status');
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      side: BorderSide(color: Colors.grey[300]!, width: 1.0),
                    ),
                    child: Icon(Icons.sort),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredMeals.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.grey[300]!, width: 1.0),
                    ),
                    child: ListTile(
                      title: Text(
                        filteredMeals[index]['name']!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filteredMeals[index]['date']!,
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Status: ${filteredMeals[index]['status']}',
                            style: TextStyle(
                              color: filteredMeals[index]['status'] ==
                                      'Approved'
                                  ? Colors.green
                                  : filteredMeals[index]['status'] == 'Rejected'
                                      ? Colors.red
                                      : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      trailing: Text(
                        filteredMeals[index]['amount']!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
