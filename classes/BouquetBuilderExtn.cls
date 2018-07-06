public with sharing class BouquetBuilderExtn {

    /** Constants **/
    
    // Default page size is derived from 'Custom Metadata' for 'Bouquet Builder'
    // If not configured or empty, this constant value is used.
    private final Integer DEFAULT_PAGE_SIZE = 5;
    
    /** VF Bindings **/
    
    // Represents Bouquet Record being displayed
    public Bouquet__c bqtRecord { get; set; }                        
    
    // Represents complete collection of all products displayed in UI in which each product maps to bloom record.
    // So that, Quantity value updated for each bloom by user is persistant across actions.
    public Map<Id, Bloom__c> mapProdToBloom { get; private set; }
    
    // Represents Set of products displayed in UI at any given point of time.      
    public Set<Product2> setDispProdIds { get; private set; }
    
    // Represents the Flower family selected in UI
    public String selectedFamily { get; set; }
    
    // Represents the pie data for UI
    public ChartData pieData { get; private set; }
    
    // Represents Product set Controller
    public ApexPages.StandardSetController prodSetCtrlr { get; set; }
    
    public List<SelectOption> getFlowerFamilies() {
        List<SelectOption> lsSelOpts = new List<SelectOption>();
        lsSelOpts.add(new SelectOption('', '--Any Type--'));
        
        for (Schema.PickListEntry pe : Product2.Family.getDescribe().getPickListValues()) {
            lsSelOpts.add(new SelectOption(pe.getValue(), pe.getValue()));    
        }
        System.debug('getFlowerFamilies - lsSelOpts-'+lsSelOpts);
        
        return lsSelOpts;
    } 
    
    Public Integer getLastPageNumber() {
        Decimal decVal = (prodSetCtrlr.getResultSize() * 100) / prodSetCtrlr.getPageSize();
        decVal.setScale(2);
        return Integer.valueOf(Math.ceil(decVal / 100));
    }   
    
    /** Private Variables **/
    
    private Set<Id> setExistingProdIds;

    /*
     * Constructor for the extension
     * @param - standard controller invoked from Page
     * @return - none
     */
    public BouquetBuilderExtn(ApexPages.StandardController sc) {
        bqtRecord = (Bouquet__c) sc.getRecord();
        mapProdToBloom = new Map<Id, Bloom__c>();        
        setExistingProdIds = new Set<Id>();
        pieData = new ChartData();
        
        loadExistingBlooms();
        loadProducts();
        genChartData();
    }
    
    private void loadExistingBlooms() {
        if (String.isBlank(bqtRecord.Id))
            return;
        
        for (Bloom__c bloomRec : 
                          [ Select 
                                Id, Flower__c, Quantity__c
                            From
                                Bloom__c
                            Where
                                Bouquet__c =: bqtRecord.Id ]
        ) {
            if (String.isBlank(bloomRec.Flower__c))
                continue;
            
            setExistingProdIds.add(bloomRec.Flower__c);    
            mapProdToBloom.put(bloomRec.Flower__c, bloomRec);                 
        }
        
        System.debug('loadExistingBlooms - mapProdToBloom-'+mapProdToBloom);
    }
    
    private void loadProducts() {
        prodSetCtrlr = new ApexPages.StandardSetController(
            Database.getQueryLocator(
                'Select ' +
                    'Id, Name, Color__c, Family, Cost__c, Inventory_Remaining__c, HTML_Color_Code__c, IsActive ' +
                'From ' +
                    'Product2 ' +
                'Where ' +
                    '( ' +
                        '(Inventory_Remaining__c > 0 AND IsActive = True)' +
                        'OR ' +
                        'Id IN :setExistingProdIds ' +
                    ') ' +
                    (String.isBlank(selectedFamily) ? '' : 'AND Family :=selectedFamily ') +
                'Order By Cost__c, Color__c ' +
                'LIMIT 10000'    
            )
        );
        prodSetCtrlr.setPageSize(getPageSizeDefault());
        
        loadBloomsForProducts(prodSetCtrlr.getRecords());
        
    }
    
    private Integer getPageSizeDefault() {
        List<BouquetBuilder__mdt> lsBqtMdt = [Select 
                                                Id, Page_Size__c 
                                              From 
                                                BouquetBuilder__mdt
                                              Where
                                                DeveloperName = 'Bouquet_Builder_Defaults'];
        if (!lsBqtMdt.isEmpty() && lsBqtMdt[0].Page_Size__c!=Null)
            return Integer.valueOf(lsBqtMdt[0].Page_Size__c);
        else
            return 5;                                        
    }
        
    private void loadBloomsForProducts(List<Product2> lsProds) {
        if (lsProds==Null || lsProds.isEmpty())
            return;
            
        for (Product2 prod : lsProds) {
            Bloom__c bloomRec = mapProdToBloom.get(prod.Id)!=Null 
                ? mapProdToBloom.get(prod.Id)
                : new Bloom__c(Quantity__c=0);
                
            bloomRec.Flower__r = prod;
            
            mapProdToBloom.put(prod.Id, bloomRec);
        }
        System.debug('loadBloomsForProducts - mapProdToBloom-'+mapProdToBloom);
    }
    
    private void genChartData() {
        if (mapProdToBloom==Null || mapProdToBloom.isEmpty())
            return;
        
        Decimal totQty = 0.0;
        Decimal totCost = 0.0;
        Map<String, Integer> mapColorToQty = new Map<String, Integer>();    
        for (Id prodId : mapProdToBloom.keySet()) {
            Bloom__c bloomRec = mapProdToBloom.get(prodId);
            if (bloomRec==Null || bloomRec.Quantity__c==Null || bloomRec.Quantity__c==0 || bloomRec.Flower__r==Null
                    || String.isBlank(bloomRec.Flower__r.Color__c))
                continue;
                
            totQty += bloomRec.Quantity__c;
            totCost += (bloomRec.Flower__r.Cost__c==Null ? 0.0 : bloomRec.Flower__r.Cost__c);
            
            mapColorToQty.put(bloomRec.Flower__r.Color__c, Integer.valueOf(bloomRec.Quantity__c +
                (mapColorToQty.get(bloomRec.Flower__r.Color__c)==Null ? 0.0 : mapColorToQty.get(bloomRec.Flower__r.Color__c))));
        }
        
        //Now populate the data into PieData
        pieData.totalCost = totCost;
        pieData.lsPieWdgs.clear();
        for (String color : mapColorToQty.keySet()) {
            pieData.lsPieWdgs.add(new PieWedge(color, (mapColorToQty.get(color) * 100 ) / totQty));
        }
        
        System.debug('genChartData - pieData-'+pieData);
    }
    
    /** Action Methods **/
    public void onFilterChange() {
        loadProducts();
        genChartData();
    }
    
    public PageReference onSave() {
        return Null;
    }
        
    class ChartData {
        public String currencySymbol { get; private set; }
        public Decimal totalCost {get; private set; }
        public List<PieWedge> lsPieWdgs { get; private set; }
        
        public ChartData() {
            this.currencySymbol = getDefaultCurrency();
            this.totalCost = 0.0;
            this.lsPieWdgs = new List<PieWedge>();
        }
        
        private String getDefaultCurrency() {
            List<BouquetBuilder__mdt> lsBqtMdt = [Select 
                                                    Id, Currency_Symbol__c
                                                  From 
                                                    BouquetBuilder__mdt
                                                  Where
                                                    DeveloperName = 'Bouquet_Builder_Defaults'];
            if (!lsBqtMdt.isEmpty() && lsBqtMdt[0].Currency_Symbol__c!=Null)
                return lsBqtMdt[0].Currency_Symbol__c;
            else
                return '$';                                        
        } 
    }
    
    class PieWedge {
        public String label;
        public Decimal percent;
        
        public PieWedge(String label, Decimal percent) {
            this.label = label;
            this.percent = percent;
        }
    }
}