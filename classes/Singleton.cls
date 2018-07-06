Public Class Singleton {
    
    Private Static Singleton s;
    Private String str;
    
    Public String getStr(){
        return this.Str;
    }
    
    Public Void setStr(String st){
        this.Str = st;
    }
    
    Private Singleton(){
        str = 'The Object is Initialized';
    }
    
    /* This interface gives the same object everytime you call - This is called Singleton Pattern */
    Public Static Singleton getInstance(){
        If(s==Null) s = new Singleton();
        return s;
    }
}