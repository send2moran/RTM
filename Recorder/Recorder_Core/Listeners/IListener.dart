library Listeners;

import "dart:html";
import "../Observers/EventObserver.dart";

abstract class IListener
{
  IListener(EventObserver eventObserver);
  
  void AttachEvent();
  
  void _eventHandler(Event e);
}