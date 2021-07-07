part of 'helpers.dart';

void displayMessage(BuildContext context) {
  if (Platform.isAndroid)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Por favor espere'),
        content: Text('Calculando ruta...'),
      ),
    );

  if (Platform.isIOS)
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Por favor espere'),
        content: CupertinoActivityIndicator(),
      ),
    );
}
