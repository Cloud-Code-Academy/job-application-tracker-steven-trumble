/*
This class contains unit tests for validating behvaioiur of logic in JobApplicationUtility class
NEED TO UPDATE SO TESTING THE ACTUAL FUCKING UNIT INSIDE THE TESTBLOCK AND NOT DOING A WHOEL FUCKING INSERT
*/
@IsTest
private class JobApplicationUtility_Test {
    /*
*********************************************************
@Method Tested    : createJobApplicationTasks
@author           : Steven Trumble
@description      : test various scenarios that could occur for createJobApplicationTasks()
********************************************************
*/
    @isTest
    static void JobApplicationUtility_JobApplicationNullStatus_OneTask(){
        List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,null);
        
        Test.startTest();
            JobApplicationUtility.createJobApplicationTasks(jobApplications);
        Test.stopTest();

        // expecting 1 task created
        Integer taskCount = [SELECT COUNT()
                            FROM Task 
                            WHERE WhatId = :jobApplications[0].Id];
        
        System.assertEquals(1, taskCount, 'Expected only one task to be created');
        //check for exact subject match for the task
        Integer taskSubject = [SELECT COUNT()
                                FROM Task 
                                WHERE WhatId = :jobApplications[0].Id
                                AND Subject = 'Select a Status for this Job Application'];
        System.assertEquals(1, taskSubject,'Expected to find a related task with subject of \' Select a Status for this Job Application \' ' );
    }
