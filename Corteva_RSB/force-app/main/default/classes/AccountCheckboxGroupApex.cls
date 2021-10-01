public class AccountCheckboxGroupApex {
  @AuraEnabled
    Public static List<Account> getAccountList(String accountType){
        //all Accounts of specified type
        List<Account> acctList = [SELECT Id, Name
                                 FROM Account 
                                 WHERE   Type =: accountType
                                 ORDER BY Name];
        return acctList;
    }
}