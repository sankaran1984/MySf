public class ActionsForSkuid {
    
    @invocablemethod(label='Skuid Exposed API')
    public static List<String> invokeApexAction(List<String> request){
		System.debug(request[0]);   // value1
		System.debug(request[1]);   // value2
		
		return new List<String> {
			'returnValue1',
			'returnValue2'
		};
    }
    
}