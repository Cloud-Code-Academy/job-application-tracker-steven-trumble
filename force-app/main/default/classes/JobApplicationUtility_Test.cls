/*
*********************************************************
Apex Class Name    : JobApplicationUtility_Test
Created Date       : June 2024
@description       : This test class contains unit tests for the JobApplicationUtility class
@author            : Steven Trumble
*********************************************************
*/
@IsTest
private class JobApplicationUtility_Test {
    /*
*********************************************************
@Method Name      : createJobApplicationTasks_JobApplicationNullStatus_OneTask
@Method Tested    : createJobApplicationTasks
@description      : Job Application with no Status provided, expecting one task
********************************************************
*/
    @isTest
    static void createJobApplicationTasks_JobApplicationNullStatus_OneTask(){
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
*********************************************************
@Method Name      : createJobApplicationTasks_JobApplicationSavedStatus_ThreeTasks
@Method Tested    : createJobApplicationTasks
@description      : Job Application with Saved Status provided, expecting three tasks
********************************************************
*/
    @isTest
    static void createJobApplicationTasks_JobApplicationSavedStatus_ThreeTasks(){
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
    /*
*********************************************************
@Method Name      : createJobApplicationTasks_JobApplicationApplyingStatus_FiveTasks
@Method Tested    : createJobApplicationTasks
@description      : Job Application with Applying Status provided, expecting five tasks
********************************************************
*/
    @isTest
    static void createJobApplicationTasks_JobApplicationApplyingStatus_FiveTasks(){
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
  /*
*********************************************************
@Method Name      : createJobApplicationTasks_JobApplicationAppliedStatus_FourTasks
@Method Tested    : createJobApplicationTasks
@description      : Job Application with Applied Status, expecting four tasks
********************************************************
*/
    @isTest
    static void createJobApplicationTasks_JobApplicationAppliedStatus_FourTasks(){
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
  /*
*********************************************************
@Method Name      : createJobApplicationTasks_JobApplicationInterviewingStatus_FiveTasks
@Method Tested    : createJobApplicationTasks
@description      : Job Application with Interviewing Status, expecting five tasks
********************************************************
*/    
    @isTest
    static void createJobApplicationTasks_JobApplicationInterviewingStatus_FiveTasks(){
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
 /*
*********************************************************
@Method Name      : createJobApplicationTasks_JobApplicationNegotiatingStatus_ThreeTasks
@Method Tested    : createJobApplicationTasks
@description      : Job Application with Negotiating Status, expecting three tasks
********************************************************
*/  
    @isTest
    static void createJobApplicationTasks_JobApplicationNegotiatingStatus_ThreeTasks(){
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
 /*
*********************************************************
@Method Name      : createJobApplicationTasks_JobApplicationAcceptedStatus_ThreeTasks
@Method Tested    : createJobApplicationTasks
@description      : Job Application with Accepted Status, expecting three tasks
********************************************************
*/    
    @isTest
    static void createJobApplicationTasks_JobApplicationAcceptedStatus_ThreeTasks(){
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
   /*
*********************************************************
@Method Name      : createJobApplicationTasks_JobApplicationClosedStatus_TwoTasks
@Method Tested    : createJobApplicationTasks
@description      : Job Application with Closed Status, expecting two tasks
********************************************************
*/    
    @isTest
    static void createJobApplicationTasks_JobApplicationClosedStatus_TwoTasks(){
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
   /*
*********************************************************
@Method Name      : createJobApplicationTasks_JobApplicationBulk_BulkTasks
@Method Tested    : createJobApplicationTasks
@description      : Creating 300 Job Applications with a status that should return 3 tasks each. Expecting 900 tasks.
********************************************************
*/  
    @isTest
    static void createJobApplicationTasks_JobApplicationBulk_BulkTasks(){
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
@Method Name      : createJobApplicationTasks_throwException_NoTask
@Method Tested    : createJobApplicationTasks
@description      : Testing exception handling capability
********************************************************
*/  
    @isTest
    static void createJobApplicationTasks_throwException_NoTask(){
        List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,null);
        JobApplicationUtility.throwTestException = true;
        Test.startTest();
            JobApplicationUtility.createJobApplicationTasks(jobApplications);
        Test.stopTest();

        // expecting 0 task created
        Integer taskCount = [SELECT COUNT()
                            FROM Task 
                            WHERE WhatId = :jobApplications[0].Id];
        
        System.assertEquals(0, taskCount, 'Expected only no task to be created');
        //check for exception message
        System.assertEquals('Forced exception for testing.', JobApplicationUtility.lastExceptionMessage,'The expected exception was not caught');
        
    }

    /*
*********************************************************
@Method Name      : setPrimaryContact_JobApplicationPrimaryContactNullJACExists_PrimaryContactUpdated
@Method Tested    : setPrimaryContact
@Acronym          : JAC = Job_Application_Contact__c
@description      : Job_Application__c has no Primary_Contact__c, but there is a Job_Application_Contact__c. 
                    Expect JAC to become Primary_Contact__c
********************************************************
*/
    
    @isTest
    static void setPrimaryContact_JobApplicationPrimaryContactNullJACExists_PrimaryContactUpdated() {
        TriggerHandler.bypass('JobApplicationTriggerHandler');
        // Create a job application
        Job_Application__c jobApp = TestDataFactory.createJobApplications(1,true)[0];
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
        //primary contact should not be null
        System.assertNotEquals(null, jobApp.Primary_Contact__c, 'Primary contact should not be null');
        TriggerHandler.clearAllBypasses();
    }
    /*
*********************************************************
@Method Name      : setPrimaryContact_PrimaryContactNullNoJACCompanyContactExists_PrimaryContactIsAccountContact
@Method Tested    : setPrimaryContact
@Acronym          : JAC = Job_Application_Contact__c
@description      : Job_Application__c has no Primary_Contact__c, but there is an Account in Company_Name__c with a Contact. 
                    Expect Account's Contact to become Primary_Contact__c
********************************************************
*/
    @isTest
    static void setPrimaryContact_PrimaryContactNullNoJACCompanyContactExists_PrimaryContactIsAccountContact() {
        TriggerHandler.bypass('JobApplicationTriggerHandler');
        // Create a company (Account) with related contacts
        Account companyAccount = TestDataFactory.getAccount('Test Company', true);
        Contact companyContact = TestDataFactory.getContact(companyAccount.Id, 'Test', 'LastName', true);

        // Create a job application with Company_Name__c set
        Job_Application__c jobApp = new Job_Application__c(Company_Name__c = companyAccount.Id);
        insert jobApp;

        Test.startTest();
            // Call the utility method to set primary contact
            JobApplicationUtility.setPrimaryContact(new List<Job_Application__c>{ jobApp });
            update jobApp;
        Test.stopTest();

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
        TriggerHandler.clearAllBypasses();
    }
    /*
*********************************************************
@Method Name      : setPrimaryContact_PrimaryContactNullNoJACCompanyContactExists_PrimaryContactIsAccountContact
@Method Tested    : setPrimaryContact
@Acronym          : JAC = Job_Application_Contact__c
@description      : Job_Application__c has no Primary_Contact__c, there is an Account in Company_Name__c without a Contact. 
                    No JAC record.
                    Expect Primary_Contact__c to remain null.
********************************************************
*/
    @isTest
    static void setPrimaryContact_PrimaryContactNullNoJACNoCompanyContacts_RemainNull() {
        TriggerHandler.bypass('JobApplicationTriggerHandler');
        
        // Create a company (Account) without any related contacts
        Account companyAccount = TestDataFactory.getAccount('Test Company', true);

        // Create a job application with Company_Name__c set
        Job_Application__c jobApp = new Job_Application__c(Company_Name__c = companyAccount.Id);
        insert jobApp;

        Test.startTest();
            // Call the utility method to set primary contact
            JobApplicationUtility.setPrimaryContact(new List<Job_Application__c>{ jobApp });
            update jobApp;
        Test.stopTest();

        // Retrieve the job application again to verify Primary_Contact__c
        jobApp = [SELECT Id, Primary_Contact__c FROM Job_Application__c WHERE Id = :jobApp.Id];

        // Assert that Primary_Contact__c remains null
        System.assertEquals(null, jobApp.Primary_Contact__c, 'Primary contact should remain null when no contacts are associated');
        TriggerHandler.clearAllBypasses();
    }
    /*
*********************************************************
@Method Name      : setPrimaryContact_PrimaryContactNullNoJACCompanyNull_RemainNull
@Method Tested    : setPrimaryContact
@Acronym          : JAC = Job_Application_Contact__c
@description      : Job_Application__c has no Primary_Contact__c, there is no Account in Company_Name__c. 
                    No JAC record.
                    Expect Primary_Contact__c to remain null.
********************************************************
*/
    @isTest
    static void setPrimaryContact_PrimaryContactNullNoJACCompanyNull_RemainNull() {
        TriggerHandler.bypass('JobApplicationTriggerHandler');
        // Create a job application with Company_Name__c set to null
        Job_Application__c jobApp = new Job_Application__c();
        insert jobApp;

        Test.startTest();
            // Call the utility method to set primary contact
            JobApplicationUtility.setPrimaryContact(new List<Job_Application__c>{ jobApp });
        Test.stopTest();

        // Retrieve the job application again to verify Primary_Contact__c
        jobApp = [SELECT Id, Primary_Contact__c FROM Job_Application__c WHERE Id = :jobApp.Id];

        // Assert that Primary_Contact__c remains null
        System.assertEquals(null, jobApp.Primary_Contact__c, 'Primary contact should remain null when Company_Name__c is null and no existing Job_Application_Contact__c records');
        TriggerHandler.clearAllBypasses();
    }
    /*
*********************************************************
@Method Name      : setPrimaryContact_BulkSetPrimaryContact_JobApplicationsHavePrimaryContact
@Method Tested    : setPrimaryContact
@Acronym          : JAC = Job_Application_Contact__c
@description      : Use a list with multiple Job_Application_records and multiple contacts.
                    Expect Primary_Contact__c to be assigned for each Job_Application__c
********************************************************
*/
    @isTest
    static void setPrimaryContact_BulkSetPrimaryContact_JobApplicationsHavePrimaryContact() {
        TriggerHandler.bypass('JobApplicationTriggerHandler');
        // Create a list of job applications with different scenarios
        List<Job_Application__c> jobApps = new List<Job_Application__c>();

        // Scenario 1: Primary_Contact__c is null, Associated Job_Application_Contact__c record exists
        Job_Application__c jobApp1 = TestDataFactory.createJobApplications(1,true)[0];
        Contact existingContact1 = TestDataFactory.getContact(null, 'Test1', 'LastName1', true);
        Job_Application_Contact__c jobAppContact1 = TestDataFactory.createJobApplicationContact(existingContact1.Id,jobApp1.Id);
        jobApp1.Primary_Contact__c = null; // Ensure Primary_Contact__c is null
        jobApps.add(jobApp1);

        // Scenario 2: Primary_Contact__c is null, No associated Job_Application_Contact__c, Company_Name__c has contacts
        Job_Application__c jobApp2 = TestDataFactory.createJobApplications(1,true)[0];
        Account account2 = TestDataFactory.getAccount('Test Company2', true); // Create an Account with contacts
        Contact existingContact2 = TestDataFactory.getContact(account2.Id, 'Test2', 'LastName2', true);
        jobApp2.Primary_Contact__c = null; // Ensure Primary_Contact__c is null
        jobApp2.Company_Name__c = account2.Id;
        jobApps.add(jobApp2);

        // Scenario 3: Primary_Contact__c is null, No associated Job_Application_Contact__c, Company_Name__c has no contacts
        Job_Application__c jobApp3 = TestDataFactory.createJobApplications(1,true)[0];
        jobApp3.Company_Name__c = TestDataFactory.getAccount('Test Company3', true).Id; // Company_Name__c without contacts
        jobApp3.Primary_Contact__c = null; // Ensure Primary_Contact__c is null
        jobApps.add(jobApp3);

        // Scenario 4: Primary_Contact__c is null, No associated Job_Application_Contact__c, Company_Name__c is null
        Job_Application__c jobApp4 = TestDataFactory.createJobApplications(1,true)[0];
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
        TriggerHandler.clearAllBypasses();
    }

    /*
*********************************************************
@Method Name    : setPrimaryContact_throwException
@Method Tested  : setPrimaryContact
@description    : Test exception handling
********************************************************
*/
    @isTest
    static void setPrimaryContact_throwException(){
        JobApplicationUtility.throwTestException = true;

        TriggerHandler.bypass('JobApplicationTriggerHandler');
        // Create a job application with Company_Name__c set to null
        Job_Application__c jobApp = new Job_Application__c();
        insert jobApp;

        Test.startTest();
            JobApplicationUtility.setPrimaryContact(new List<Job_Application__c>{ jobApp });
        Test.stopTest();

        System.assertEquals('Forced exception for testing.', JobApplicationUtility.lastExceptionMessage,'The expected exception was not caught');
        
    }
}
