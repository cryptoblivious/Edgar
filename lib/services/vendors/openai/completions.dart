import 'package:edgar/services/vendors/openai/requests.dart';

Stream<String> onceUponATime() {
  String prompt = 'Once upon a time';
  return getCompletionStream(prompt);
}
