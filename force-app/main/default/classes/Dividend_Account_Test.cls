@isTest
private class Dividend_Account_Test {
    static testmethod void validateShareWhenTotalOnAccountIsPresent(){
        Account account = new Account(Name='Account1');
        insert account;

        List<Contact> contacts = setContact(account);
        insert contacts;

        account = [SELECT TotalOnAccount__c FROM Account WHERE Id =:account.Id];

        assertAccountTotalOnAccount(null, account.TotalOnAccount__c);
        assertContact(contacts, account, null);

        account.TotalOnAccount__c = 100.40;
        update account;

        account = [SELECT Name, TotalOnAccount__c FROM Account WHERE Id =:account.Id];
        assertAccountTotalOnAccount(100.40, account.TotalOnAccount__c);

        List<Contact> contactsDb = [SELECT AccountId, Share__c FROM Contact where AccountId=:account.Id];
        assertContact(contactsDb, account, 25.10);
    }

    static testmethod void validateShareWhenTotalOnAccountIsNegative(){
        Account account = new Account(Name='Account1');
        insert account;

        List<Contact> contacts = setContact(account);
        insert contacts;

        account = [SELECT TotalOnAccount__c FROM Account WHERE Id =:account.Id];

        assertAccountTotalOnAccount(null, account.TotalOnAccount__c);
        assertContact(contacts, account, null);

        account.TotalOnAccount__c = -1.00;
        update account;

        account = [SELECT Name, TotalOnAccount__c FROM Account WHERE Id =:account.Id];
        assertAccountTotalOnAccount(-1.00, account.TotalOnAccount__c);

        List<Contact> contactsDb = [SELECT AccountId, Share__c FROM Contact where AccountId=:account.Id];
        assertContact(contactsDb, account, -0.25);
    }


    static testmethod void validateShareWhenTotalOnAccountIsZero(){
        Account account = new Account(Name='Account1');
        insert account;

        List<Contact> contacts = setContact(account);
        insert contacts;

        account = [SELECT TotalOnAccount__c FROM Account WHERE Id =:account.Id];

        assertAccountTotalOnAccount(null, account.TotalOnAccount__c);
        assertContact(contacts, account, null);

        account.TotalOnAccount__c = 0.00;
        update account;

        account = [SELECT Name, TotalOnAccount__c FROM Account WHERE Id =:account.Id];
        assertAccountTotalOnAccount(0.00, account.TotalOnAccount__c);

        List<Contact> contactsDb = [SELECT AccountId, Share__c FROM Contact where AccountId=:account.Id];
        assertContact(contactsDb, account, 0.00);
    }

    static testmethod void validateShareWhenTotalOnAccountIsNull(){
        Account account = new Account(Name='Account1', TotalOnAccount__c=100.00);
        insert account;

        List<Contact> contacts = setContact(account);
        insert contacts;

        account = [SELECT TotalOnAccount__c FROM Account WHERE Id =:account.Id];

        assertAccountTotalOnAccount(100.00, account.TotalOnAccount__c);
        assertContact(contacts, account, null);

        account.TotalOnAccount__c = null;
        update account;

        account = [SELECT Name, TotalOnAccount__c FROM Account WHERE Id =:account.Id];
        assertAccountTotalOnAccount(null, account.TotalOnAccount__c);

        List<Contact> contactsDb = [SELECT AccountId, Share__c FROM Contact where AccountId=:account.Id];
        assertContact(contactsDb, account, null);
    }

    static List<Contact> setContact(Account account){
        Contact contact1 = new Contact(AccountId=account.Id,LastName='LastName1');
        Contact contact2 = new Contact(AccountId=account.Id,LastName='LastName2');
        Contact contact3 = new Contact(AccountId=account.Id,LastName='LastName3');
        Contact contact4 = new Contact(AccountId=account.Id,LastName='LastName4');

        List<Contact> contacts = new List<Contact>();
        contacts.add(contact1);
        contacts.add(contact2);
        contacts.add(contact3);
        contacts.add(contact4);
        return contacts;
    } 

    static void assertContact(List<Contact> contacts, Account account, decimal actualValue){
        for(Contact contact : contacts){
            System.assertEquals(account.Id, contact.AccountId);
            System.assertEquals(actualValue, contact.Share__c); 
        }
    }

    static void assertAccountTotalOnAccount(decimal actualValue, decimal expectedValue){
        System.assertEquals(actualValue, expectedValue);
    }
}