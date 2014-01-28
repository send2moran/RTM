part of Listeners;

class MouseOutListener implements IListener 
{
  EventObserver _eventObserver;
  
  MouseOutListener(EventObserver eventObserver)
  {
    _eventObserver = eventObserver;
  }
  
  void AttachEvent() {
    document.addEventListener("mouseout", _eventHandler, false);
  }

  void _eventHandler(FocusEvent e) {
    MouseOutEventType mouseOutEvent = new MouseOutEventType();
    mouseOutEventType.Target =  PathUtilities.getPath(e.target);
    
    _eventObserver.AddEvent(mouseOutEventType);
  }
}