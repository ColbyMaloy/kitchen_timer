import 'dart:async';

class EggTimer {
  final Stopwatch stopwatch = Stopwatch();
  final Duration maxTime;
  Duration _currentTime = const Duration(seconds: 0);
  EggTimerState state = EggTimerState.ready;
  Duration lastStartTime = const Duration(seconds: 0);
  Function onTimerUpdate;

  EggTimer({this.maxTime, this.onTimerUpdate});

  get currentTime {
    return _currentTime;
  }

  set currentTime(newTime) {
    if (state == EggTimerState.ready) {
      _currentTime = newTime;
      lastStartTime = currentTime;
    }
  }

  resume() {
    if (state != EggTimerState.running) {
      if (state == EggTimerState.ready) {
        currentTime = roundToMinute(currentTime);
        lastStartTime = currentTime;
      }
      state = EggTimerState.running;

      stopwatch.start();
      tick();
    }
  }

  roundToMinute(Duration duration) {
    return Duration(minutes: (duration.inSeconds / 60).round());
  }

  restart() {
    if (state == EggTimerState.paused) {
      state = EggTimerState.running;
      currentTime = lastStartTime;
      stopwatch.reset();
      stopwatch.start();
      tick();
    }
  }

  reset() {
    if (state == EggTimerState.paused) {
      state = EggTimerState.ready;
      currentTime = const Duration(seconds: 0);
      lastStartTime = currentTime;
      stopwatch.reset();
      if (null != onTimerUpdate) {
        onTimerUpdate();
      }
    }
  }

  tick() {
    print("Current Time:${_currentTime.inSeconds}");

    _currentTime = (lastStartTime - stopwatch.elapsed);

    if (currentTime.inSeconds > 0) {
      Timer(Duration(seconds: 1), tick);
    } else {
      state = EggTimerState.ready;
    }

    if (onTimerUpdate != null) {
      onTimerUpdate();
    }
  }

  pause() {
    if (state == EggTimerState.running) {
      state = EggTimerState.paused;
      stopwatch.stop();

      if (null != onTimerUpdate) {
        onTimerUpdate();
      }
    }
  }
}

enum EggTimerState {
  ready,
  running,
  paused,
}
