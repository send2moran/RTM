library Models;

class XPath
{
  List<int> _sections;
  
  XPath()
  {
    _sections = new List<int>();
  }
  
  void addPathIndex(int index)
  {
    _sections.add(index);
  }
  
  void run(void handler(int))
  {
    _sections.forEach(handler);
  }
}
