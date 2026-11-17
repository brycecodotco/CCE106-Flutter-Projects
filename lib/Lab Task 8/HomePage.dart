
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labtasks/Lab Task 9/Login.dart';
import 'package:labtasks/auth_service.dart';
import 'package:labtasks/crud_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CrudService service = CrudService();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController quantityCtrl = TextEditingController();

  bool showFavorites = false;

  @override
  void dispose() {
    nameCtrl.dispose();
    quantityCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Firebase Codotco'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            AuthService().signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
          },
        )],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => openAddDialog(context),
      ),

      body: Column(
        children: [
          // FAVORITE FILTER
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All Items'),
                  selected: !showFavorites,
                  selectedColor: Colors.teal.shade200,
                  onSelected: (value) {
                    setState(() {
                      showFavorites = false;
                    });
                  },
                ),
                const SizedBox(width: 10),
                FilterChip(
                  avatar: const Icon(Icons.favorite, size: 18),
                  label: const Text('Favorites'),
                  selected: showFavorites,
                  selectedColor: Colors.red.shade100,
                  onSelected: (value) {
                    setState(() {
                      showFavorites = value;
                    });
                  },
                ),
              ],
            ),
          ),

          // FIREBASE ITEMS
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: service.getItems(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final docs = snapshot.data!.docs;

                // FILTER FAVORITES
                final filteredDocs = docs.where((item) {
                  final data = item.data() as Map<String, dynamic>;
                  final isFavorite = data['favorite'] == true;

                  return showFavorites ? isFavorite : true;
                }).toList();

                if (filteredDocs.isEmpty) {
                  return Center(
                    child: Text(
                      showFavorites
                          ? 'No favorite items found.'
                          : 'No items found.',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: filteredDocs.length,
                  itemBuilder: (context, index) {
                    var item = filteredDocs[index];

                    final data =
                        item.data() as Map<String, dynamic>;

                    final bool isFavorite =
                        data['favorite'] == true;

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 6),

                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),

                        title: Text(
                          data['name'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: Text(
                          'Quantity ${data['quantity']}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // FAVORITE BUTTON
                            IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                service.updateFavorite(
                                  item.id,
                                  !isFavorite,
                                );
                              },
                            ),

                            // EDIT BUTTON
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.orange,
                              ),
                              onPressed: () =>
                                  openEditDialog(context, item),
                            ),

                            // DELETE BUTTON
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () =>
                                  _confirmDelete(context, item.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // DELETE UI
  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete item'),
        content: const Text(
          'Are you sure you want to delete this item?',
        ),
        actions: [
          TextButton(
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              service.deleteItem(id);
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  // ADD UI
  void openAddDialog(BuildContext context) {
    nameCtrl.clear();
    quantityCtrl.clear();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: quantityCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
            ),
            child: const Text('Save'),
            onPressed: () {
              final quantity = int.tryParse(quantityCtrl.text);

              if (nameCtrl.text.trim().isNotEmpty &&
                  quantity != null) {
                service.addItem(
                  nameCtrl.text.trim(),
                  quantity,
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  // EDIT UI
  void openEditDialog(
    BuildContext context,
    DocumentSnapshot item,
  ) {
    nameCtrl.text = item['name'];
    quantityCtrl.text = item['quantity'].toString();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: quantityCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: const Text('Update'),
            onPressed: () {
              final quantity = int.tryParse(quantityCtrl.text);

              if (nameCtrl.text.trim().isNotEmpty &&
                  quantity != null) {
                service.updateItem(
                  item.id,
                  nameCtrl.text.trim(),
                  quantity,
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
