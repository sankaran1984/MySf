global class GithubAdapter extends Datasource.Connection {
    
    /* Connection */
    override global List<DataSource.Table> sync() {
        List<DataSource.Column> lsColumns = new List<DataSource.Column>();
        lsColumns.add(DataSource.Column.text('ExternalId', 255));
        lsColumns.add(DataSource.Column.url('DisplayUrl', 255));
        lsColumns.add(DataSource.Column.text('Name', 128));
        lsColumns.add(DataSource.Column.text('Description', 1024));
        lsColumns.add(DataSource.Column.number('Stars', 16, 0));
        
        List<DataSource.Table> lsTables = new List<DataSource.Table>();
        lsTables.add(DataSource.Table.get('Github Repos', 'Name', lsColumns));
        
        return lsTables;
    }
    
    override global DataSource.TableResult query(DataSource.QueryContext qc) {
        List<Map<String, Object>> lsResult = DataSource.QueryUtils.process(qc, getQueryResult('developerforce'));
        return DataSource.TableResult.get(qc, lsResult);
    }
    
    override global List<DataSource.TableResult> search(DataSource.SearchContext sc) {
        return DataSource.SearchUtils.searchByName(sc, this);
    }
    
    private List<Map<String, Object>> getQueryResult(String org) {
        List<Map<String, Object>> lsResult = new List<Map<String, Object>>();
        
        // Fire http request to load the result
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndPoint('https://api.github.com/orgs/' + org + '/repos?per_page=100');
        req.setMethod('GET');
        HttpResponse hRes = h.send(req);
        
        for (Object obj : (List<Object>)Json.deserializeUntyped(hRes.getBody())) {
			Map<String, Object> item = (Map<String, Object>) obj;
            Map<String, Object> mapObj = new Map<String, Object>();
            
            // External Id
			mapObj.put('ExternalId', item.get('id'));

            // Display URL
            mapObj.put('DisplayUrl', item.get('html_url'));
		            
            // Name
            mapObj.put('Name', item.get('name'));
             
            // Description
            mapObj.put('Description', item.get('descriptions'));
            
            // Stars
            mapObj.put('Stars', item.get('stargazers_count'));
            
            lsResult.add(mapObj);
        }
        return lsResult;
    }
}