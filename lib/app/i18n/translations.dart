import 'package:get/get.dart';

class TyvaaTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'no_internet': 'No Internet',
      'offline_message': 'You are offline or your network is unusable.',
      'back_online': 'Back Online',
      'online_message': 'Internet connection restored.',
    },
    'fr': {
      'no_internet': 'Pas d\'Internet',
      'offline_message':
          'Vous êtes hors ligne ou votre réseau est inutilisable.',
      'back_online': 'Retour en ligne',
      'online_message': 'La connexion Internet a été rétablie.',
    },
  };
}
