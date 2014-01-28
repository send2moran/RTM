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
    
    if(event is MouseMoveEventType){
      print('${event.Y} | ${event.X} ');
    }else{
      print(event);
    }
  }
}