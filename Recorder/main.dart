import "Listeners/MouseMoveListener.dart";
import "Observers/EventObserver.dart";

void main()
{
  EventObserver eventObserver = new EventObserver();
  MouseMoveListener mouseMoveListener = new MouseMoveListener(eventObserver);
  mouseMoveListener.AttachEvent();
  

}