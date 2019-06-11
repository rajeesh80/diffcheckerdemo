@isTest
public class Test_userHelper {
    public static testmethod void insertUser(){
        Profile prof= [select id from Profile where name = 'Standard User' limit 1];
        User u = new User();
        u.FirstName = 'Test';
        u.LastName = 'testing';
        u.Alias	   = 'testals';
        u.Username = 'testxyzg@test.com';
        u.Email    = 'testing123@test.com';
        u.ProfileId = prof.id;
        u.TimeZoneSidKey='America/Denver';
        u.EmailEncodingKey='UTF-8';
        u.LanguageLocaleKey='en_US';
        u.LocaleSidKey='en_US';
        insert u;
        User u1 = [select lastname from User where id=:u.Id];
        System.assertEquals('testing', u1.LastName);
    }
}