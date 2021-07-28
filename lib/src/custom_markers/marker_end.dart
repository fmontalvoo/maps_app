part of 'custom_marker.dart';

class MarkerEnd extends CustomPainter {
  final String destinyName;
  final double distance;

  MarkerEnd(this.destinyName, this.distance);

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    final paint = Paint()..color = Colors.black;

    // Circulos
    final r1 = 20.0;
    final r2 = 10.0;

    canvas.drawCircle(Offset(r1, height - r1), r1, paint);
    paint.color = Colors.white;
    canvas.drawCircle(Offset(r1, height - r1), r2, paint);

    // Sombra
    final path = Path();

    path.moveTo(0, 20);
    path.moveTo(width - 10, 20);
    path.moveTo(width - 10, 100);
    path.moveTo(0, 100);

    canvas.drawShadow(path, Colors.black87, 10, false);

    // Caja
    final cajaB = Rect.fromLTWH(0, 20, width - 10, 80);
    canvas.drawRect(cajaB, paint);

    paint.color = Colors.black;
    final cajaN = Rect.fromLTWH(0, 20, 70, 80);
    canvas.drawRect(cajaN, paint);

    // Texto
    TextSpan textSpan = TextSpan(
      text: '${(distance / 1000).toStringAsFixed(2)}',
      style: TextStyle(
        color: Colors.white,
        fontSize: 21.0,
        fontWeight: FontWeight.w400,
      ),
    );

    TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        minWidth: 70.0,
        maxWidth: 70.0,
      );

    textPainter.paint(canvas, Offset(0.0, 35.0));

    textSpan = TextSpan(
      text: 'Km',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
      ),
    );

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
        maxWidth: 70.0,
      );

    textPainter.paint(canvas, Offset(20.0, 67.0));

    // Ubicacion
    textSpan = TextSpan(
      text: destinyName,
      style: TextStyle(
        color: Colors.black,
        fontSize: 22.0,
        fontWeight: FontWeight.w400,
      ),
    );

    textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLines: 2,
      ellipsis: '...',
    )..layout(
        maxWidth: width - 100,
      );

    textPainter.paint(canvas, Offset(90.0, 30.0));
  }

  @override
  bool shouldRepaint(MarkerEnd oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MarkerEnd oldDelegate) => false;
}
