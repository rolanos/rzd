const String baseUrl = 'https://test-dev.pochet.ru/ru/api';

///POST
const String loginUrl = '$baseUrl/login/';

///POST
const String logoutUrl = '$baseUrl/logout/';

///GET Льготы
const String privilegesUrl = '$baseUrl/privileges_list/';

///GET История
const String historyUrl = '$baseUrl/user_requests/';

///GET Профиль
const String userProfile = '$baseUrl/profile/';

//GET Статус
const String checkStatusUrl = '$baseUrl/status/';

//POST регистрация
const String registerUrl = '$baseUrl/register/';

const String sentOtpUrl = '$baseUrl/code/request/';

const String checkCode = '$baseUrl/code/check/';

const String getMessagesUrl = '$baseUrl/messages/';

const String tickAllMessagesUrl = '$baseUrl/messages/mark_read_all/';

const String getAppealsUrl = '$baseUrl/user_requests/';

const String getPrivilegesUrl = '$baseUrl/privileges_used/';
