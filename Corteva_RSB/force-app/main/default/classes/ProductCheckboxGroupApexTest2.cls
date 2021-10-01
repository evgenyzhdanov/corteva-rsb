@isTest
private class ProductCheckboxGroupApexTest2 {
    static testMethod void testgetProductList() {    
        Account accounts = new Account (Name = 'TestAccount', Type = 'Corteva');        
        insert accounts;        

        Product2 products = new Product2 (Name = 'TestProduct');        
        insert products;        

        Account_Product_Overview__c overviews= new Account_Product_Overview__c(Account__c = accounts.Id, Product__c = products.Id);
        insert overviews;
    }
    @isTest static void testGetProduct()
    {
        Account accounts = new Account (Name = 'TestAccount', Type = 'Corteva');        
        insert accounts;        

        Product2 products = new Product2 (Name = 'TestProduct');        
        insert products;        

        Account_Product_Overview__c overviews= new Account_Product_Overview__c(Account__c = accounts.Id, Product__c = products.Id);
        insert overviews;

        List<Account_Product_Overview__c> actualOverviews = new List<Account_Product_Overview__c>();
        actualOverviews = ProductCheckboxGroupApex.getProductList(accounts.Id);
        System.assertEquals(actualOverviews.size(), 1, 'Overview List Size Does Not Match - Actual Size is: '+actualOverviews .size());
    }
}