@isTest
Private Class SingletonTest {
	
    Private Static testmethod void testConstruction(){
        //Following is not possible, as the constructor is not visible
        //Caught by Compiler, Good, No runtime testing required
        //Singleton s = new Singleton();
        Singleton s = Singleton.getInstance();
        System.Assert(s.getStr() == 'The Object is Initialized');
    }
    
    Private Static testmethod void testSingletonBehaviour(){
        Singleton s = Singleton.getInstance();
        s.setStr('This Object is Modified');
        Singleton s1 = Singleton.getInstance();
        System.Assert(s1.getStr() == 'This Object is Modified');
    }    
}