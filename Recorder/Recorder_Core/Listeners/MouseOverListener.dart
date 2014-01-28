part of Listeners;

class MouseOverListener implements IListener 
{
  EventObserver _eventObserver;
  
  MouseOverListener(EventObserver eventObserver)
  {
    _eventObserver = eventObserver;
  }
  
  void AttachEvent() {
    document.addEventListener("mouseover", _eventHandler, false);
  }

  void _eventHandler(FocusEvent e) {
    MouseOverEventType mouseOverEventType = new MouseOverEventType();
    mouseOverEventType.Target =  PathUtilities.getPath(e.target);
    
    _eventObserver.AddEvent(mouseOverEventType);
  }
}