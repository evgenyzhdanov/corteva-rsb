@isTest
private class AccountCheckboxGroupApexTest {
    static testMethod void testAccountList() {
        List<Account> accounts = new List<Account>();
        for (Integer count = 0; count < 50; count++){
            accounts.add(new Account (Name = 'Test'+count, Type = 'Corteva'));
        }
        
        insert accounts;
    }
    @isTest static void testGetAccount()
    {
        
        List<Account> accounts = new List<Account>();
        for (Integer count = 0; count < 50; count++){
            accounts.add(new Account (Name = 'Test'+count, Type = 'Corteva'));
        }
        
        insert accounts;
        
        List<Account> actualAccounts = new List<Account>();
        actualAccounts = AccountCheckboxGroupApex.getAccountList('Corteva');
        System.assertEquals(actualAccounts.size(), 50, 'Account List Size Does Not Match - Actual Size is: '+actualAccounts.size());
    }
}