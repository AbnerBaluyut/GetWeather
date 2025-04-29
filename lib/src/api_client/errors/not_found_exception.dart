import 'app_exception.dart';

class NotFoundException extends AppException {
  NotFoundException() : super("Error", code: 404);
}