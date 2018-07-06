public class testcls4_06122016 {

    public Integer userRetries{get;set;}
    
    public testcls4_06122016() {
        userRetries = 0;
    }
    
    /* Action Methods */
    public void timerFired() {
        userRetries++;
    }
}