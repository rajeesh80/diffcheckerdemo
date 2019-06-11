public with sharing class ContactTriggerHandler {
  // This should be used in conjunction with the ApexTriggerComprehensive.trigger template
  // The origin of this pattern is http://www.embracingthecloud.com/2010/07/08/ASimpleTriggerTemplateForSalesforce.aspx
  private boolean m_isExecuting = false;
  private integer BatchSize = 0;

  public ContactTriggerHandler(boolean isExecuting, integer size){
    m_isExecuting = isExecuting;
    BatchSize = size;
  }

  public void OnBeforeInsert(Contact[] newContacts){
    /*
    //Example usage
    for(Contact newContact : newContacts){
      if(newContact.AnnualRevenue == null){
        newContact.AnnualRevenue.addError('Missing annual revenue');
      }
    }
    */
  }

  public void OnAfterInsert(Contact[] newContacts){

  }

  @future public static void OnAfterInsertAsync(Set<ID> newContactIDs){
    //Example usage
    //List<Contact> newContacts = [select Id, Name from Contact where Id IN :newContactIDs];
  }

  public void OnBeforeUpdate(Contact[] oldContacts, Contact[] updatedContacts, Map<ID, Contact> ContactMap){
    //Example Map usage
    //Map<ID, Contact> contacts = new Map<ID, Contact>( [select Id, FirstName, LastName, Email from Contact where ContactId IN :ContactMap.keySet()] );
  }

  public void OnAfterUpdate(Contact[] oldContacts, Contact[] updatedContacts, Map<ID, Contact> ContactMap){

  }

  @future public static void OnAfterUpdateAsync(Set<ID> updatedContactIDs){
    //List<Contact> updatedContacts = [select Id, Name from Contact where Id IN :updatedContactIDs];
  }

  public void OnBeforeDelete(Contact[] ContactsToDelete, Map<ID, Contact> ContactMap){

  }

  public void OnAfterDelete(Contact[] deletedContacts, Map<ID, Contact> ContactMap){

  }

  @future public static void OnAfterDeleteAsync(Set<ID> deletedContactIDs){

  }

  public void OnUndelete(Contact[] restoredContacts){

  }

  public boolean IsTriggerContext{
    get{ return m_isExecuting;}
  }

  public boolean IsVisualforcePageContext{
    get{ return !IsTriggerContext;}
  }

  public boolean IsWebServiceContext{
    get{ return !IsTriggerContext;}
  }

  public boolean IsExecuteAnonymousContext{
    get{ return !IsTriggerContext;}
  }
}