@IsTest 
global with sharing class MaxSiteLoginControllerTest {
    @IsTest(SeeAllData=true) 
    global static void testMaxSiteLoginController () {
        // Instantiate a new controller with all parameters in the page
        MaxSiteLoginController controller = new MaxSiteLoginController ();
        controller.username = 'test@salesforcee.com';
        controller.password = '123456';  
        controller.loginMax();
        controller.setStrictTransportSecurity();           
        System.assertEquals(controller.login(),null);                              
    }    
}