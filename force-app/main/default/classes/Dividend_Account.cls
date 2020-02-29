public class  Dividend_Account{
    public static List<Contact> dividend(Account[] accounts){
        List<Contact> contacts = new List<Contact>();
        for(Account account : accounts){
            if(account.TotalOnAccount__c!= null
            && account.Contacts!=null && account.Contacts.size()>0){
                decimal sharePerContact = (decimal)(account.TotalOnAccount__c/account.Contacts.size());
                for(Contact contact : account.Contacts){
                    contact.Share__c = sharePerContact;
                    contacts.add(contact);
                }
            }
        }
        return contacts;
    }
}