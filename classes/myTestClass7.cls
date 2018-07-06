public virtual class myTestClass7 {

    class innerclass extends myTestClass7{
        
    }
    
    class onemoreinnerclass extends myTestClass7{
        
    }
    
    public void func(){
        List<myTestClass7> ls = new List<myTestClass7>();
        ls.add(new innerclass());
        ls.add(new myTestClass7());
        ls.add(new onemoreinnerclass());
        
        List<innerclass> lssub = new List<innerclass>();
        //lssub.add(new myTestClass7());
        
    }
        
}