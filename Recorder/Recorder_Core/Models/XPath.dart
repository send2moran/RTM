library Models;

class XPath
{
  List<int> _sections;
  
  XPath()
  {
    _sections = new List<int>();
  }
  
  XPath.fromSections(List<int> sections)
  {
    _sections = sections;
  }
  
  void addPathIndex(int index)
  {
    _sections.add(index);
  }
  
  void run(void handler(int))
  {
    _sections.forEach(handler);
  }
  
  bool compareTo(XPath xPath)
  {
    if(_sections.length != xPath._sections.length)
      return false;
    
    for(int i=0;i<_sections.length; i++)
    {
      if(_sections[i] != xPath._sections[i])
      {
        return false;
      }
    }
    
    return true;
  }
  
  @override
  String toString()
  {
    return Strings.join(_sections.map((s) => s.toString()), '/');
  }
  
  static XPath fromString(String xPathString)
  {
    List<String> sectionsString = xPathString.split('/');
    List<int> sections = new List<int>();
    sectionsString.forEach((s) => sections.add(int.parse(s)));

    return new XPath.fromSections(sections);
  }
}
