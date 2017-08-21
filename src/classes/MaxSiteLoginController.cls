/*******************************************************************************
*
* Description: Controller class to implement Max login. 
*
*
* Modification Log:
* -----------------------------------------------------------------------------------------
* Mod ID        |   Date        | Mod Author                | Brief Model Description
* -----------------------------------------------------------------------------------------
* 0001          |   2017/06/29  | ramesh.dugar@gsa.gov      | Initial code creation.
* -----------------------------------------------------------------------------------------
*
********************************************************************************/
/**
 * An apex page controller that exposes the site login functionality
 * The loginMax() method implements the Max Login functionality. 
 * Create a Custom setting record under Max_Custom_Setting__c with your site details. 
 *Example provided in Git Read me.
 */
global with sharing class MaxSiteLoginController {
    global String username { get; set; }
    global String password { get; set; }

    global MaxSiteLoginController() {
    }
  
    // Method will get the SSO Url to use when logging in using Max
    public PageReference loginMax() {
    
        Max_Custom_Setting__c customSetting;
        String startUrl = System.currentPageReference().getParameters().get('startURL');
        String communityUrl = URL.getSalesforceBaseUrl().toExternalForm();  
        
        String networkID=Network.getNetworkId();
        if ( networkID!=null ) { Network community = [Select urlPathPrefix, Name, Id From Network Where Id=:networkID];                       
            customSetting = Max_Custom_Setting__c.getInstance(community.name); communityURL = customSetting.communityUrl__c; startURL = customSetting.pathPrefix__c; 
        }      
 
        // create a AuthConfiguration object
        Auth.AuthConfiguration authConfig = new Auth.AuthConfiguration(communityUrl,startUrl);
        
        // get the id of the SAML SSO Configuration
        String samlId = ''; 
        List<SamlSsoConfig> samlList = authConfig.getSamlProviders();
        if ( samlList.size()>0 ) { for ( SamlSsoConfig sso : samlList ) { if ( sso.developername.containsIgnoreCase('Max') ) { samlId=sso.Id; } } }

        String ssoURL = Auth.AuthConfiguration.getSamlSsoUrl(communityUrl, startUrl, samlId);        
        if (ssoURL!=null ) { ssoURL = ssoURL.Replace('saml_binding_type=HttpPost','saml_binding_type=HttpRedirect'); 
           PageReference pageMax = new PageReference(ssoURL); return pageMax.setRedirect(true);  
        } else return null;
    
    }

    global PageReference login() {
  
        String startURL = System.currentPageReference().getParameters().get('startURL');       
        return Site.login(username, password, startUrl);
    }

    global void setStrictTransportSecurity() {
        System.currentPageReference().getHeaders().put('Strict-Transport-Security',
       'max-age=3153600; includeSubDomains');
    }
}