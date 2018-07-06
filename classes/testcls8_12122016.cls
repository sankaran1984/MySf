public class testcls8_12122016 {
    
    public MyDateContainer mdc {get; set;}
    
    public testcls8_12122016() {
        mdc = new MyDateContainer(System.Today());
    }
    
    public void addDay() {
        mdc.myDate += 1;
    }

}