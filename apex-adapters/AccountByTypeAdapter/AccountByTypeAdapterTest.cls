@isTest public class AccountByTypeAdapterTest {
    static testMethod void test_AccountByTypeAdapterTest() {

        Account ac = new Account();
        ac.type = 'test';
        ac.name = 'Test Account';
        insert ac;

        Map<String, Object> params = new Map<String, Object>();
        params.put('accountType', 'test');
        AccountByTypeAdapter abt = new AccountByTypeAdapter();
        List<Object> records = abt.getSearchResults(null, params);
        System.assertEquals(1, records.size());
    }
    
    static testMethod void test_NullAccountType() {
        Account ac = new Account();
        ac.type = '';
        ac.name = 'Test Account';
        insert ac;

        Map<String, Object> params = new Map<String, Object>();
        params.put('accountType', null);
        AccountByTypeAdapter abt = new AccountByTypeAdapter();
        List<Object> records = abt.getSearchResults(null, params);
        System.assertEquals(1, records.size());

    }
}