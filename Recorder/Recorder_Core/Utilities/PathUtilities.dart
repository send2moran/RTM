library Utilities;

import '../Models/XPath.dart';
import "dart:html";

class PathUtilities
{
   static XPath getPath(Element el)
  {
     if(el.XPath != null && el.XPath is XPath)
     {
       return el.XPath;
     }
     
    XPath xPath = new XPath();
    while(el != document.body)
    {
      xPath.addPathIndex(getIndexFromParent(el));
      el = el.parentNode;
    }
    
    el.XPath = xPath;
    
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