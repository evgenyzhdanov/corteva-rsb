public class ProductCheckboxGroupApex {
	@AuraEnabled
    Public static List<Account_Product_Overview__c> getProductList(String relatedAccountId){
        //all related Regulatory Product list from Account Product Overview
        List<Account_Product_Overview__c> prodList = [SELECT Id, Product__c, fProduct_Name__c, fEPA_Number__c, Renewal_Date__c, Discontinuance__c
                                 FROM Account_Product_Overview__c 
                                 WHERE Account__c =: relatedAccountId
                                 AND Is_Registered__c = true
                                 ORDER BY fProduct_Name__c];
        return prodList;
    }
}