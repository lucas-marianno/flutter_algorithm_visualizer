enum Speed { slowAf, slow, fast, instant }

class SortingSpeed {
  Speed speed = Speed.fast;

  Future<void> delay() async {
    switch (speed) {
      case Speed.slowAf:
        await Future.delayed(const Duration(milliseconds: 1000));
        return;
      case Speed.slow:
        await Future.delayed(const Duration(milliseconds: 100));
        return;
      case Speed.fast:
        await Future.delayed(const Duration(milliseconds: 1));
        return;
      case Speed.instant:
        return;
      default:
        return;
    }
  }

  String label() {
    switch (speed) {
      case Speed.slowAf:
        return 'slow af';
      case Speed.slow:
        return 'slow';
      case Speed.fast:
        return 'fast';
      case Speed.instant:
        return 'instant';
      default:
        return '';
    }
  }

  double value() {
    switch (speed) {
      case Speed.slowAf:
        return 1;
      case Speed.slow:
        return 2;
      case Speed.fast:
        return 3;
      case Speed.instant:
        return 4;
      default:
        return 1;
    }
  }

  set setSpeed(Speed newSpeed) => speed = newSpeed;

  set setSpeedFromValue(int newSpeed) {
    switch (newSpeed) {
      case 1:
        speed = Speed.slowAf;
      case 2:
        speed = Speed.slow;
      case 3:
        speed = Speed.fast;
      case 4:
        speed = Speed.instant;
      default:
    }
  }
}
