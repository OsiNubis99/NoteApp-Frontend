import 'package:geolocator/geolocator.dart';

class LocationService {

Future<Position> determinePosition() async {
  bool serviceEnabled;

  LocationPermission permission;
  
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('El servicio de localización está desactivado');
  }

  permission = await Geolocator.checkPermission();
  if(permission == LocationPermission.denied){
    permission = await Geolocator.requestPermission();
    return Future.error('Los permisos de localización han sido denegados');
  }

  else if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'LLos servicios de localización están permanentemente desabilitados.');
  }

  return await Geolocator.getCurrentPosition();
}

void getCurrentLocation() async{
  Position position = await determinePosition();
  print(position.latitude);
  print(position.longitude);
}

}
