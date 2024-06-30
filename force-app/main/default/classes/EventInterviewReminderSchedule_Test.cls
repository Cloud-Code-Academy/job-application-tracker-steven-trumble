/*
*********************************************************
Apex Class Name    : EventInterviewReminderSchedule_Test
Created Date       : June 2024
@description       : This test class contains unit tests for the EventInterviewReminderSchedule class
@author            : Steven Trumble
*********************************************************
*/
@IsTest
private class EventInterviewReminderSchedule_Test {
/*
*********************************************************
@Method Name    : setupTestData
@author         : Steven Trumble
@description    : method to is used to create the default User, Job_Application__c and Contact records that can be used for all unit tests
@return         : New User, Job Application, Contact
********************************************************
*/
    @TestSetup
    static void setupTestData(){
        TriggerHandler.bypass('JobApplicationTriggerHandler');
        TestDataFactory.testUserDataCreation();
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(8000, 'Single');
        insert jobApp;
        Contact testContact = TestDataFactory.getContact(null, 'Test', 'Contact', true);
    }

    // Helper method to retrieve test data
    private static TestData getTestData() {
        TestData data = new TestData();
        data.testUser = [SELECT Id FROM User WHERE UserName = 'trumbletest@testorg.com.au' LIMIT 1];
        data.jobApp = [SELECT Id FROM Job_Application__c WHERE Filing_Status__c = 'Single' AND Salary__c = 8000 LIMIT 1];
        data.testContact = [SELECT Id FROM Contact WHERE FirstName = 'Test' AND LastName = 'Contact' LIMIT 1];
        return data;
    }

    //inner calls to hold test data
    private class TestData{
        User  testUser;
        Job_Application__c JobApp;
        Contact  testContact;
    }
/*
*********************************************************
@Method Name    : EventInterviewReminderSchedule_oneEventTomorrow_oneEmail
@Method Tested  : EventInterviewReminderSchedule
@description    : Create an event tomorrow and expecting to send one email
********************************************************
*/
   
    @IsTest
    static void EventInterviewReminderSchedule_oneEventTomorrow_oneEmail() {
        TestData data = getTestData();
      
        Date activityDate = Date.today().addDays(1);
        Datetime startDateTime = Datetime.newInstance(activityDate, Time.newInstance(9, 0, 0, 0));
        Integer durationInMinutes = 30;
        
        List<Event> events = TestDataFactory.createEvents(
            1,
            'Interview subject',
            'Technical',
            'Phone',
            activityDate,
            startDateTime,
            durationInMinutes,
            data.testContact.Id,
            data.jobApp.Id,
            data.testUser.Id
        );
        insert events;

        Event insertedEvent = [SELECT Id, Subject, Interview_Type__c, Interview_Format__c, ActivityDate, StartDateTime, EndDateTime, WhoId, WhatId, OwnerId 
                            FROM Event WHERE Id = :events[0].Id];
        System.debug('Inserted Event: ' + insertedEvent);

        Test.startTest();
            EventInterviewReminderSchedule scheduler = new EventInterviewReminderSchedule();
            scheduler.execute(null);
            Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();
        
        // Assert that one email was sent
        System.assertEquals(1, invocations, 'Expected one email to be sent');
        // Query for the event to ensure it was processed
        Event processedEvent = [SELECT Id FROM Event WHERE Id = :events[0].Id];
        System.assertNotEquals(null, processedEvent, 'Expected the event to be processed');

        TriggerHandler.clearAllBypasses();
    }

/*
*********************************************************
@Method Name    : EventInterviewReminderSchedule_oneEventTomorrowTestException_noEmail
@Method Tested  : EventInterviewReminderSchedule
@description    : Create an event tomorrow, but throw an exception. Expect exception caught and no email
********************************************************
*/
    @IsTest
    static void EventInterviewReminderSchedule_oneEventTomorrowTestException_noEmail() {
       TestData data = getTestData();

        Date activityDate = Date.today().addDays(1);
        Datetime startDateTime = Datetime.newInstance(activityDate, Time.newInstance(9, 0, 0, 0));
        Integer durationInMinutes = 30;
        
        List<Event> events = TestDataFactory.createEvents(
                1,
                'Interview subject',
                'Technical',
                'Phone',
                activityDate,
                startDateTime,
                durationInMinutes,
                data.testContact.Id,
                data.jobApp.Id,
                data.testUser.Id
                );
        insert events;

        Event insertedEvent = [SELECT Id, Subject, Interview_Type__c, Interview_Format__c, ActivityDate, StartDateTime, EndDateTime, WhoId, WhatId, OwnerId 
                                FROM Event WHERE Id = :events[0].Id];
        System.debug('Inserted Event: ' + insertedEvent);

        //throw exception
        EventInterviewReminderSchedule.throwTestException = true;

        Test.startTest();
            EventInterviewReminderSchedule scheduler = new EventInterviewReminderSchedule();
            scheduler.execute(null);
            Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();

        System.debug('Email invocations after test: ' + Limits.getEmailInvocations());
        
        // Assert that one no email was sent. Exception should have been caught
        System.assertEquals(0, invocations, 'Expected one email to be sent');
        // Assert on caught exception
        System.assertEquals('Forced exception for testing.', EventInterviewReminderSchedule.lastExceptionMessage,'The expected exception was not caught');
        TriggerHandler.clearAllBypasses();
    }
/*
*********************************************************
@Method Name    : EventInterviewReminderSchedule_oneEventTomorrowWrongSubject_oneEmail
@Method Tested  : EventInterviewReminderSchedule
@description    : Create an event tomorrow that does not include 'interview' in subject, expect
                    an email to be sent as Interview_Type__c and Interview_Format__c not null
********************************************************
*/
    @IsTest
    static void EventInterviewReminderSchedule_oneEventTomorrowWrongSubject_oneEmail() {
        TestData data = getTestData();

        Date activityDate = Date.today().addDays(1);
        Datetime startDateTime = Datetime.newInstance(activityDate, Time.newInstance(9, 0, 0, 0));
        Integer durationInMinutes = 30;

        List<Event> events = TestDataFactory.createEvents(
                1,
                'Wrong subject', //does not have word interview
                'Technical',
                'Phone',
                activityDate,
                startDateTime,
                durationInMinutes,
                data.testContact.Id,
                data.jobApp.Id,
                data.testUser.Id
                );
        insert events;

        Event insertedEvent = [SELECT Id, Subject, Interview_Type__c, Interview_Format__c, ActivityDate, StartDateTime, EndDateTime, WhoId, WhatId, OwnerId 
                                FROM Event WHERE Id = :events[0].Id];
        System.debug('Inserted Event: ' + insertedEvent);

        System.debug('Email invocations before test: ' + Limits.getEmailInvocations());
        Test.startTest();
        EventInterviewReminderSchedule scheduler = new EventInterviewReminderSchedule();
        scheduler.execute(null);
        Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();
        
        // Assert that one email was sent
        System.assertEquals(1, invocations, 'Expected one email to be sent');
        // Query for the event to ensure it was processed
        Event processedEvent = [SELECT Id FROM Event WHERE Id = :events[0].Id];
        System.assertNotEquals(null, processedEvent, 'Expected the event to be processed');
        TriggerHandler.clearAllBypasses();
    }

