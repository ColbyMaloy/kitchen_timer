import 'dart:async';

class EggTimer{

  final Stopwatch stopwatch = Stopwatch();
  final Duration maxTime;
  Duration _currentTime = const Duration(seconds: 0);
  EggTimerState state = EggTimerState.ready;
  Duration lastStartTime = const Duration(seconds: 0);
  Function onTimerUpdate;


  EggTimer({
    this.maxTime,this.onTimerUpdate
  });

  get currentTime{
    return _currentTime;
  }

  set currentTime(newTime){
    if(state == EggTimerState.ready){
      _currentTime = newTime;
      lastStartTime = currentTime;
    }

  }

  resume(){
    state = EggTimerState.running;
    
    stopwatch.start();
    tick();
  }

  tick(){
    print("Current Time:${_currentTime.inSeconds}");

    _currentTime = (lastStartTime - stopwatch.elapsed);

    
    

    if(currentTime.inSeconds>0){
      Timer(Duration(seconds: 1),tick);

    }else{
      state =EggTimerState.ready;
    }

    if(onTimerUpdate!=null){
      onTimerUpdate();
    }

  }
  pause(){

  }
  
  

}

enum EggTimerState{
  ready,
  running,
  paused,
}