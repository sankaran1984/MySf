@isTest
public with sharing class TestDataUtils {

	public static User createUser(String profileName, String userNamePrefix) {
        if(String.isBlank(userNamePrefix) || String.isBlank(profileName))
            throw new AssertException('Incorrect paramters to createUser');
        
        List<Profile> lsProf = [Select Id From Profile Where Name=:profileName];
        if(lsProf.isEmpty()) throw new AssertException('Profile Id doestn\'t exist');
        
        String orgId = UserInfo.getOrganizationId();
        String uniqueName = userNamePrefix + '_' + orgId + '_' + System.now().getTime();
        
        User testUser = new User();
        testUser.Username = uniqueName+'@test.com';
        testUser.Email = uniqueName+'@test.com';
        testUser.Lastname = 'test';
        testUser.Firstname = 'test';
        testUser.Alias = 'test';
        testUser.CommunityNickname = 'test' + System.now().getTime();
        testUser.ProfileId = lsProf.get(0).Id;
        
        testUser.TimeZoneSidKey = 'GMT';
        testUser.LocaleSidKey = 'en_US';
        testUser.EmailEncodingKey = 'ISO-8859-1';
        testUser.LanguageLocaleKey = 'en_US';
        testUser.UserPermissionsMobileUser = false;
        testUser.isActive = True;

        insert testUser;
        
        return testUser;        
    }
}