import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/design_system.dart';

class AideScreen extends StatelessWidget {
  const AideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.background(context),
      appBar: AppBar(
        backgroundColor: TColors.surface(context),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: TColors.textPrimary(context)),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Aide et Support',
          style: TextStyle(
            color: TColors.textPrimary(context),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSupportCard(context),
          const SizedBox(height: 24),
          _buildFAQList(context),
        ],
      ),
    );
  }

  Widget _buildSupportCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: TColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TColors.primary.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Besoin d\'aide ?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: TColors.textPrimary(context),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Notre équipe est disponible pour vous aider',
            style: TextStyle(
              fontSize: 16,
              color: TColors.textPrimary(context).withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _startSupportChat(),
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.chat_outlined, color: Colors.white),
              label: const Text(
                'Contacter le support',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQList(BuildContext context) {
    final faqs = [
      {
        'title': 'Comment réserver un trajet ?',
        'content':
            'Pour réserver un trajet, sélectionnez votre destination sur la carte et choisissez un chauffeur disponible. Suivez les étapes de paiement pour confirmer votre réservation.',
      },
      {
        'title': 'Problème de paiement',
        'content':
            'Si vous rencontrez des problèmes de paiement, vérifiez que vos informations bancaires sont à jour. Pour plus d\'aide, contactez notre support.',
      },
      {
        'title': 'Annulation de trajet',
        'content':
            'Vous pouvez annuler un trajet jusqu\'à 1 heure avant l\'heure prévue. Des frais peuvent s\'appliquer selon le moment de l\'annulation.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Questions fréquentes',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: TColors.textPrimary(context),
          ),
        ),
        const SizedBox(height: 16),
        ...faqs.map(
          (faq) => _buildFAQItem(context, faq['title']!, faq['content']!),
        ),
      ],
    );
  }

  Widget _buildFAQItem(BuildContext context, String title, String content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: TColors.surface(context),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            color: TColors.textPrimary(context),
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              content,
              style: TextStyle(
                color: TColors.textPrimary(context).withOpacity(0.8),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startSupportChat() {
    // TODO: Implement support chat navigation
    Get.snackbar(
      'Support Chat',
      'Démarrage de la conversation avec le support...',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
