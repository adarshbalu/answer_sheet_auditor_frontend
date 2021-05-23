class URL {
  // static const String BASE_URL = 'https://answer-sheet-app.herokuapp.com/';
  static const String BASE_URL = 'http://192.168.1.7:8000/';
  // static const String BASE_URL = 'http://192.168.43.104:8000/';

  static const String LOG_IN_PATH = 'api/auth/signin/';
  static const String LOG_IN_URL = BASE_URL + LOG_IN_PATH;

  static const String SIGN_UP_PATH = 'api/auth/signup/';
  static const String SIGN_UP_URL = BASE_URL + SIGN_UP_PATH;

  static const String LIST_ALL_EXAMS_PATH = 'api/auditor/exam/';
  static const String LIST_ALL_EXAMS_URL = BASE_URL + LIST_ALL_EXAMS_PATH;

  static const String CREATE_EXAM_PATH = 'api/auditor/exam/';
  static const String CREATE_EXAM_URL = BASE_URL + CREATE_EXAM_PATH;

  static const String VIEW_EXAM_PATH = 'api/auditor/exam/';
  static const String VIEW_EXAM_URL = BASE_URL + CREATE_EXAM_PATH;
}
