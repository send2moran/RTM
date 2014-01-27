import "Libraries/ListenersLib.dart";
import 'Observers/EventObserver.dart';

void main()
{
  EventObserver eventObserver = new EventObserver();
  MouseMoveListener mouseMoveListener = new MouseMoveListener(eventObserver);
  mouseMoveListener.AttachEvent();
  
  FocusListener focusListener = new FocusListener(eventObserver);
  focusListener.AttachEvent();
}