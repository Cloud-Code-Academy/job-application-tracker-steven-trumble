/*
This class contains unit tests for validating behvaioiur of logic in Job_Application_Utility class
*/
@IsTest

private class Job_Application_Utility_Test {
    @isTest
    static void createJobApplicationNullStatus(){
        
        Test.startTest();
            List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,null);
        Test.stopTest();

        // expecting 1 task created
        Integer taskCount = [SELECT COUNT()
                            FROM Task 
                            WHERE WhatId = :jobApplications[0].Id];
        
        System.assertEquals(1, taskCount, 'Expected only one task to be created');
    }

    @isTest
    static void createJobApplicationSavedStatus(){
                
        Test.startTest();
            List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,'Saved');
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
    static void createJobApplicationApplyingStatus(){
                
        Test.startTest();
            List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,'Applying');
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
    static void createJobApplicationAppliedStatus(){
                
        Test.startTest();
            List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,'Applied');
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
    static void createJobApplicationInterviewingStatus(){
                
        Test.startTest();
            List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,'Interviewing');
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
    static void createJobApplicationNegotiatingStatus(){
                
        Test.startTest();
            List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,'Negotiating');
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
    static void createJobApplicationAcceptedStatus(){
                
        Test.startTest();
            List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,'Accepted');
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
    static void createJobApplicationClosedStatus(){
                
        Test.startTest();
            List<Job_Application__c> jobApplications = TestDataFactory.createJobApplicationsWithStatus(1,'Closed');
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
}