part of Listeners;

abstract class IListener
{
  IListener(EventObserver eventObserver);
  
  void AttachEvent();
  
  void _eventHandler(Event e);
}