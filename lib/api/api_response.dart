class ApiResponse<T>{
  late String message ;
  late bool success;
  T? object;
  ApiResponse(
      {
        required this.success,
        required this.message,
        this.object
      }
      );
}