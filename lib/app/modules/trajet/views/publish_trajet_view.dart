import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/publish_trajet_controller.dart';

class PublishTrajetView extends GetView<PublishTrajetController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Publier un trajet'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildTextField(
              label: 'Point de départ',
              hint: 'Ex: Paris',
              onChanged: controller.departure,
            ),
            SizedBox(height: 12),
            _buildTextField(
              label: 'Destination',
              hint: 'Ex: Lyon',
              onChanged: controller.destination,
            ),
            SizedBox(height: 12),
            _buildDateTimePicker(context),
            SizedBox(height: 12),
            _buildPlacesPicker(),
            SizedBox(height: 12),
            _buildTextField(
              label: 'Commentaire (optionnel)',
              hint: 'Ex: 1 valise max, pas d’animaux',
              onChanged: controller.comment,
              maxLines: 3,
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Icon(Icons.check),
              label: Text('Publier le trajet'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: controller.publishTrajet,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required RxString onChanged,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        TextField(
          onChanged: onChanged,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimePicker(BuildContext context) {
    return Obx(() {
      final selected = controller.dateTime.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Date & Heure', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          InkWell(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now().add(Duration(days: 1)),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 30)),
              );
              if (date != null) {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(hour: 12, minute: 0),
                );
                if (time != null) {
                  controller.dateTime.value = DateTime(
                    date.year,
                    date.month,
                    date.day,
                    time.hour,
                    time.minute,
                  );
                }
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                selected != null
                    ? DateFormat('dd MMM yyyy – HH:mm').format(selected)
                    : 'Choisir la date et l’heure',
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildPlacesPicker() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nombre de places',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  if (controller.places.value > 1) controller.places.value--;
                },
              ),
              Text('${controller.places.value} place(s)'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  if (controller.places.value < 8) controller.places.value++;
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}
