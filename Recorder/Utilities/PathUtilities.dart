library Utilities;

import '../Models/XPath.dart';
import "dart:html";

class PathUtilities
{
   static XPath getPath(Element el)
  {
    XPath xPath = new XPath();
    while(el != document.body)
    {
      xPath.addPathIndex(getIndexFromParent(el));
      el = el.parentNode;
    }
  }
  
  static int getIndexFromParent(Element el)
  {
    int index = 0;
    while(el.previousNode != null)
    {
      index++;
    }
    return index;
  }
}