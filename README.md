# OMB-Max-Auth-for-Salesforce
A simple authenticator for Salesforce using OMB Max

## Contents
- [LICENSE.md](LICENSE.md) - open source license details for opening and contributing to GSA developed code
- [CONTRIBUTING.md](CONTRIBUTING.md) - "rules of the road" for contributing to GSA repos including this one
- [Code of Conduct](CODE_OF_CONDUCT.md) - behaviors that should be practiced with working at/with GSA
- [Assets](Assets) - Screenshots and Images
- [Src](Src) - Source Code Files  

## Introduction
MAX Authentication Services is part of the OMB MAX.gov portal which is comprised of a portfolio of products/services allowing for government-wide advanced collaboration, information sharing, data collection, publishing, and analytical capabilities.  In this scenario, MAX Authentication Services will be acting as an Identity Provider (Idp) for your Salesforce Community.

## Salesforce Configuration
### Steps to Configure Salesforce to use MAX.gov as an alternative Identity Provider
1. Create a Remote Site Setting for MAX.gov
    1. Setup->Administer->Security Controls->Remote Site Settings
![picture alt](https://github.com/GSA/OMB-Max-Auth-for-Salesforce/blob/master/Assets/Screenshot1.jpg)

        **Note:** For Production instance, set the Remote Site URL as https://login.max.gov

2. Enable SAML, (if not Enabled) and create a new SAML Single Sign-on Settings
    1. Setup->Administer->Security Controls->Single Sign-On Settings.<br>
    2.  Create Identity Provider Certificate to be used on SAML Single Sign-On Setting.
        1.  Open the Issuer URL: https://login.test.max.gov/idp/shibboleth and copy the data 
        between: <ds:X509Certificate>tags and create a text file: MAXCert.crt
    4.  Click on New button provide the required information, including the upload of the Identity Provider Certificate               MAXCert.crt created in iii.<br>
        **Note:** Verify that a Default Self-Signed Certificate for the field Request Signing Certificate is available.               Otherwise, create one.
    5.  After the MAX SAML Single-Sign-On entry is created, download the Metadata.
        1.  Make sure you have an account setup in Max.Gov. if not, Register.
        2.  Request access to the GSA FICAM SAML 2 Authentication collaboration area https://community.max.gov/x/bINyNQ by                 emailing Max Support at maxsupport@max.gov 
        3.  Upload the metadata into the Collaboration Area, identifying the target environment in the comment.
        4.  Take note of the Entity Id in the SAML Single Sign-On Settings 
        5.  Then email MaxSupport asking them to deploy the uploaded Metadata from the Collaboration Area into the target                 Environment.  And also, to update their “Circle of Trust” configuration/workaround to include the Entity Id above.             <br>
            **Note:**   For each Org Instance, there will be a unique Entity Id. Therefore,  Above needs to be setup for each                         ORG Instance.
        6.  If you plan to point your test environment to the Max Production, a different metadata needs to be created using               the  Max Production Identity Provider Certificate and Max Production Identity Provider URL.  You may reuse the                 same Max SAML Single Sign-on Settings or create a separate one, as long as the changed or new Max button is                   handled by controller that issues the SAML requests to MAX.gov.
        7.  It should be noted that Max configuration updates in Production, runs every 3 hours. Thus, once Max Support                   deploys the changes, it may take up to that time for the changes to take effect

3. Setup Community to use MAX.gov as a login option.
4. Login Flow Change.


## OMB MAX Configuration
### How to configure MAX.gov to work with Salesforce Community User  Account

1. Register at test.max.gov site. For Production instance, register at Max.gov.<br>
    **Note**: use your government email address that will be used in the Salesforce Community user account.
    1. Upon registration, login with your new credentials with Max Secure+SMS 2-Factor checkbox On and register your SMS              Device.
    2. After successfully SMS device registration, your MAX account is ready for Salesforce Login Integration.
    3. Alternatively, you can use your government issue PIV OR CAC Card by inserting it on your Laptop and providing the PIN.
    
2.  How to login to Salesforce.
    1. As part of the admin setup, a field “Federation Id” on your user account will be populated with the email address used         in the MAX.gov registration.  It is vital that during MAX.gov registration the same email address is used.
    2. Go to the Login URL and click on the  Login With Max button. You will be directed to the Max login page to sign-in.
    3. Provide your User Id and Password and click on the "LOGIN WITH USER ID AND SMS"  button.
    4. You will recieve SMS text with Login token.
    5. Enter the token and submit.
    6. After submitting the SMS Token and successful authentication, you will be directed back to salesforce.
    7. Alternatively, you can click on "LOGIN WITH PIV/CAC" button.  After being authenticated, you will be directed to the          Salesforce.


## Visualforce Page Configuration

The Login page is built using U.S. Web Design Standards framework and is completely modularized and 508 Compliant. To find more information on U.S Web Design Standards <a href="https://standards.usa.gov/" target="_blank">click here</a>. All the headers, help text, button labels can be configured by updating the respective custom label value. Below is the screenshot of the page. 
![picture alt](https://github.com/GSA/OMB-Max-Auth-for-Salesforce/blob/master/Assets/Login%20Page.Jpeg)

Follow the steps below to configure the Login Page and Controller.

1.  Update the the logo of the page by updating the Logo static resource. 
2.  The text for all the components of the Login section can be updated by updating the associated custom labels.
3.  The "SSO User Login" section can be displayed or hidden by updating the SSO_Login_Section_Control custom label with True or False. 
4.  The page has a sample script for DAP analytics. This needs to be configured based on your agency. Follow the steps listed in the page comments to configure the DAP script for your agency.<br>
    **Note:** The script has been commented out of the page and do not use the same script as its associated with General Services Administration specifically and is only for reference purpose.
5.  Update the Max Custom Settings.
    1.  Go to Set up->Quick find->Develop->Custom Settings->Max Custom Setting
    2.  Click on Manage->New
    3.  Enter the information for the following fields
        1. Name 
        2. CommunityURL - The URL of the community for which the Login page will be used. Make sure to use https protocol              and not http.
        3. Path Prefix  - Enter the path prefix of your community here. <br>
    Below is the example of the custom setting record.
    ![picture alt](https://github.com/GSA/OMB-Max-Auth-for-Salesforce/blob/master/Assets/Custom%20Setting%20Record.png)
    
## Public domain

This project is in the worldwide [public domain](LICENSE.md). As stated in [CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States, and copyright and related rights in the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0 dedication. By submitting a pull request, you are agreeing to comply with this waiver of copyright interest.


