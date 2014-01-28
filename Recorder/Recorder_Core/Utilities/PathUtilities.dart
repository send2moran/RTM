library Utilities;

import '../Models/XPath.dart';
import "dart:html";

class PathUtilities
{
   static XPath getPath(Element el)
  {
     if(el.attributes["XPath"] != null)
     {
       return XPath.fromString(el.attributes["XPath"]);
     }
     
    XPath xPath = new XPath();
    while(el != document.body)
    {
      xPath.addPathIndex(getIndexFromParent(el));
      el = el.parentNode;
    }
    
    el.attributes["XPath"] = xPath.toString();
    
    return xPath;
  }
  
  static int getIndexFromParent(Element el)
  {
    int index = 0;
    while(el.previousNode != null)
    {
      index++;
      el = el.previousNode;
    }
    return index;
  }
}