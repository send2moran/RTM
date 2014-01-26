library EventTypes;

import "../XPath.dart";
import "ITargetBased.dart";

class KeyUp implements ITargetBased
{
  XPath Target;
  String Key;
}