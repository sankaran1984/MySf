@isTest
public class testClassCreateUser {

    static testmethod void createTestUser(){
        List<User> lsUsers = new List<User>();
        Id profileId = [Select Id From Profile Where Name='System Administrator'][0].Id;
        Id userRoleId = [Select Id From UserRole Where Name='CEO'][0].id;
        for(Integer i=0; i<100; i++){

            User testUser = new User();
            testUser.Username= 'nepzsolutions'+i+'@company.com';
            testUser.Email = testUser.Username;
            testUser.Lastname = 'user';
            testUser.Firstname = 'test';
            testUser.Alias = 'test';
            testUser.CommunityNickname = 'nepzsolutions'+i;
            testUser.UserRoleId = userRoleId;
            testUser.ProfileId = profileId;
            
            testUser.TimeZoneSidKey = 'GMT';
            testUser.LocaleSidKey = 'en_US';
            testUser.EmailEncodingKey = 'ISO-8859-1';
            testUser.LanguageLocaleKey = 'en_US';
            testUser.UserPermissionsMobileUser = false;
            lsUsers.add(testUser);
        }
        insert lsUsers;
        System.Assert([Select Id From User].Size()>100);
    }
}