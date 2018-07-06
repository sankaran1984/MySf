@RestResource(URLMapping='/proxy/*')
global class MyTestRestAPI {

    @HttpGet
    global static void proxyCall() {
        RestRequest restReq = RestContext.request;
		System.debug(restReq.requestURI);        
                
        String apiURL = restReq.requestURI.subString(6);
        System.debug(apiURL);
        
        HttpRequest req = new HttpRequest();

        req.setMethod('GET');
        req.setEndpoint('https://api.stackct.com' + apiURL);
        req.setHeader('Authorization', 'Bearer -5JC9eNxw_1BJvp_MViD-HpO1H-H9L-oxj91jPRWDfetOlheGko9zhM5MKBYoqptHgvizcBLEEoJIdzxL0nDL3ZGmbIUPt9Q57eCysH1WkXa8L4kq9vqwx2sVjaUBfaLydX_9rk6sSi_u5Sa01d4kR0iA1oAcy29GeMVp1ZYR0TiSlSuzocllTBxxuTc1LR9pAcQnepsT1ynnwHMg2b7rDYnahhd9XO8I3-pZ_PG44KwJ4Ac25XRtx5gCYmJT1kcDlG8ZzfkRPawlboIxexc6ac41KX9gVnh1Jd0Fe01DmFXjhMrD-C01TmnI7DTLWPPwKZrNbsUS4PiAAA_6Zi7R_t8X18RtvqmnF2mFPD5zNRBINfMSe480UyQp8D6TbTJu0lS7qCLv7_wSuCqFwZosAb46QsdkfQxaseB4ieALABOME4C80Q6I07U-vpPq5qsAUw1sCgKrmAZ9IfmR28lgNaUj9naGm6OjX4LCa--AyxAXXlnbyhmvh8Lw_FrsyWv8XoV-3q5dTumAQ9U4Kx3BmDievpUVbXMIe103kndr3OMsnwopnRXaTffl1yJ7O5CUtG7bueed91I-CVf8YTjJ9qly90YIud4eTc-6ygVp6-RfhHiGQTN7Vw_qk84nkna8KEWymhGbPMkP7EMbJ9vOg');
        
        HttpResponse resp = new Http().send(req);
        
        System.debug(resp.getStatusCode());
        System.debug(resp.getBody());
        
        RestResponse restResp = RestContext.response;
        restResp.addHeader('Content-Type', 'application/vnd.collection+json');
        restResp.responseBody = Blob.valueOf(resp.getBody());
    }
}