import 'package:get/get.dart';

class TyvaaTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'no_internet': 'No Internet',
      'offline_message': 'You are offline or your network is unusable.',
      'back_online': 'Back Online',
      'online_message': 'Internet connection restored.',
      'notifications': 'Notifications',
      'delete_notifications': 'Delete Notifications',
      'delete_confirmation':
          'Are you sure you want to delete all notifications?',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'retry': 'Retry',
      'no_notifications': 'No Notifications',
      'no_notifications_message':
          'You don\'t have any notifications at the moment.',
      'refresh': 'Refresh',
      'delete_notification': 'Delete',
      'mark_as_read': 'Mark as Read',
      'just_now': 'Just now',
      'hours_ago': '{hours} hour(s) ago',
      'minutes_ago': '{minutes} minute(s) ago',
      'days_ago': '{days} day(s) ago',
    },
    'fr': {
      'no_internet': 'Pas d\'Internet',
      'offline_message':
          'Vous êtes hors ligne ou votre réseau est inutilisable.',
      'back_online': 'Retour en ligne',
      'online_message': 'La connexion Internet a été rétablie.',
      'notifications': 'Notifications',
      'delete_notifications': 'Supprimer les notifications',
      'delete_confirmation':
          'Êtes-vous sûr de vouloir supprimer toutes les notifications?',
      'cancel': 'Annuler',
      'delete': 'Supprimer',
      'retry': 'Réessayer',
      'no_notifications': 'Aucune notification',
      'no_notifications_message':
          'Vous n\'avez pas de notifications pour le moment.',
      'refresh': 'Actualiser',
      'delete_notification': 'Supprimer',
      'mark_as_read': 'Marquer comme lu',
      'just_now': 'À l\'instant',
      'hours_ago': 'Il y a {hours} heure(s)',
      'minutes_ago': 'Il y a {minutes} minute(s)',
      'days_ago': 'Il y a {days} jour(s)',
    },
  };
}
