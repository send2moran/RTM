part of Listeners;

class MouseMoveListener implements IListener 
{
  EventObserver _eventObserver;
  DateTime _lastMouseMoveDate;
  const int MOUSE_WAIT_INTERVAL = 1000;
  
  MouseMoveListener(EventObserver eventObserver)
  {
    _eventObserver = eventObserver;
  }
  
  void AttachEvent() {
    document.addEventListener("mousemove", _eventHandler, false);
  }

  void _eventHandler(MouseEvent e) {
    DateTime currentMouseMoveDate = new DateTime().now();
    
    if(_lastMouseMoveDate != null && _lastMouseMoveDate.difference(currentMouseMoveDate).inMilliseconds <= MOUSE_WAIT_INTERVAL)
      return;
    
    _lastMouseMoveDate = currentMouseMoveDate;
    
    MouseMoveEventType mouseMoveEventType = new MouseMoveEventType();

    mouseMoveEventType.X = e.client.x + document.body.scrollLeft;
    mouseMoveEventType.Y = e.client.y + document.body.scrollTop;
    
    _eventObserver.AddEvent(mouseMoveEventType);
  }
}