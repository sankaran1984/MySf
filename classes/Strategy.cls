public class Strategy {
    
    Public Class StrategyException extends System.Exception{}

    Public Interface ServiceInterface{
        String getTemperature(); 
    }
    
    Public Class GoogleService Implements ServiceInterface{
        Public String getTemperature(){
            return 'Google Service Down';
        }
    }

    Public Class YahooService Implements ServiceInterface{
        Public String getTemperature(){
            return 'Yahoo Service Down';
        }
    }

    /* This decides which service to use - This is called Strategy Pattern */
    Public Class ServiceConsumer{
        Public String getTemperature(String serviceName){
            Type serviceType = Type.forName('Strategy.'+serviceName+'Service');
            if(serviceType == Null) 
                throw new StrategyException('Invalid_Service_Name');
            
            ServiceInterface si = (ServiceInterface)serviceType.newInstance();
            return si.getTemperature();
        }
    }    
    
    Public Static String getCurrentTemperature(String serviceName){
        if(String.isBlank(serviceName)) return Null;
        
        ServiceConsumer s = new ServiceConsumer();
        return s.getTemperature(serviceName);
    }
}