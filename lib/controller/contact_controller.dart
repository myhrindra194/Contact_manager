import 'package:flutter_application_1/model/contact_model.dart';

class ContactController {
  final ContactModel _model = ContactModel();

  void addContact(String name, String number) {
    Contact contact = Contact(name: name, number: number);
    _model.addContact(contact);
  }

  void deleteContact(int index) {
    _model.deleteContact(index);
  }

  void updateContact(int index, String name, String number) {
    Contact contact = Contact(name: name, number: number);
    _model.updateContact(index, contact);
  }

  List<Contact> getContacts() {
    return _model.getContacts();
  }
}
