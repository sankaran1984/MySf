@isTest
public class testableTest {

    public static testmethod void test1(){
        System.runAs([Select Id From User Where Name='John Sunder' Limit 1][0]){
            testable t = new testable();
        }
    }
}