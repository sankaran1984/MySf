public class cURL {
    
    /* Public Method - Interface */
    Public static HttpResponse run(String options){
        cURL c = new cURL(options);
        return c.run();
    }
        
    /* Public Exception - Interface */
    Public Class cURLException extends Exception{}

    /* Private - Data Structure */
    Class Request{
        Public String serverBaseURL;
        Public RequestType reqType;
        Public Map<String, String> headers = new Map<String, String>();
        Public String payload;
    }
    
    Enum RequestType{GET, POST}
    
    /* Private Data Memebers */
    Request req;
    
    /* Constructor */
    cURL(String options){
		parse(options);
    }
    
    /* Private Methods */
    void parse(String options){
        if(options==Null || String.isEmpty(options)) throw new cURLException('cURL parameters missing.');
		
        System.Debug('cURL-parse-options-'+options);
        req = new Request();
        try{
            List<String> params = options.normalizeSpace().split(' ');
            req.serverBaseURL = params[0];
            req.payload = '';
            for(Integer paramCount=1; paramCount<params.size(); paramCount++){
            	if(params[paramCount]=='-d') //Body Data
                    req.payload = params[paramCount+1].removeStart('\'').removeEnd('\'');
                else if(params[paramCount]=='-X') //Request Type
                    req.reqType = params[paramCount+1]=='GET'? RequestType.GET:
                		RequestType.POST;
                else if(params[paramCount]=='-H'){ //Header 
                    String p = params[paramCount+1].removeStart('"').removeEnd('"');
                    req.headers.put(p.split(':')[0].trim(), p.split(':')[1].trim());
                }
                else if(params[paramCount]=='-F'){ //Form Data
                    String boundary = '';
                    //req.payload += 
                }
            }
        }catch(Exception e){
            throw new cURLException('cURL parameter parsing issue. -'+e.getMessage());
        }
        
        System.Debug('cURL-parse-req-'+req);
    }
    
    HttpResponse run(){
        if(req==Null) throw new cURLException('cURL request parameters missing.');
        
        HttpResponse hResp;
        Http h = new Http();
        HttpRequest hReq = new HttpRequest();
        try{
            hReq.setEndpoint(req.serverBaseURL);
            hReq.setMethod(req.reqType==RequestType.GET? 'GET': 'POST');
            for(String header:req.headers.keySet()) 
                hReq.setHeader(header, req.headers.get(header));
            hReq.setBody(req.payload);
            hResp = h.send(hReq); 
        }catch(Exception e){
            throw new cURLException('cURL - REST call error. - '+e.getMessage());    
        }
        System.Debug('cURL-run-Response-'+hResp);
        return hResp;
    }
}