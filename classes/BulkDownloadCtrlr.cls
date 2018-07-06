public class BulkDownloadCtrlr{

    String sobjName;

    public List<String> fieldNames{get;set;}
    public Map<String, String> fieldNamesMap{get;set;}
    Public String newLine{get{
        return '\n';
    }set;}

    public BulkDownloadCtrlr(ApexPages.StandardSetController controller){
        sobjName = String.valueOf(controller.getRecord().getSobjectType());
        init();
        if(fieldNamesMap!=Null) controller.addFields(fieldNamesMap.values());
    }
    
    void init(){
        fieldNames = new List<String>();
        fieldNamesMap = new Map<String, String>();
        if(ApexPages.CurrentPage().getParameters().get('Format') == Null){
            populateFieldNames();
            populateFieldDevNames();
        }
    }
    
    void populateFieldNames(){
        String headerRow = new PageReference(ApexPages.currentPage().getURL().split('\\?')[0]+'?Format=html').getContent().toString().subStringBetween('<tr class="headerRow">', '</tr>'); 
        RowIterator r = new RowIterator(headerRow, '</th>');
        while(r.hasNext())
            fieldNames.add(r.next().stripHtmlTags());
        fieldNames.remove(0);
        System.Debug('populateFieldNames - fieldNames-'+fieldNames);
    }
    
    void populateFieldDevNames(){
        Map<String, Schema.SObjectField> mFieldRes =  Schema.DescribesObjects(
            new List<string>{sobjName})[0].fields.getMap();
        for(String fieldId:mFieldRes.keySet())
            fieldNamesMap.put(mFieldRes.get(fieldId).getDescribe().getLabel(), fieldId);
        System.Debug('populateFieldDevNames - fieldNamesMap-'+fieldNamesMap);
    }
    
    public class RowIterator implements Iterator<String>, Iterable<String>
    {
       private String m_Data;
       private Integer m_index = 0;
       private String m_rowDelimiter = '\n';
        
       public RowIterator(String fileData)
       {
          m_Data = fileData; 
       }
       public RowIterator(String fileData, String rowDelimiter)
       {
          m_Data = fileData; 
          m_rowDelimiter = rowDelimiter;
       }
        
       public Boolean hasNext()
       {
          return m_index < m_Data.length() ? true : false;
       }
       public String next()
       {     
          Integer key = m_Data.indexOf(m_rowDelimiter, m_index);
           
          if (key == -1)
            key = m_Data.length();
                 
          String row = m_Data.subString(m_index, key + m_rowDelimiter.length());
          m_index = key + m_rowDelimiter.length();
          return row;
       }
       public Iterator<String> Iterator()
       {
          return this;   
       }
    }
}