part of Listeners;

class MouseMoveListener implements IListener 
{
  EventObserver _eventObserver;
  
  MouseMoveListener(EventObserver eventObserver)
  {
    _eventObserver = eventObserver;
  }
  
  void AttachEvent() {
    document.addEventListener("mousemove", _eventHandler, false);
  }

  void _eventHandler(MouseEvent e) {
    MouseMove mouseMoveType = new MouseMove();

    mouseMoveType.X = e.client.x + document.body.scrollLeft;
    mouseMoveType.Y = e.client.y + document.body.scrollTop;
    
    _eventObserver.AddEvent(mouseMoveType);
  }
}