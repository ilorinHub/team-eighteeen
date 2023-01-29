import 'package:egov/app_container.dart';

enum Environment { dev, qa, prod }

class AppConfig {
  AppConfig._();

  static Environment environment = Environment.dev;

  // init dependencies needed during the runApp process
  static Future<void> initDependencies({
    Environment environment = Environment.dev,
  }) async {
    AppConfig.environment = environment;
    AppConfig.setEnvironment(environment);
    await AppInjectionContainer.init();
  }

  // constants values to be given based on the environment set
  static late Map<String, String> _constants;

  // set the environment to run the app in
  static void setEnvironment(Environment environment) {
    AppConfig.environment = environment;
    switch (environment) {
      case Environment.dev:
        _constants = _Constants.devConstants;
        break;

      case Environment.qa:
        _constants = _Constants.qaConstants;
        break;
      case Environment.prod:
        _constants = _Constants.liveConstants;
        break;
    }
  }

  // base url based on the environment set
  static String get baseUrl {
    return _constants[_Constants.baseUrl]!;
  }

  // api version
  static String get apiVersion {
    return _constants[_Constants.apiVersion]!;
  }

  // app name based on the environment set
  static String get appName {
    return _constants[_Constants.appName]!;
  }
}

// holds environment specific variables
class _Constants {
  static const baseUrl = 'BASE_URL';
  static const apiVersion = 'API_VERSION';
  static const appName = 'APP_NAME';

  static Map<String, String> devConstants = {
    baseUrl: 'https://',
    apiVersion: '',
    appName: '',
  };

  static Map<String, String> qaConstants = {
    baseUrl: '',
    apiVersion: '',
    appName: '',
  };

  static Map<String, String> liveConstants = {
    baseUrl: '',
    apiVersion: '',
    appName: '',
  };
}
