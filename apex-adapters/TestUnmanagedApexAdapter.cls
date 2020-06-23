global with sharing class AccountByTypeApexAdapter
	implements PDLM.PropelSearchAdapterV2 {

    /**
        Example Search Record Configuration
        Apex Adapter: AccountByTypeApexAdapter
        Search Parameters: 
          {
            "accountType": {
              "dataType": "string",
              "key": "accountType",
              "defaultValue":"",
              "label": "Account Type",
              "required": true
            }
          }
     */

    // initialize variables
    Integer totalRecordCount = 0; 
    Map<string, Object> params = new Map<String, object>();
    Map<string, Object> options = new Map<String, object>();
    
    /**
     * Define columns to display in the Propel Search component
     */
    public List<PDLM.SearchResultColumn> getColumns() {
        PDLM.SearchResultColumn[] columns = new PDLM.SearchResultColumn[]{};
        /**
         * These are the columns that display in the UI. 
         * If you want to show a column in the UI, make sure to query for it in getSearchResults()
         * Format is: SearchResultColumn(API Name, Column Label, Data Type)
         */ 
        columns.add(new PDLM.SearchResultColumn('Name', 'Name', 'TEXT')); // add the name field
        columns.add(new PDLM.SearchResultColumn('Id', 'Id', 'ID')); // add the ID field
        columns.add(new PDLM.SearchResultColumn('Type', 'Type', 'TEXT')); // add the type field
        return columns;
    } 

    /**
     * Set a default return object.
     * If you don't want to specific a default, return null.
     */
	  public string getDefaultObject() { 
        return 'Account';
    }
        
    public Integer getTotalRecordCount() {
        return this.totalRecordCount;
    }

    /** 
     * Pushes params to Maps for use in search adapter logic.
     *
     * @param searchOptions Map of searchOptions passed from Propel Search component
     * @param searchParams Map of searchOptions passed from Search record
     * @return List of objects to return for Propel Search component to display.
     */
    private void getParams(Map<String, Object> searchOptions, Map<string, Object> searchParams) {
        if (searchOptions != null) {
            this.options.putAll(searchOptions);
        }
        if (searchParams != null) {
            this.params.putAll(searchParams);
        }
    }

    /** 
     * Core method for orchestrating queries to return data to the Propel Search component.
     *
     * @param searchOptions Search options that are passed from the Propel Search component.
     * @param searchParams  Search parameters defined on the Search record.
     * @return List of objects for Propel Search component to display.
     */
    public List<Object> getSearchResults(Map<string, Object> searchOptions, Map<string, Object> searchParams) {

        this.getParams(searchOptions, searchParams); // set params
        String accountType = (String)this.params.get('accountType'); // query 
        
        List<SObject> allDocuments = Database.query('select id, name, type from Account where type = :accountType');
        
        this.totalRecordCount = allDocuments.size(); // to leverage pagination, you must indicate the total results from the query
        return (List<Object>)allDocuments;
    }
        
    /** 
      The following methods are no longer used but must be present as they were defined in an earlier interface.
    */
    public List<SObject> getAllRecords(Map<String, Object> searchOptions, Map<string, Object> searchParams) {
       return null;
    }
	
    public List<SObject> getRecords(Map<String, Object> searchOptions, Map<string, Object> searchParams) {
        return null;
    }
}