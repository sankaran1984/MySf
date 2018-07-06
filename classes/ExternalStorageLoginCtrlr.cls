public class ExternalStorageLoginCtrlr {
    
    Public String accessToken{get;set;}
    Public String fileContent{get;set;}
        
    String clientId = 'evqk04xdpa4ove9ebqnbxrckzsc4x6bx';
    String clientSecret = 'sbL8VZFeyZTaFStOIS4wOB1BrMoSOPhU';
    String redirectURI = System.URL.getSalesforceBaseURL().toExternalForm() +
       ApexPages.currentPage().getURL(); 
    String authCode = ApexPages.currentPage().getParameters().get('code');
    String refreshToken;
    
    /* Contructor */
    Public ExternalStorageLoginCtrlr(){
        if(authCode!=Null) getAccessToken();
    }
    
    /* Action Methods */
    Public PageReference boxLogin(){
        String url = 'https://app.box.com/api/oauth2/authorize?response_type=code&client_id=' +
            clientId + '&redirect_uri=' + redirectURI + 
            '&state=security_token' + clientSecret;
        System.Debug(url);
        return new PageReference(url);
    }
    
    Public void boxUploadFile(){
        System.Debug('boxUploadFile-fileContent-'+fileContent);
        HttpResponse hRes = cURL.run('https://upload.box.com/api/2.0/files/content ' +
              '-H "Authorization: Bearer ACCESS_TOKEN" -X POST ' +
              '-F attributes=\'{"name":"tigers.jpeg", "parent":{"id":"11446498"}}\' ');
    }
    
    /* Private Methods */
    void getAccessToken(){
        HttpResponse hr = cURL.run('https://api.box.com/oauth2/token '+
				'-d \'grant_type=authorization_code&code='+ authCode +'&client_id='+ clientId +'&client_secret='+ clientSecret + '\' ' +
				'-X POST');
        System.Debug('getAccessToken - body-'+hr.getBody());
        Map<String, Object> respMap = (Map<String, Object>)JSON.deserializeUntyped(hr.getBody());
        accessToken = String.valueOf(respMap.get('access_token'));
        refreshToken = String.valueOf(respMap.get('refresh_token'));
    }
}