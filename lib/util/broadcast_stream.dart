import 'dart:async';

class BroadcastStream {
  static StreamController<String> streamController;
  BroadcastStream() {
    streamController = new StreamController.broadcast();
  }

  static getStream() {
    if (streamController == null) {
      streamController = new StreamController.broadcast();
    }
    return streamController;
  }
}

void sendBroadcastMessage(String key) {
  BroadcastStream.getStream().add(key);
}

const String refreshProfileSummary = 'refreshProfileSummary';
const String refreshProfileEducation = 'refreshEducation';
const String refreshProfileExperience = 'refreshExperience';
const String refreshProfileSkill = 'refreshSkill';
const String refreshAccomplishments = 'refreshAccomplishments';

/* BroadcastStream.getStream().stream.listen((data) {
      if (data.toString().compareTo(BroadcastStream.refreshSkill) == 0) {
        getMyReservations();
      }

      
    });*/