    /*
*********************************************************
@Method Name    : EventInterviewReminderSchedule_oneEventTomorrowWrongSubjectInterviewTypeInterviewFormat_noEmail
@Method Tested  : EventInterviewReminderSchedule
@description    : Create an event tomorrow that does not include 'interview' in subject, do not provide
                    values for Interview_Type__c and Interview_Format__c. No email should be sent.
********************************************************
*/
    @IsTest
    static void EventInterviewReminderSchedule_oneEventTomorrowWrongSubjectInterviewTypeInterviewFormat_noEmail() {
        TestData data = getTestData();

        Date activityDate = Date.today().addDays(1);
        Datetime startDateTime = Datetime.newInstance(activityDate, Time.newInstance(9, 0, 0, 0));
        Integer durationInMinutes = 30;

        List<Event> events = TestDataFactory.createEvents(
                1,
                'Wrong subject', //does not have word interview
                null,//no value for interview type
                null, //no value for interview format
                activityDate,
                startDateTime,
                durationInMinutes,
                data.testContact.Id,
                data.jobApp.Id,
                data.testUser.Id
                );
        insert events;

        Event insertedEvent = [SELECT Id, Subject, Interview_Type__c, Interview_Format__c, ActivityDate, StartDateTime, EndDateTime, WhoId, WhatId, OwnerId 
                                FROM Event WHERE Id = :events[0].Id];
        System.debug('Inserted Event: ' + insertedEvent);

        Test.startTest();
            EventInterviewReminderSchedule scheduler = new EventInterviewReminderSchedule();
            scheduler.execute(null);
            Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();
        
        // Assert that no email was sent
        System.assertEquals(0, invocations, 'Expected no email to be sent');
        // Query for the event to ensure it was processed
        Event processedEvent = [SELECT Id FROM Event WHERE Id = :events[0].Id];
        System.assertNotEquals(null, processedEvent, 'Expected the event to be processed');
        TriggerHandler.clearAllBypasses();
    }
    /*
*********************************************************
@Method Name    : EventInterviewReminderSchedule_oneEventToday_noEmail
@Method Tested  : EventInterviewReminderSchedule
@description    : Create an event for today (not tomorrow).No email should be sent.
********************************************************
*/
    @IsTest
    static void EventInterviewReminderSchedule_oneEventToday_noEmail() {
        TestData data = getTestData();

        Date activityDate = Date.today();
        Datetime startDateTime = Datetime.newInstance(activityDate, Time.newInstance(9, 0, 0, 0));
        Integer durationInMinutes = 30;

        List<Event> events = TestDataFactory.createEvents(
                1,
                'Interview subject',
                'Technical',
                'Phone',
                activityDate,
                startDateTime,
                durationInMinutes,
                data.testContact.Id,
                data.jobApp.Id,
                data.testUser.Id
                );
        insert events;

        Event insertedEvent = [SELECT Id, Subject, Interview_Type__c, Interview_Format__c, ActivityDate, StartDateTime, EndDateTime, WhoId, WhatId, OwnerId 
                                FROM Event WHERE Id = :events[0].Id];
        System.debug('Inserted Event: ' + insertedEvent);

        Test.startTest();
            EventInterviewReminderSchedule scheduler = new EventInterviewReminderSchedule();
            scheduler.execute(null);
            Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();
        
        // Assert that no email was sent
        System.assertEquals(0, invocations, 'Expected no email to be sent');
        // Query for the event to ensure it was processed
        Event processedEvent = [SELECT Id FROM Event WHERE Id = :events[0].Id];
        System.assertNotEquals(null, processedEvent, 'Expected the event to be processed');
        TriggerHandler.clearAllBypasses();
    }
    /*
*********************************************************
@Method Name    : EventInterviewReminderSchedule_oneEventFuture_noEmail
@Method Tested  : EventInterviewReminderSchedule
@description    : Create an event for the future (not tomorrow).No email should be sent.
********************************************************
*/
    @IsTest
    static void EventInterviewReminderSchedule_oneEventFuture_noEmail() {
        TestData data = getTestData();

        Date activityDate = Date.today().addDays(7); // one week from now
        Datetime startDateTime = Datetime.newInstance(activityDate, Time.newInstance(9, 0, 0, 0));
        Integer durationInMinutes = 30;

        List<Event> events = TestDataFactory.createEvents(
                1,
                'Interview subject',
                'Technical',
                'Phone',
                activityDate,
                startDateTime,
                durationInMinutes,
                data.testContact.Id,
                data.jobApp.Id,
                data.testUser.Id
                );
        insert events;

        Event insertedEvent = [SELECT Id, Subject, Interview_Type__c, Interview_Format__c, ActivityDate, StartDateTime, EndDateTime, WhoId, WhatId, OwnerId 
                                FROM Event WHERE Id = :events[0].Id];
        System.debug('Inserted Event: ' + insertedEvent);

        Test.startTest();
            EventInterviewReminderSchedule scheduler = new EventInterviewReminderSchedule();
            scheduler.execute(null);
            Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();
        
        // Assert that no email was sent
        System.assertEquals(0, invocations, 'Expected no email to be sent');
        //query for the event to ensure it was processed
        Event processedEvent = [SELECT Id FROM Event WHERE Id = :events[0].Id];
        System.assertNotEquals(null, processedEvent, 'Expected the event to be processed');
        TriggerHandler.clearAllBypasses();
    }
    /*
*********************************************************
@Method Name    : EventInterviewReminderSchedule_multipleEventsTomorrow_multipleEmails
@Method Tested  : EventInterviewReminderSchedule
@description    : Create multiple events for tomorrow. Multiple event should be created 
                    multiple emails should be sent but only 1 email invocation.
********************************************************
*/
    @IsTest
    static void EventInterviewReminderSchedule_multipleEventsTomorrow_multipleEmails() {
        TestData data =  getTestData();

        Date activityDate = Date.today().addDays(1);
        Datetime startDateTime = Datetime.newInstance(activityDate, Time.newInstance(9, 0, 0, 0));
        Integer durationInMinutes = 30;
        List<Event> events = TestDataFactory.createEvents(
                5,
                'Interview subject',
                'Technical',
                'Phone',
                activityDate,
                startDateTime,
                durationInMinutes,
                data.testContact.Id,
                data.jobApp.Id,
                data.testUser.Id
                );
        insert events;
        
        Test.startTest();
            EventInterviewReminderSchedule scheduler = new EventInterviewReminderSchedule();
            scheduler.execute(null);
            Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();

        System.debug('Email invocations after test: ' + Limits.getEmailInvocations());
        
        // Assert that getEmailInvocations only 1 -
        System.assertEquals(1, invocations, 'Expected five emails to be sent');

        //query for the Events
        List<Event> processedEvents = [SELECT Id FROM Event WHERE Id = :events AND ActivityDate = :activityDate];
        System.assertEquals(5, processedEvents.size(), 'Expected five events to be processed');
    }
}