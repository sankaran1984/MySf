public class StringArrayTest {
    public static list<string> generateStringArray(Integer count){
        list<string> lsStrs = new list<string>();
        if(count>0) for(Integer c=0;c<count;c++) lsStrs.add('Test '+String.ValueOf(c));
        return lsStrs;
    }
}