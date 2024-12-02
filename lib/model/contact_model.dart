class Contact {
  String name;
  String number;

  Contact({required this.name, required this.number});
}

class ContactModel {
  final List<Contact> _contacts = [];

  void addContact(Contact contact) {
    _contacts.add(contact);
  }

  void deleteContact(int index) {
    if (index >= 0 && index < _contacts.length) {
      _contacts.removeAt(index);
    }
  }

  void updateContact(int index, Contact contact) {
    if (index >= 0 && index < _contacts.length) {
      _contacts[index] = contact;
    }
  }

  List<Contact> getContacts() {
    return _contacts;
  }
}
