public class VFUtils {
	Public Static Void raisePageMsg(ApexPages.Severity severityLevel,
									String message){
		ApexPages.addMessage(new ApexPages.Message(severityLevel, message));
	}
	
	Public Static Void raisePageMsg(String message){
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, message));
	}	
    
    Public Static String getHyperLink(String target, String label){
        return '<a href="'+target+'" target="_blank">'+label+'</a>';
    }
}