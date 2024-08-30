import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:coolapp/select_page.dart';
import 'package:http/http.dart' as http;
import 'package:coolapp/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Section> section = [];
  bool isGridView = false; // Toggle state for List/Grid view

  Future<List<Section>> getData() async {
    final response = await http
        .get(Uri.parse('https://api.mocklets.com/p6839/explore-cred'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> sections = data['sections'];
      return sections.map((item) => Section.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<List<Section>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            section = snapshot.data!;

            return ListView.builder(
              itemCount: section.length + 1, // +1 for the title section
              itemBuilder: (context, index) {
                if (index == 0) {
                  // First item is the "explore CRED" title with toggle button
                  return Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'explore',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            ),
                            Text(
                              'CRED',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            isGridView ? Icons.view_list : Icons.grid_view,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              isGridView = !isGridView;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  // Following items are the sections
                  int sectionIndex = index - 1; // Adjust index for sections

                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0d0d0d),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section[sectionIndex].templateProperties.header.title,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        isGridView
                            ? GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1 / 1.2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemCount: section[sectionIndex]
                                    .templateProperties
                                    .items
                                    .length,
                                itemBuilder: (context, itemIndex) {
                                  final item = section[sectionIndex]
                                      .templateProperties
                                      .items[itemIndex];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SelectPage(
                                            itemName: item.displayData.name,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 64,
                                          height: 64,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 1),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Center(
                                            child: Image.network(
                                              item.displayData.iconUrl,
                                              width: 30,
                                              height: 30,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Icon(Icons.error,
                                                    size: 24);
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Center(
                                          child: Text(
                                            item.displayData.name,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              height:
                                                  1.5, // Increase the line height
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Column(
                                children: section[sectionIndex]
                                    .templateProperties
                                    .items
                                    .map((item) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SelectPage(
                                                itemName: item.displayData.name,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 64,
                                              height: 64,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 34, 34, 34),
                                                    width: 1),
                                                shape: BoxShape.rectangle,
                                              ),
                                              child: Center(
                                                child: Image.network(
                                                  item.displayData.iconUrl,
                                                  width: 30,
                                                  height: 30,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Icon(
                                                        Icons.error,
                                                        size: 24);
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.displayData.name,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    height:
                                                        1.5, // Increase the line height
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  item.displayData.description,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color.fromARGB(
                                                        255, 31, 30, 30),
                                                    height:
                                                        1.5, // Increase the line height
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            )),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                }).toList(),
                              ),
                      ],
                    ),
                  );
                }
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
