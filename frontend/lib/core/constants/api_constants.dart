class ApiConstants {
  static const String baseUrl = 'http://134.185.104.136:8080';

  // Offices
  static const String offices = '/api/offices';
  static String officeDetail(int id) => '/api/offices/$id';
  static String officeStatus(int id) => '/api/offices/$id/status';
  static const String nearbyOffices = '/api/offices/nearby';

  // Categories
  static const String categories = '/api/categories';
  static String categoryDetail(int id) => '/api/categories/$id';

  // Queue Status
  static String queueStatus(int officeId) => '/api/queue-status/$officeId';

  // Pre-Registration
  static const String preRegistrations = '/api/pre-registrations';
  static String preRegistrationDetail(int id) => '/api/pre-registrations/$id';
  static String preRegistrationsByUser(int userId) =>
      '/api/pre-registrations/user/$userId';
  static String preRegistrationStatus(int id) =>
      '/api/pre-registrations/$id/status';

  // AI
  static const String aiClassify = '/api/ai/classify';
  static const String aiSummarize = '/api/ai/summarize';
}
