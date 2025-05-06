import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/tyvaa_theme.dart';

class AideScreen extends StatelessWidget {
  const AideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    // Dynamic colors based on theme
    final backgroundColor =
        isDark ? AppColors.darkBackground : AppColors.background;
    final cardColor = isDark ? AppColors.cardDark : Colors.white;
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final dividerColor = isDark ? Colors.grey[800] : Colors.grey[300];
    final iconColor = isDark ? AppColors.primaryDark : AppColors.primary;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Aide',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App logo and version section
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.directions_car,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Tyvaa',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Version 1.0.3',
                      style: TextStyle(
                        color: textColor.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Help Topics Section
              Text(
                'OBTENIR DE L\'AIDE',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),

              // Help cards
              _buildHelpCard(
                context: context,
                title: 'Comment ça marche',
                description: 'Guide d\'utilisation de l\'application Tyvaa',
                icon: Icons.help_outline,
                cardColor: cardColor,
                textColor: textColor,
                iconColor: iconColor,
                onTap:
                    () => _navigateToHelpDetail(context, 'Comment ça marche'),
              ),

              _buildHelpCard(
                context: context,
                title: 'Réserver un trajet',
                description: 'Guide étape par étape pour réserver votre voyage',
                icon: Icons.bookmark_border,
                cardColor: cardColor,
                textColor: textColor,
                iconColor: iconColor,
                onTap:
                    () => _navigateToHelpDetail(context, 'Réserver un trajet'),
              ),

              _buildHelpCard(
                context: context,
                title: 'Publier un trajet',
                description:
                    'Comment proposer un trajet en tant que conducteur',
                icon: Icons.add_circle_outline,
                cardColor: cardColor,
                textColor: textColor,
                iconColor: iconColor,
                onTap:
                    () => _navigateToHelpDetail(context, 'Publier un trajet'),
              ),

              _buildHelpCard(
                context: context,
                title: 'Paiements et facturation',
                description: 'Informations sur les paiements et remboursements',
                icon: Icons.payment,
                cardColor: cardColor,
                textColor: textColor,
                iconColor: iconColor,
                onTap:
                    () => _navigateToHelpDetail(
                      context,
                      'Paiements et facturation',
                    ),
              ),

              const SizedBox(height: 32),

              // About and Legal Section
              Text(
                'À PROPOS & LÉGAL',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),

              // Legal Cards
              _buildHelpCard(
                context: context,
                title: 'Conditions d\'utilisation',
                description: 'Termes et conditions d\'utilisation de Tyvaa',
                icon: Icons.description_outlined,
                cardColor: cardColor,
                textColor: textColor,
                iconColor: iconColor,
                onTap:
                    () => _navigateToLegalDocument(
                      context,
                      'Conditions d\'utilisation',
                    ),
              ),

              _buildHelpCard(
                context: context,
                title: 'Politique de confidentialité',
                description: 'Comment nous protégeons vos données personnelles',
                icon: Icons.security,
                cardColor: cardColor,
                textColor: textColor,
                iconColor: iconColor,
                onTap:
                    () => _navigateToLegalDocument(
                      context,
                      'Politique de confidentialité',
                    ),
              ),

              _buildHelpCard(
                context: context,
                title: 'Licences',
                description: 'Licences des logiciels tiers utilisés',
                icon: Icons.verified_user_outlined,
                cardColor: cardColor,
                textColor: textColor,
                iconColor: iconColor,
                onTap: () => _navigateToLegalDocument(context, 'Licences'),
              ),

              const SizedBox(height: 32),

              // Contact section
              Text(
                'NOUS CONTACTER',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),

              _buildContactCard(
                context: context,
                cardColor: cardColor,
                textColor: textColor,
                iconColor: iconColor,
                dividerColor: dividerColor!,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color cardColor,
    required Color textColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: textColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: textColor.withOpacity(0.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required BuildContext context,
    required Color cardColor,
    required Color textColor,
    required Color iconColor,
    required Color dividerColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Email support
          _buildContactMethod(
            title: 'Email',
            subtitle: 'support@tyvaa.com',
            icon: Icons.email_outlined,
            iconColor: iconColor,
            textColor: textColor,
            onTap: () {
              // Implement email send functionality
            },
          ),
          Divider(height: 1, thickness: 1, color: dividerColor),

          // Phone support
          _buildContactMethod(
            title: 'Téléphone',
            subtitle: '+221 77 123 45 67',
            icon: Icons.phone_outlined,
            iconColor: iconColor,
            textColor: textColor,
            onTap: () {
              // Implement phone call functionality
            },
          ),
          Divider(height: 1, thickness: 1, color: dividerColor),

          // Chat support
          _buildContactMethod(
            title: 'Chat en direct',
            subtitle: 'Disponible 7j/7 de 8h à 22h',
            icon: Icons.chat_bubble_outline,
            iconColor: iconColor,
            textColor: textColor,
            onTap: () {
              // Implement chat support functionality
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactMethod({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToHelpDetail(BuildContext context, String topic) {
    Get.to(() => HelpDetailScreen(topic: topic));
  }

  void _navigateToLegalDocument(BuildContext context, String document) {
    Get.to(() => LegalDocumentScreen(document: document));
  }
}

// Help Detail Screen
class HelpDetailScreen extends StatelessWidget {
  final String topic;

  const HelpDetailScreen({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    final backgroundColor =
        isDark ? AppColors.darkBackground : AppColors.background;
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final cardColor = isDark ? AppColors.cardDark : Colors.white;

    // This is a placeholder - content would be loaded dynamically based on the topic
    final Map<String, List<Map<String, dynamic>>> helpContent = {
      'Comment ça marche': [
        {
          'title': 'Bienvenue sur Tyvaa',
          'content':
              'Tyvaa est une application de covoiturage communautaire qui vous permet de partager vos trajets avec d\'autres personnes. Économisez de l\'argent, réduisez votre empreinte carbone et faites de nouvelles rencontres !',
        },
        {
          'title': 'Créer votre compte',
          'content':
              'Pour commencer, inscrivez-vous avec votre email ou votre compte Facebook/Google. Remplissez votre profil avec une photo et une brève description pour instaurer la confiance dans la communauté.',
        },
        {
          'title': 'Rechercher un trajet',
          'content':
              'Utilisez la fonction de recherche pour trouver des trajets disponibles. Entrez votre point de départ, votre destination et la date souhaitée.',
        },
      ],
      'Réserver un trajet': [
        {
          'title': 'Rechercher un trajet disponible',
          'content':
              'Sur l\'écran principal, appuyez sur "Rechercher un trajet" et entrez vos critères de recherche.',
        },
        {
          'title': 'Choisir le trajet qui vous convient',
          'content':
              'Parcourez la liste des trajets disponibles et sélectionnez celui qui correspond le mieux à vos besoins en fonction de l\'heure, du prix et du conducteur.',
        },
        {
          'title': 'Confirmer et payer',
          'content':
              'Une fois votre choix fait, confirmez la réservation et procédez au paiement via les méthodes disponibles (carte bancaire, mobile money, etc.).',
        },
      ],
      // Add more topics as needed
    };

    final content = helpContent[topic] ?? [];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          topic,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Featured image or icon
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getIconForTopic(topic),
                    color: AppColors.primary,
                    size: 60,
                  ),
                ),
              ),

              // Content sections
              ...content.map(
                (section) => _buildHelpSection(
                  title: section['title'],
                  content: section['content'],
                  cardColor: cardColor,
                  textColor: textColor,
                ),
              ),

              // Feedback section
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Cette information vous a-t-elle été utile ?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFeedbackButton(
                          icon: Icons.thumb_up_outlined,
                          label: 'Oui',
                          color: AppColors.primary,
                          onTap: () {},
                        ),
                        const SizedBox(width: 16),
                        _buildFeedbackButton(
                          icon: Icons.thumb_down_outlined,
                          label: 'Non',
                          color: Colors.grey,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForTopic(String topic) {
    switch (topic) {
      case 'Comment ça marche':
        return Icons.help_outline;
      case 'Réserver un trajet':
        return Icons.bookmark_border;
      case 'Publier un trajet':
        return Icons.add_circle_outline;
      case 'Paiements et facturation':
        return Icons.payment;
      default:
        return Icons.info_outline;
    }
  }

  Widget _buildHelpSection({
    required String title,
    required String content,
    required Color cardColor,
    required Color textColor,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: textColor.withOpacity(0.8),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

// Legal Document Screen
class LegalDocumentScreen extends StatelessWidget {
  final String document;

  const LegalDocumentScreen({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    final backgroundColor =
        isDark ? AppColors.darkBackground : AppColors.background;
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final cardColor = isDark ? AppColors.cardDark : Colors.white;

    // This is placeholder content - in a real app, this would be loaded from a backend
    String content = '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, urna eu tincidunt consectetur, nisl nunc euismod nisl, eget euismod nisl nisl eget euismod. Sed euismod, urna eu tincidunt consectetur, nisl nunc euismod nisl, eget euismod nisl nisl eget euismod.

1. RESPONSABILITÉS
Sed euismod, urna eu tincidunt consectetur, nisl nunc euismod nisl, eget euismod nisl nisl eget euismod. Sed euismod, urna eu tincidunt consectetur, nisl nunc euismod nisl, eget euismod nisl nisl eget euismod.

2. PAIEMENTS ET REMBOURSEMENTS
Sed euismod, urna eu tincidunt consectetur, nisl nunc euismod nisl, eget euismod nisl nisl eget euismod. Sed euismod, urna eu tincidunt consectetur, nisl nunc euismod nisl, eget euismod nisl nisl eget euismod.

3. CONFIDENTIALITÉ DES DONNÉES
Sed euismod, urna eu tincidunt consectetur, nisl nunc euismod nisl, eget euismod nisl nisl eget euismod. Sed euismod, urna eu tincidunt consectetur, nisl nunc euismod nisl, eget euismod nisl nisl eget euismod.

4. ANNULATION
Sed euismod, urna eu tincidunt consectetur, nisl nunc euismod nisl, eget euismod nisl nisl eget euismod. Sed euismod, urna eu tincidunt consectetur, nisl nunc euismod nisl, eget euismod nisl nisl eget euismod.
''';

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          document,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: textColor),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.file_download_outlined, color: textColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Document date and version
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date de mise à jour',
                          style: TextStyle(
                            fontSize: 14,
                            color: textColor.withOpacity(0.7),
                          ),
                        ),
                        Text(
                          '15 avril 2025',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Version',
                          style: TextStyle(
                            fontSize: 14,
                            color: textColor.withOpacity(0.7),
                          ),
                        ),
                        Text(
                          '2.1',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Document content
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  content,
                  style: TextStyle(fontSize: 16, color: textColor, height: 1.6),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