/*
    @isTest
    static void JobApplicationUtility_updateJobApplicationNullStatus_OneTask(){
        
        //bypass afterInsert trigger
        //JobApplicationTriggerHandler.bypass('afterInsert');
        //insert with non null status
        List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,'Saved');
        insert jobApplications;
        //check no tasks were created
        Integer initialTaskCount = [SELECT COUNT()
                                    FROM Task
                                    WHERE WhatId = :jobApplications[0].Id];
        System.assertEquals(0, initialTaskCount,'Expected no tasks to be created on insertion');

        Test.startTest();
            //update status to null
            jobApplications[0].Status__c = null;
            JobApplicationUtility.createJobApplicationTasks(jobApplications);
        Test.stopTest();        

        // expecting 1 task created
        Integer taskCount = [SELECT COUNT()
                            FROM Task 
                            WHERE WhatId = :jobApplications[0].Id];
        
        System.assertEquals(1, taskCount, 'Expected only one task to be created');

        //check for exact subject match for the task
        Integer taskSubject = [SELECT COUNT()
                                FROM Task 
                                WHERE WhatId = :jobApplications[0].Id
                                AND Subject = 'Select a Status for this Job Application'];
        System.assertEquals(1, taskSubject,'Expected to find a related task with subject of \' Select a Status for this Job Application \' ' );

    }
        */

    @isTest
    static void JobApplicationUtility_JobApplicationSavedStatus_ThreeTasks(){
        List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,'Saved');    
        
        Test.startTest();
            JobApplicationUtility.createJobApplicationTasks(jobApplications);
        Test.stopTest();

        // expecting 3 tasks created
        Integer taskCount = [SELECT COUNT()
                            FROM Task 
                            WHERE WhatId = :jobApplications[0].Id];
        
        System.assertEquals(3, taskCount, 'Expected three tasks to be created');

        //check for exact subject match for one of the tasks
        Integer taskSubject = [SELECT COUNT()
                                FROM Task 
                                WHERE WhatId = :jobApplications[0].Id
                                AND Subject = 'Check if the job description aligns with your interests and values'];
        System.assertEquals(1, taskSubject,'Expected to find a related task with subject of \' Check if the job description aligns with your interests and values \' ' );
    }

    @isTest
    static void JobApplicationUtility_JobApplicationApplyingStatus_FiveTasks(){
        List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,'Applying');    
        
        Test.startTest();
            JobApplicationUtility.createJobApplicationTasks(jobApplications);
        Test.stopTest();

        // expecting 5 tasks created
        Integer taskCount = [SELECT COUNT()
                            FROM Task 
                            WHERE WhatId = :jobApplications[0].Id];
        
        System.assertEquals(5, taskCount, 'Expected five tasks to be created');

        //check for exact subject match for one of the tasks
        Integer taskSubject = [SELECT COUNT()
                                FROM Task 
                                WHERE WhatId = :jobApplications[0].Id
                                AND Subject = 'Find and research someone who works at the company and add them as a contact'];
        System.assertEquals(1, taskSubject,'Expected to find a related task with subject of \' Find and research someone who works at the company and add them as a contact \' ' );
    }

    @isTest
    static void JobApplicationUtility_JobApplicationAppliedStatus_FourTasks(){
        List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,'Applied');    
        
        Test.startTest();
            JobApplicationUtility.createJobApplicationTasks(jobApplications);
        Test.stopTest();

        // expecting 4 tasks created
        Integer taskCount = [SELECT COUNT()
                            FROM Task 
                            WHERE WhatId = :jobApplications[0].Id];
        
        System.assertEquals(4, taskCount, 'Expected four tasks to be created');

        //check for exact subject match for one of the tasks
        Integer taskSubject = [SELECT COUNT()
                                FROM Task 
                                WHERE WhatId = :jobApplications[0].Id
                                AND Subject = 'Follow up on your application via email weekly'];
        System.assertEquals(1, taskSubject,'Expected to find a related task with subject of \' Follow up on your application via email weekly \' ' );
    }
    
    @isTest
    static void JobApplicationUtility_JobApplicationInterviewingStatus_FiveTasks(){
        List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,'Interviewing');

        Test.startTest();
            JobApplicationUtility.createJobApplicationTasks(jobApplications);
        Test.stopTest();

        // expecting 5 tasks created
        Integer taskCount = [SELECT COUNT()
                            FROM Task 
                            WHERE WhatId = :jobApplications[0].Id];
        
        System.assertEquals(5, taskCount, 'Expected five tasks to be created');

        //check for exact subject match for one of the tasks
        Integer taskSubject = [SELECT COUNT()
                                FROM Task 
                                WHERE WhatId = :jobApplications[0].Id
                                AND Subject = 'Practice answering behavioral interview questions'];
        System.assertEquals(1, taskSubject,'Expected to find a related task with subject of \'Practice answering behavioral interview questions\' ' );
    }

    @isTest
    static void JobApplicationUtility_JobApplicationNegotiatingStatus_ThreeTasks(){
        List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,'Negotiating');

        Test.startTest();
            JobApplicationUtility.createJobApplicationTasks(jobApplications);    
        Test.stopTest();

        // expecting 3 tasks created
        Integer taskCount = [SELECT COUNT()
                            FROM Task 
                            WHERE WhatId = :jobApplications[0].Id];
        
        System.assertEquals(3, taskCount, 'Expected three tasks to be created');

        //check for exact subject match for one of the tasks
        Integer taskSubject = [SELECT COUNT()
                                FROM Task 
                                WHERE WhatId = :jobApplications[0].Id
                                AND Subject = 'Evaluate your offer and decline or accept'];
        System.assertEquals(1, taskSubject,'Expected to find a related task with subject of \'Evaluate your offer and decline or accept\' ' );
    }
   
    @isTest
    static void JobApplicationUtility_JobApplicationAcceptedStatus_ThreeTasks(){
        List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,'Accepted');

        Test.startTest();
            JobApplicationUtility.createJobApplicationTasks(jobApplications);    
        Test.stopTest();

        // expecting 3 tasks created
        Integer taskCount = [SELECT COUNT()
                            FROM Task 
                            WHERE WhatId = :jobApplications[0].Id];
        
        System.assertEquals(3, taskCount, 'Expected three tasks to be created');

        //check for exact subject match for one of the tasks
        Integer taskSubject = [SELECT COUNT()
                                FROM Task 
                                WHERE WhatId = :jobApplications[0].Id
                                AND Subject = 'Plan your resignation if applicable'];
        System.assertEquals(1, taskSubject,'Expected to find a related task with subject of \'Plan your resignation if applicable\' ' );
    }
    
    @isTest
    static void JobApplicationUtility_JobApplicationClosedStatus_TwoTasks(){
        List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,'Closed');

        Test.startTest();
            JobApplicationUtility.createJobApplicationTasks(jobApplications);    
        Test.stopTest();

        // expecting 2 tasks created
        Integer taskCount = [SELECT COUNT()
                            FROM Task 
                            WHERE WhatId = :jobApplications[0].Id];
        
        System.assertEquals(2, taskCount, 'Expected two tasks to be created');

        //check for exact subject match for one of the tasks
        Integer taskSubject = [SELECT COUNT()
                                FROM Task 
                                WHERE WhatId = :jobApplications[0].Id
                                AND Subject = 'Review your notes and reflect on areas of improvement'];
        System.assertEquals(1, taskSubject,'Expected to find a related task with subject of \'Review your notes and reflect on areas of improvement\' ' );
    }
    
    @isTest
    static void JobApplicationUtility_JobApplicationBulk_BulkTasks(){
        final Integer JOB_APPLICATIONS_TO_CREATE = 300;
        final Integer EXPECTED_TASKS_PER_JOB_APPLICATION = 3;

        List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(JOB_APPLICATIONS_TO_CREATE,'Saved');
        
        Test.startTest();
            JobApplicationUtility.createJobApplicationTasks(jobApplications);
        Test.stopTest();
        
        System.debug('Number of Job Applications Created: ' + jobApplications.size());

        // expecting 900 tasks created
        Integer taskCount = [SELECT COUNT()
                            FROM Task];
        
        System.assertEquals(JOB_APPLICATIONS_TO_CREATE * EXPECTED_TASKS_PER_JOB_APPLICATION , taskCount, 'Expected 900 tasks to be created');
    }

    /*
*********************************************************
@Method Tested    : setPrimaryContact
@author           : Steven Trumble
@description      : test various scenarios that could occur for setPrimaryContact()
                    JAC = Job_Application_Contact__c
********************************************************
*/
    @isTest
    static void testJobApplicationPrimaryContactExists(){
        Job_Application__c jobApp = TestDataFactory.createJobApplications(1)[0];
        Contact existingContact = TestDataFactory.getContact(jobApp.Company_Name__c, 'Test', 'LastName', true);
        jobApp.Primary_Contact__c = existingContact.Id;
        update jobApp;
        
        // Call the utility method to set primary contact
        JobApplicationUtility.setPrimaryContact(new List<Job_Application__c>{ jobApp });

        // Retrieve the job application again to verify Primary_Contact__c
        jobApp = [SELECT Id, Primary_Contact__c FROM Job_Application__c WHERE Id = :jobApp.Id];

        // Assert that Primary_Contact__c remains unchanged
        System.assertEquals(existingContact.Id, jobApp.Primary_Contact__c, 'Primary contact should not be overwritten');
        System.assertNotEquals(existingContact.Id, null, 'Primary Contact should not be null');
    }
    
    @isTest
    static void testJobApplicationPrimaryContactNullJACExists() {
        // Create a job application
        Job_Application__c jobApp = TestDataFactory.createJobApplications(1)[0];
        System.debug('Job Application: ' + jobApp);
    
        // Create a contact associated through Job_Application_Contact__c
        Contact contact = TestDataFactory.getContact(null, 'Test', 'LastName', true);
        System.debug('Contact: ' + contact);
    
        Job_Application_Contact__c jobAppContact = TestDataFactory.createJobApplicationContact(contact.Id, jobApp.Id);
        System.debug('Job Application Contact: ' + jobAppContact);
    
        // Call the utility method to set primary contact
        Test.startTest();
            JobApplicationUtility.setPrimaryContact(new List<Job_Application__c>{ jobApp });
            update jobApp;
        Test.stopTest();
    
        // Retrieve the job application again to verify Primary_Contact__c
        jobApp = [SELECT Id, Primary_Contact__c FROM Job_Application__c WHERE Id = :jobApp.Id];
        System.debug('Updated Job Application: ' + jobApp);
    
        // Assert that Primary_Contact__c is set to the contact from Job_Application_Contact__c
        System.assertEquals(contact.Id, jobApp.Primary_Contact__c, 'Primary contact should be set from Job_Application_Contact__c');
    }

    @isTest
    static void testPrimaryContactNullNoJACCompanyContactExists() {
        // Create a company (Account) with related contacts
        Account companyAccount = TestDataFactory.getAccount('Test Company', true);
        Contact companyContact = TestDataFactory.getContact(companyAccount.Id, 'Test', 'LastName', true);

        // Create a job application with Company_Name__c set
        Job_Application__c jobApp = new Job_Application__c(Company_Name__c = companyAccount.Id);
        insert jobApp;

        // Call the utility method to set primary contact
        JobApplicationUtility.setPrimaryContact(new List<Job_Application__c>{ jobApp });

        // Retrieve the job application again to verify Primary_Contact__c
        jobApp = [
            SELECT Id, Primary_Contact__c 
            FROM Job_Application__c 
            WHERE Id = :jobApp.Id
            ];

        // Query for the first contact related to the Company_Name__c
        List<Contact> companyContacts = [
            SELECT Id 
            FROM Contact 
            WHERE AccountId = :companyAccount.Id 
            ORDER BY CreatedDate ASC 
            LIMIT 1
            ];

        // Assert that Primary_Contact__c is set to the first contact's Id
        System.assertEquals(companyContacts[0].Id, jobApp.Primary_Contact__c, 'Primary contact should be set from Company_Name__c contacts');
    }

    @isTest
    static void testPrimaryContactNullNoJACNoCompanyContacts() {
        // Create a company (Account) without any related contacts
        Account companyAccount = TestDataFactory.getAccount('Test Company', true);

        // Create a job application with Company_Name__c set
        Job_Application__c jobApp = new Job_Application__c(Company_Name__c = companyAccount.Id);
        insert jobApp;

        // Call the utility method to set primary contact
        JobApplicationUtility.setPrimaryContact(new List<Job_Application__c>{ jobApp });

        // Retrieve the job application again to verify Primary_Contact__c
        jobApp = [SELECT Id, Primary_Contact__c FROM Job_Application__c WHERE Id = :jobApp.Id];

        // Assert that Primary_Contact__c remains null
        System.assertEquals(null, jobApp.Primary_Contact__c, 'Primary contact should remain null when no contacts are associated');
    }

    @isTest
    static void testPrimaryContactNullNoJACCompanyNull() {
        // Create a job application with Company_Name__c set to null
        Job_Application__c jobApp = new Job_Application__c();
        insert jobApp;

        // Call the utility method to set primary contact
        JobApplicationUtility.setPrimaryContact(new List<Job_Application__c>{ jobApp });

        // Retrieve the job application again to verify Primary_Contact__c
        jobApp = [SELECT Id, Primary_Contact__c FROM Job_Application__c WHERE Id = :jobApp.Id];

        // Assert that Primary_Contact__c remains null
        System.assertEquals(null, jobApp.Primary_Contact__c, 'Primary contact should remain null when Company_Name__c is null and no existing Job_Application_Contact__c records');
    }

    @isTest
    static void testBulkSetPrimaryContact() {
        // Create a list of job applications with different scenarios
        List<Job_Application__c> jobApps = new List<Job_Application__c>();

        // Scenario 1: Primary_Contact__c is null, Associated Job_Application_Contact__c record exists
        Job_Application__c jobApp1 = TestDataFactory.createJobApplications(1)[0];
        Contact existingContact1 = TestDataFactory.getContact(null, 'Test1', 'LastName1', true);
        Job_Application_Contact__c jobAppContact1 = TestDataFactory.createJobApplicationContact(existingContact1.Id,jobApp1.Id);
        jobApp1.Primary_Contact__c = null; // Ensure Primary_Contact__c is null
        jobApps.add(jobApp1);

        // Scenario 2: Primary_Contact__c is null, No associated Job_Application_Contact__c, Company_Name__c has contacts
        Job_Application__c jobApp2 = TestDataFactory.createJobApplications(1)[0];
        Account account2 = TestDataFactory.getAccount('Test Company2', true); // Create an Account with contacts
        Contact existingContact2 = TestDataFactory.getContact(account2.Id, 'Test2', 'LastName2', true);
        jobApp2.Primary_Contact__c = null; // Ensure Primary_Contact__c is null
        jobApp2.Company_Name__c = account2.Id;
        jobApps.add(jobApp2);

        // Scenario 3: Primary_Contact__c is null, No associated Job_Application_Contact__c, Company_Name__c has no contacts
        Job_Application__c jobApp3 = TestDataFactory.createJobApplications(1)[0];
        jobApp3.Company_Name__c = TestDataFactory.getAccount('Test Company3', true).Id; // Company_Name__c without contacts
        jobApp3.Primary_Contact__c = null; // Ensure Primary_Contact__c is null
        jobApps.add(jobApp3);

        // Scenario 4: Primary_Contact__c is null, No associated Job_Application_Contact__c, Company_Name__c is null
        Job_Application__c jobApp4 = TestDataFactory.createJobApplications(1)[0];
        jobApp4.Company_Name__c = null; // Company_Name__c is null
        jobApp4.Primary_Contact__c = null; // Ensure Primary_Contact__c is null
        jobApps.add(jobApp4);

        // Call the utility method to set primary contacts in bulk
        Test.startTest();
        JobApplicationUtility.setPrimaryContact(jobApps);
        update jobApps;
        Test.stopTest();

        // Retrieve the job applications again to verify Primary_Contact__c
        Map<Id, Job_Application__c> jobAppMap = new Map<Id, Job_Application__c>([
            SELECT Id, Primary_Contact__c 
            FROM Job_Application__c 
            WHERE Id IN :jobApps
        ]);

        // Perform assertions

        // Scenario 1: Ensure Primary_Contact__c is set to the existing contact from Job_Application_Contact__c
        System.assertEquals(existingContact1.Id, jobAppMap.get(jobApp1.Id).Primary_Contact__c, 'Scenario 1: Primary contact should be set from Job_Application_Contact__c');

        // Scenario 2: Ensure Primary_Contact__c is set to the existing contact from Company_Name__c
        System.assertEquals(existingContact2.Id, jobAppMap.get(jobApp2.Id).Primary_Contact__c, 'Scenario 2: Primary contact should be set from contacts related to Company_Name__c');

        // Scenario 3: Ensure Primary_Contact__c remains null as Company_Name__c has no contacts
        System.assertEquals(null, jobAppMap.get(jobApp3.Id).Primary_Contact__c, 'Scenario 3: Primary contact should remain null when Company_Name__c has no contacts and no Job_Application_Contact__c records');

        // Scenario 4: Ensure Primary_Contact__c remains null as Company_Name__c is null
        System.assertEquals(null, jobAppMap.get(jobApp4.Id).Primary_Contact__c, 'Scenario 4: Primary contact should remain null when Company_Name__c is null and no Job_Application_Contact__c records');
    }        
}
    

    //bulk processsing with mixed scenarios in list
