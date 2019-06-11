Public  WITH SHARING class AccountTest {
    @AuraEnabled
    Public Static List <Account>accList(){
        return [Select Id,Name,Industry FROM Account LIMIT 10];
    }
    
    

}