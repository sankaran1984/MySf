global class MongoDbConnection extends Datasource.Connection {
    /* Connection */
    override global List<DataSource.Table> sync() {
        List<DataSource.Column> lsColumns = new List<DataSource.Column>();
        lsColumns.add(DataSource.Column.text('ExternalId', 255));
        lsColumns.add(DataSource.Column.url('DisplayUrl', 255));
        lsColumns.add(DataSource.Column.text('Name', 128));
        lsColumns.add(DataSource.Column.text('Description', 1024));
        lsColumns.add(DataSource.Column.number('Amount', 16, 0));
        
        List<DataSource.Table> lsTables = new List<DataSource.Table>();
        lsTables.add(DataSource.Table.get('MongoDB Repos', 'Name', lsColumns));
        
        return lsTables;
    }
    
    override global DataSource.TableResult query(DataSource.QueryContext qc) {
        List<Map<String, Object>> lsResult = DataSource.QueryUtils.process(qc, getQueryResult('lighthningconnect'));
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
        req.setEndPoint('https://api.mlab.com/api/1/databases/' + org + 
			'/collections/invoices?apiKey=JCjOUuDj3lIjhuIg7lC7IZ-LCM8Uzct_');
        req.setMethod('GET');
        HttpResponse hRes = h.send(req);
        System.debug('hRes.getBody() - ' + hRes.getBody());
        
        for (Object obj : (List<Object>)Json.deserializeUntyped(hRes.getBody())) {
			Map<String, Object> item = (Map<String, Object>) obj;
            Map<String, Object> mapObj = new Map<String, Object>();
            
            Map<String, Object> recIdMap = (Map<String, Object>) item.get('_id');
            
            // External Id
			mapObj.put('ExternalId', recIdMap.get('$oid'));

            // Display URL
            mapObj.put('DisplayUrl', recIdMap.get('$oid'));
		            
            // Name
            mapObj.put('Name', item.get('description'));
             
            // Description
            mapObj.put('Description', item.get('descriptions'));
            
            // Stars
            mapObj.put('Amount', item.get('amount'));
            
            // Account
            mapObj.put('Account', item.get('accountid'));
            
            lsResult.add(mapObj);
        }
        return lsResult;
    }
}