import "Libraries/ListenersLib.dart";
import 'Observers/EventObserver.dart';

void main()
{
  EventObserver eventObserver = new EventObserver();
  List<IListener> listeners = [
    new MouseMoveListener(eventObserver),
    new FocusListener(eventObserver),
    new MouseOverListener(eventObserver),
    new MouseOutListener(eventObserver)    
  ];
  
  listeners.forEach((l) => l.AttachEvent());
}