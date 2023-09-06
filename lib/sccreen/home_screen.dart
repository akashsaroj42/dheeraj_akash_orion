import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_01/sccreen/add_post.dart';
import 'package:project_01/sccreen/allitem.dart';
import 'package:project_01/sccreen/new_post_screen.dart';
import '../sccreen/drawer.dart';

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          "ORION",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Column(
            children: [
              Center(
                child: InkWell(
                  onTap: () {
                    // Add your onTap logic here
                  },
                  child: Container(
                    width: 380,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white12,
                        width: 1.4,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'Find Products',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          height: 46,
                          width: 80,
                          child: const Center(
                            child: Text(
                              'Search',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                  height: 16), // Adding spacing below the PreferredSize widget
            ],
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.add_box),
              iconSize: 32,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const newpost(),
                  ),
                );
              }),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(15), // Adjust the radius as needed
              child: Container(
                color: Colors.grey[900],
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    const Tab(
                      text: "PRODUCT",
                    ),
                    const Tab(
                      text: "NEAR BY",
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('post')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      // Check if snapshot has data and if data.docs is not empty
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text('No data available'),
                        );
                      }

                      final List<Map<String, dynamic>> items = snapshot
                          .data!.docs
                          .map((doc) => doc.data() as Map<String, dynamic>)
                          .toList();

                      // Pad the items list to make it a multiple of 2
                      while (items.length % 2 != 0) {
                        items.add({});
                      }

                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: (items.length / 2).ceil(),
                        itemBuilder: (context, rowIndex) {
                          final int startIndex = rowIndex * 2;
                          final int endIndex = startIndex + 2;

                          return Row(
                            children:
                                items.sublist(startIndex, endIndex).map((snap) {
                              return Expanded(
                                child: snap.isNotEmpty
                                    ? AllItem(
                                        snap: snap,
                                      )
                                      
                                      
                                    : SizedBox
                                        .shrink(), // Use SizedBox.shrink() for empty items
                              );
                            }).toList(),
                          );
                        },
                      );
                    },
                  ),
                  const Center(
                    child: Text('Tab 2 Content'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: DrawerPage(), // Note: Use uppercase CamelCase for class names
    );
  }
}
