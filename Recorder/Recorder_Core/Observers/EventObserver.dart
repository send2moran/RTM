library Observers;
import "dart:html";
import "../Libraries/EventTypesLib.dart";

class EventObserver
{
  List _Events;
  
  EventObserver()
  {
    _Events = new List();
  }
  
  void AddEvent(Object event)
  {
    _Events.add(event);
    
    //window.console.log(event);
    if(event is MouseMove){
      print('${event.Y} | ${event.X} ');
    }else{
      print(event);
    }
  }
}