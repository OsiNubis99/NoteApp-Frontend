import 'package:geolocator/geolocator.dart';

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
    if(permission == LocationPermission.denied){
    return Future.error('Los permisos de localización han sido denegados');
    }
  }

  else if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'LLos servicios de localización están permanentemente desabilitados.');
  }

  return await Geolocator.getCurrentPosition();
}

