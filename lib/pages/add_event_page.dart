import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/event.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

/// Formatter personnalisé qui insère les `/` automatiquement
class DateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    var text = newValue.text;

    // Supprimer tout ce qui n’est pas un chiffre
    text = text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limiter à 8 chiffres (jjmmaaaa)
    if (text.length > 8) {
      text = text.substring(0, 8);
    }

    // Ajouter les séparateurs
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i == 1 || i == 3) && i != text.length - 1) {
        buffer.write('/');
      }
    }

    final formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

/// Fonction de validation (empêche 32/13/2025, etc.)
String? validateDate(String? value) {
  if (value == null || value.isEmpty) return "Veuillez entrer une date";
  if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
    return "Format invalide (jj/mm/aaaa)";
  }

  final parts = value.split('/');
  final jour = int.tryParse(parts[0]);
  final mois = int.tryParse(parts[1]);
  final annee = int.tryParse(parts[2]);

  if (jour == null || mois == null || annee == null) return "Date invalide";

  // Conversion en format ISO (aaaa-mm-jj)
  final dateIso = "$annee-${mois.toString().padLeft(2, '0')}-${jour.toString().padLeft(2, '0')}";
  final parsedDate = DateTime.tryParse(dateIso);

  if (parsedDate == null) return "Date invalide";

  // Vérifier que les composants correspondent (ex: 31/02/2025 → 03/03/2025)
  if (parsedDate.day != jour ||
      parsedDate.month != mois ||
      parsedDate.year != annee) {
    return "Date invalide";
  }

  return null; //la date est correcte
}


class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _dateController = TextEditingController();
  final _locationController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newEvent = Event(
        title: _titleController.text,
        subtitle: _subtitleController.text,
        date: _dateController.text,
        location: _locationController.text,
        imageUrl: _imageUrlController.text.isNotEmpty
            ? _imageUrlController.text
            : "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
        description: _descriptionController.text,
        price: double.tryParse(_priceController.text) ?? 0,
      );

      Navigator.pop(context, newEvent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter un événement")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Titre"),
                validator: (value) =>
                value == null || value.isEmpty ? "Champ requis" : null,
              ),
              TextFormField(
                controller: _subtitleController,
                decoration: const InputDecoration(labelText: "Sous-titre"),
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                    labelText: "Date",
                    hintText: 'jj/mm/aaaa '),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  DateTextInputFormatter(), //formatage intelligent jj/mm/aaaa
                ],
                validator: validateDate, //verifie si la date est correct
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: "Lieu"),
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: "Image (URL)"),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                maxLines: 3,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: "Prix (€)"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB9D904)),
                child: const Text("Ajouter l’événement"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
