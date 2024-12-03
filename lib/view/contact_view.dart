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

  bool _isEditing = false;
  int _editingIndex = -1;

  void _addContact() {
    String name = _nameController.text;
    String number = _numberController.text;

    if (name.isNotEmpty && number.isNotEmpty) {
      _controller.addContact(name, number);
      setState(() {});
      _nameController.clear();
      _numberController.clear();
    }
  }

  void _startEditing(int index) {
    setState(() {
      _isEditing = true;
      _editingIndex = index;
      _nameController.text = _controller.getContacts()[index].name;
      _numberController.text = _controller.getContacts()[index].number;
    });
  }

  void _updateContact() {
    String name = _nameController.text;
    String number = _numberController.text;

    if (name.isNotEmpty && number.isNotEmpty) {
      _controller.updateContact(_editingIndex, name, number);
      setState(() {
        _isEditing = false;
        _editingIndex = -1;
      });
      _nameController.clear();
      _numberController.clear();
    }
  }

  void _deleteContact(int index) {
    _controller.deleteContact(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Manager"),
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
            if (_isEditing) // Show "Update" button only when editing
              ElevatedButton(
                onPressed: _updateContact,
                child: const Text("Update"),
              ),
            if (!_isEditing)
              ElevatedButton(
                onPressed: _addContact,
                child: const Text("Add Contact"),
              ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _controller.getContacts().length,
                itemBuilder: (context, index) {
                  final contact = _controller.getContacts()[index];
                  return ListTile(
                    title: Text(contact.name),
                    subtitle: Text(contact.number),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _startEditing(index),
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
