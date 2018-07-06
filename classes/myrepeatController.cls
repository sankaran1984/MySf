public class myrepeatController {

    public Integer repeatCount{get;set;}
    public list<Integer> lsRepeatCount;

    public list<integer> getlsRepeatCount()
    {
        lsRepeatCount = new List<integer>();
        for(Integer i=0;i<repeatCount;i++) lsRepeatCount.add(i);
        return lsRepeatCount;
    }
}