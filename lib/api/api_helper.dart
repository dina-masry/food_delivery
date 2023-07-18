import 'api_response.dart';

mixin ApiHelper{
  ApiResponse get errorResponse => ApiResponse(success: false, message: 'Something goes wrong');

}