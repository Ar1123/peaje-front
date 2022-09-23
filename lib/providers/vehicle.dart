import 'package:peaje/config/api/http_connect.dart';
import '../models/vehicle.dart';

class VehicleProvider {
  final _requestHttp = HttpRequest();
  Future<VehicleModel> geVehicled() async {
    VehicleModel vehicleModel = VehicleModel();
    final result = await _requestHttp.getAll(
      headers: {},
      path: "vehicle-dev/getAll",
    );
    vehicleModel = VehicleModel.fromJson(result);
    return vehicleModel;
  }
}
