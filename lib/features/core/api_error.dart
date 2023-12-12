///Виды ошибок из API
enum ApiExeptionType {
  connectionError("Ошибка соединения!"),
  timeout("Ошибка! Время запроса истекло"),
  cancel("Ошибка! Запрос отклонен"),
  other("Ошибка! Неизвестная ошибка");

  const ApiExeptionType(this.errorMessage);

  final String errorMessage;
}

///Класс ошибки из api
class ApiError implements Exception {
  final String message;

  ApiError({required this.message});
}
