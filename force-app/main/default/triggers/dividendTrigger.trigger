trigger dividendTrigger on Account (after insert, after update) {
    List<Account> accountsWithContacts = [select Name, AccountNumber, 
    TotalOnAccount__c,(select AccountId, Share__c from Contacts)
    from Account where Id IN :Trigger.newMap.keySet()];
    update Dividend_Account.dividend(accountsWithContacts);
}