library Observers;

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
    print(event);
  }
}