part of Listeners;

class FocusListener implements IListener 
{
  EventObserver _eventObserver;
  
  FocusListener(EventObserver eventObserver)
  {
    _eventObserver = eventObserver;
  }
  
  void AttachEvent() {
    document.querySelectorAll('input[type="text"]').forEach((el) => el.addEventListener("focus", _eventHandler, false));
  }

  void _eventHandler(FocusEvent e) {
    Focus focusType = new Focus();
    focusType.Target =  PathUtilities.getPath(e.target);
    
    _eventObserver.AddEvent(focusType);
  }
}