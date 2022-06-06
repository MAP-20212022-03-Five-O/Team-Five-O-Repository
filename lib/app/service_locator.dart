import 'package:five_o_car_rental/services/auth_service.dart';
import 'package:five_o_car_rental/services/auth_service_abstract.dart';
import 'package:five_o_car_rental/services/vehicle_service.dart';
import 'package:five_o_car_rental/viewmodel/addvehicle_viewmodel.dart';
import 'package:five_o_car_rental/viewmodel/login_viewmodel.dart';
import 'package:five_o_car_rental/viewmodel/register_viewmodel.dart';
import 'package:five_o_car_rental/viewmodel/resetpwd_viewmodel.dart';
import 'package:map_mvvm/service_locator.dart';

import '../services/services.dart';
import '../services/vehicle_service_abstract.dart';
import '../services/vehicle_service.dart';

final locator = ServiceLocator.locator;

Future<void> initializeServiceLocator() async {
  // In case of using Firebase services, Firebase must be initialized first before the service locator,
  //  because viewmodels may need to access firebase during the creation of the objects.

  // To comply with Dependency Inversion, the Firebase.initializeApp() is called in a dedicated service file.
  //  So that, if you want to change to different services (other than Firebase), you can do so by simply
  //  defining another ServiceInitializer class.

  // await Firebase.initializeApp();

  // Register first and then run immediately
  locator.registerLazySingleton<ServiceInitializer>(
      () => ServiceInitializerFirebase());

  final serviceInitializer = locator<ServiceInitializer>();
  await serviceInitializer.init();

  // Register Services
  locator.registerLazySingleton<AuthServiceAbstract>(() => authService());
  locator.registerLazySingleton<VehicleServiceAbstract>(() => VehicleService());

  // // Register Viewmodels
  locator.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  locator.registerLazySingleton<ResetPasswordViewModel>(
      () => ResetPasswordViewModel());
  locator.registerLazySingleton<RegisterViewModel>(() => RegisterViewModel());
  locator
      .registerLazySingleton<AddVehicleViewModel>(() => AddVehicleViewModel());
}
