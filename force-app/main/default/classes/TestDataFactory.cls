/*
*********************************************************
Apex Class Name    : TestDataFactory
Created Date       : July 2024
@description       : This test data factory can be used to simplify testing logic
@author            : Steven Trumble
*********************************************************
*/
@isTest
public class TestDataFactory {

    //constant of Filing Statuses so can use to generate random choice 
    private static final List<String> FILING_STATUSES = new List<String>{
        'Single',
        'Married Filing Jointly',
        'Married Filing Separately',
        'Head of Household'
    };

/*
*********************************************************
@Method Name    : createJobApplicationsWithStatus
@author         : Steven Trumble
@description    : method to is used to create Job Application(s) with a specific Status__c
@param          : Integer - numJobApplications - number of job applications that need tasks created
                    String - status - the Job_Application__c.Status__c 
@return         : List of inserted Job Applications
********************************************************
*/    
    public static List<Job_Application__c> createJobApplicationsWithStatus(Integer numJobApplications, String status) {
        List<Job_Application__c> jobApplications = new List<Job_Application__c>();
        for (Integer i = 0; i < numJobApplications; i++){
            Job_Application__c jobApplication = new Job_Application__c(Status__c = status);
            jobApplications.add(jobApplication);
        }
        insert jobApplications;
        return jobApplications;
    }

/*
*********************************************************
@Method Names    : getAccount
@author         : Steven Trumble
@description    : methods used to create single account
@param String name: name of account
@param Boolean doInsert : whether to insert the account or not
@return         : account
********************************************************
*/
    public static Account getAccount(String name, Boolean doInsert) {
        Account a = new Account(name = name);
        if(doInsert) {
            insert a;
        }
        return a;
    }
    /*
*********************************************************
@Method Names    : getContact
@author         : Steven Trumble
@description    : methods used to create single contact
@param Id accountId: Id of related account
@param String fname: first name of contact
@param String lname: last name of contact
@param Boolean doInsert : whether to insert the contact or not
@return         : contact
********************************************************
*/
    public static Contact getContact(
        Id accountId,
        String fname,
        String lname,
        Boolean doInsert
    ) {
        Contact c = new Contact(firstName = fname, lastName = lname, accountId = accountId);
        if(doInsert) {
            insert c;
        }
        return c;
    }
       /*
*********************************************************
@Method Names    : generateAccountWithContacts
@author         : Steven Trumble
@description    : methods used to create an account with a specified number of related contacts
@param Integer numContacts: number of contacts to create related to the account
@return         : contacts
********************************************************
*/
    public static void generateAccountWithContacts(Integer numContacts) {
        Account a = getAccount('default account ltd', true);
        List<Contact> contacts = new List<Contact>();
        for(Integer i = 0; i < numContacts; i++) {
            String contactName = 'contact' + i;
            contacts.add(getContact(a.id, contactName, contactName, false));
        }
        insert contacts;
    }
/*
*********************************************************
@Method Name    : createJobApplications
@author         : Steven Trumble
@description    : method to is used to create Job Application(s)
@param Integer numJobApplications: number of job applications that need tasks created
@return         : List of inserted Job Applications
********************************************************
*/    
    public static List<Job_Application__c> createJobApplications(Integer numJobApplications) {
        List<Job_Application__c> jobApplications = new List<Job_Application__c>();
        for (Integer i = 0; i < numJobApplications; i++){
            Job_Application__c jobApplication = new Job_Application__c();
            jobApplications.add(jobApplication);
        }
        insert jobApplications;
        return jobApplications;
    }
/*
*********************************************************
@Method Name    : createJobApplicationContact
@author         : Steven Trumble
@description    : method to is used to create Job Application Contact
@param Id contactId: contact Id to use in the Contact__c field
@param Id jobAppId: Job_Application__c Id to use in the Job_Application__c field
@return         : Job_Application_Contact__c
********************************************************
*/    
    public static Job_Application_Contact__c createJobApplicationContact(
        Id contactId,
        Id jobAppId
    ) {
        Job_Application_Contact__c jobApplicationContact = new Job_Application_Contact__c(Contact__c = contactId, Job_Application__c = jobAppId);
        
        insert jobApplicationContact;
        return jobApplicationContact;
    }

/*
*********************************************************
@Method Name    : createJobApplicationWithAccountAndContacts
@author         : Steven Trumble
@description    : method to create Job Application(s) with related Account and Contacts
@param Integer numJobApplications: number of job applications to create
@param Integer numContacts: number of contacts per job application
@return         : List of inserted Job Applications
********************************************************
*/    
    public static List<Job_Application__c> createJobApplicationWithAccountAndContacts(Integer numJobApplications, Integer numContacts) {
        List<Job_Application__c> jobApplications = new List<Job_Application__c>();
        for (Integer i = 0; i < numJobApplications; i++){
            Account account = getAccount('Account ' + i, true);
            List<Contact> contacts = new List<Contact>();
            for (Integer j = 0; j < numContacts; j++) {
                contacts.add(getContact(account.Id, 'Contact' + j, 'Test', false));
            }
            insert contacts;
            Job_Application__c jobApplication = new Job_Application__c(Company_Name__c = account.Id);
            jobApplications.add(jobApplication);
        }
        insert jobApplications;
        return jobApplications;
    }
    
    public static Job_Application__c createJobApplicationSalary(Decimal salary, String filingStatus) {
        Job_Application__c jobApp = new Job_Application__c(
            Salary__c = salary,
            Filing_Status__c = filingStatus
        );
        
        // set default values for social security and medicare rates
        if (jobApp.Social_Security_Rate__c == null) {
            jobApp.Social_Security_Rate__c = 6.2;  
        }
        if (jobApp.Medicare_Withholding_Rate__c == null) {
            jobApp.Medicare_Withholding_Rate__c = 1.45;
        }        
        return jobApp;
    }
        
    public static List<Job_Application__c> createMultipleJobApplicationSalaries(Integer numApplications) {
        List<Job_Application__c> jobApps = new List<Job_Application__c>();
        
        for (Integer i = 0; i < numApplications; i++) {
            Decimal salary = 50000 + (i * 10000);  // Varying salaries
            String filingStatus = getRandomFilingStatus();
            jobApps.add(createJobApplicationSalary(salary, filingStatus));
        }
        
        return jobApps;
    }
    
    private static String getRandomFilingStatus() {
        Integer randomIndex = Math.mod(Math.abs((Integer)Math.floor(Math.random() * 10)), FILING_STATUSES.size());
        return FILING_STATUSES[randomIndex];
    }
}
