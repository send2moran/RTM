library Listeners;

import "dart:html";
import "IListener.dart";
import "../Observers/EventObserver.dart";
import "../Models/EventTypes/MouseMove.dart";

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
    
    mouseMoveType.X = e.clientX + document.body.scrollLeft;
    mouseMoveType.Y = e.clientY + document.body.scrollTop;
    
    _eventObserver.AddEvent(mouseMoveType);
  }
}