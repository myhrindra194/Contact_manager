import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/contact_controller.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContactViewState createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final ContactController _controller = ContactController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  void _addContact() {
    String name = _nameController.text;
    String number = _numberController.text;

    if (name.isNotEmpty && number.isNotEmpty) {
      _controller.addContact(name, number as int);
      setState(() {});
      _nameController.clear();
      _numberController.clear();
    }
  }

  void _updateContact(int index) {
    _nameController.text = _controller.getContacts()[index].name;
    _numberController.text = _controller.getContacts()[index].number as String;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Modifier le contact"),
        content: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(labelText: 'Number'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              String name = _nameController.text;
              String number = _numberController.text;
              if (name.isNotEmpty && number.isNotEmpty) {
                _controller.updateContact(index, name, number as int);
                setState(() {});
                Navigator.pop(context);
              }
            },
            child: const Text("Mettre à jour"),
          ),
        ],
      ),
    );
  }

  void _deleteContact(int index) {
    _controller.deleteContact(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des Contacts"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(labelText: 'Number'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addContact,
              child: const Text("Ajouter un contact"),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _controller.getContacts().length,
                itemBuilder: (context, index) {
                  final contact = _controller.getContacts()[index];
                  return ListTile(
                    title: Text(contact.name),
                    subtitle: Text(contact.number as String),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _updateContact(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteContact(index),
                        ),
                      ],
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
