@IsTest
private class EventInterviewReminderSchedule_Test {
   
    @IsTest
    static void EventInterviewReminderSchedule_oneEventTomorrow_oneEmail() {
        User user = TestDataFactory.testUserDataCreation();

        System.debug('User: ' + user);
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(8000, 'Single');
        insert jobApp;
        System.debug('jobApp: ' + jobApp);

        Contact testContact = TestDataFactory.getContact(null,'Test','Contact',true);
        System.debug('testContact: ' + testContact);

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
                testContact.Id,
                jobApp.Id,
                user.Id
                );
        insert events;
        System.debug('Events: ' + events);
        Event insertedEvent = [SELECT Id, Subject, Interview_Type__c, Interview_Format__c, ActivityDate, StartDateTime, EndDateTime, WhoId, WhatId, OwnerId 
                                FROM Event WHERE Id = :events[0].Id];
        System.debug('Inserted Event: ' + insertedEvent);

        
        System.debug('Email invocations before test: ' + Limits.getEmailInvocations());
        Test.startTest();
        EventInterviewReminderSchedule scheduler = new EventInterviewReminderSchedule();
        scheduler.execute(null);
        Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();

        System.debug('Email invocations after test: ' + Limits.getEmailInvocations());
        
        // Assert that one email was sent
        System.assertEquals(1, invocations, 'Expected one email to be sent');

        // Query for the event to ensure it was processed
        Event processedEvent = [SELECT Id FROM Event WHERE Id = :events[0].Id];
        System.assertNotEquals(null, processedEvent, 'Expected the event to be processed');
    }

    @IsTest
    static void EventInterviewReminderSchedule_oneEventTomorrowTestException_noEmail() {
        User user = TestDataFactory.testUserDataCreation();

        System.debug('User: ' + user);
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(8000, 'Single');
        insert jobApp;
        System.debug('jobApp: ' + jobApp);

        Contact testContact = TestDataFactory.getContact(null,'Test','Contact',true);
        System.debug('testContact: ' + testContact);

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
                testContact.Id,
                jobApp.Id,
                user.Id
                );
        insert events;
        System.debug('Events: ' + events);
        Event insertedEvent = [SELECT Id, Subject, Interview_Type__c, Interview_Format__c, ActivityDate, StartDateTime, EndDateTime, WhoId, WhatId, OwnerId 
                                FROM Event WHERE Id = :events[0].Id];
        System.debug('Inserted Event: ' + insertedEvent);

        
        System.debug('Email invocations before test: ' + Limits.getEmailInvocations());

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
    }

    @IsTest
    static void EventInterviewReminderSchedule_oneEventTomorrowWrongSubject_oneEmail() {
        User user = TestDataFactory.testUserDataCreation();

        System.debug('User: ' + user);
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(8000, 'Single');
        insert jobApp;
        System.debug('jobApp: ' + jobApp);

        Contact testContact = TestDataFactory.getContact(null,'Test','Contact',true);
        System.debug('testContact: ' + testContact);

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
                testContact.Id,
                jobApp.Id,
                user.Id
                );
        insert events;
        System.debug('Events: ' + events);
        Event insertedEvent = [SELECT Id, Subject, Interview_Type__c, Interview_Format__c, ActivityDate, StartDateTime, EndDateTime, WhoId, WhatId, OwnerId 
                                FROM Event WHERE Id = :events[0].Id];
        System.debug('Inserted Event: ' + insertedEvent);

        
        System.debug('Email invocations before test: ' + Limits.getEmailInvocations());
        Test.startTest();
        EventInterviewReminderSchedule scheduler = new EventInterviewReminderSchedule();
        scheduler.execute(null);
        Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();

        System.debug('Email invocations after test: ' + Limits.getEmailInvocations());
        
        // Assert that one email was sent
        System.assertEquals(1, invocations, 'Expected one email to be sent');

        // Query for the event to ensure it was processed
        Event processedEvent = [SELECT Id FROM Event WHERE Id = :events[0].Id];
        System.assertNotEquals(null, processedEvent, 'Expected the event to be processed');
    }

    @IsTest
    static void EventInterviewReminderSchedule_oneEventTomorrowWrongSubjectInterviewTypeInterviewFormat_noEmail() {
        User user = TestDataFactory.testUserDataCreation();

        System.debug('User: ' + user);
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(8000, 'Single');
        insert jobApp;
        System.debug('jobApp: ' + jobApp);

        Contact testContact = TestDataFactory.getContact(null,'Test','Contact',true);
        System.debug('testContact: ' + testContact);

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
                testContact.Id,
                jobApp.Id,
                user.Id
                );
        insert events;
        System.debug('Events: ' + events);
        Event insertedEvent = [SELECT Id, Subject, Interview_Type__c, Interview_Format__c, ActivityDate, StartDateTime, EndDateTime, WhoId, WhatId, OwnerId 
                                FROM Event WHERE Id = :events[0].Id];
        System.debug('Inserted Event: ' + insertedEvent);

        
        System.debug('Email invocations before test: ' + Limits.getEmailInvocations());
        Test.startTest();
        EventInterviewReminderSchedule scheduler = new EventInterviewReminderSchedule();
        scheduler.execute(null);
        Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();

        System.debug('Email invocations after test: ' + Limits.getEmailInvocations());
        
        // Assert that no email was sent
        System.assertEquals(0, invocations, 'Expected no email to be sent');

        // Query for the event to ensure it was processed
        Event processedEvent = [SELECT Id FROM Event WHERE Id = :events[0].Id];
        System.assertNotEquals(null, processedEvent, 'Expected the event to be processed');
    }

    @IsTest
    static void EventInterviewReminderSchedule_oneEventToday_noEmail() {
        User user = TestDataFactory.testUserDataCreation();

        System.debug('User: ' + user);
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(8000, 'Single');
        insert jobApp;
        System.debug('jobApp: ' + jobApp);

        Contact testContact = TestDataFactory.getContact(null,'Test','Contact',true);
        System.debug('testContact: ' + testContact);

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
                testContact.Id,
                jobApp.Id,
                user.Id
                );
        insert events;
        System.debug('Events: ' + events);
        Event insertedEvent = [SELECT Id, Subject, Interview_Type__c, Interview_Format__c, ActivityDate, StartDateTime, EndDateTime, WhoId, WhatId, OwnerId 
                                FROM Event WHERE Id = :events[0].Id];
        System.debug('Inserted Event: ' + insertedEvent);

        
        System.debug('Email invocations before test: ' + Limits.getEmailInvocations());
        Test.startTest();
        EventInterviewReminderSchedule scheduler = new EventInterviewReminderSchedule();
        scheduler.execute(null);
        Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();

        System.debug('Email invocations after test: ' + Limits.getEmailInvocations());
        
        // Assert that no email was sent
        System.assertEquals(0, invocations, 'Expected no email to be sent');

        // Query for the event to ensure it was processed
        Event processedEvent = [SELECT Id FROM Event WHERE Id = :events[0].Id];
        System.assertNotEquals(null, processedEvent, 'Expected the event to be processed');
    }

    @IsTest
    static void EventInterviewReminderSchedule_oneEventFuture_noEmail() {
        User user = TestDataFactory.testUserDataCreation();

        System.debug('User: ' + user);
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(8000, 'Single');
        insert jobApp;
        System.debug('jobApp: ' + jobApp);

        Contact testContact = TestDataFactory.getContact(null,'Test','Contact',true);
        System.debug('testContact: ' + testContact);

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
                testContact.Id,
                jobApp.Id,
                user.Id
                );
        insert events;
        System.debug('Events: ' + events);
        Event insertedEvent = [SELECT Id, Subject, Interview_Type__c, Interview_Format__c, ActivityDate, StartDateTime, EndDateTime, WhoId, WhatId, OwnerId 
                                FROM Event WHERE Id = :events[0].Id];
        System.debug('Inserted Event: ' + insertedEvent);

        
        System.debug('Email invocations before test: ' + Limits.getEmailInvocations());
        Test.startTest();
        EventInterviewReminderSchedule scheduler = new EventInterviewReminderSchedule();
        scheduler.execute(null);
        Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();

        System.debug('Email invocations after test: ' + Limits.getEmailInvocations());
        
        // Assert that no email was sent
        System.assertEquals(0, invocations, 'Expected no email to be sent');

        //query for the event to ensure it was processed
        Event processedEvent = [SELECT Id FROM Event WHERE Id = :events[0].Id];
        System.assertNotEquals(null, processedEvent, 'Expected the event to be processed');
    }

    @IsTest
    static void EventInterviewReminderSchedule_multipleEventsTomorrow_multipleEmails() {
        User user = TestDataFactory.testUserDataCreation();

        System.debug('User: ' + user);
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(8000, 'Single');
        insert jobApp;
        System.debug('jobApp: ' + jobApp);

        Contact testContact = TestDataFactory.getContact(null,'Test','Contact',true);
        System.debug('testContact: ' + testContact);

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
                testContact.Id,
                jobApp.Id,
                user.Id
                );
        insert events;
        System.debug('Events: ' + events);
        Event insertedEvent = [SELECT Id, Subject, Interview_Type__c, Interview_Format__c, ActivityDate, StartDateTime, EndDateTime, WhoId, WhatId, OwnerId 
                                FROM Event WHERE Id = :events[0].Id];
        System.debug('Inserted Event: ' + insertedEvent);

        
        System.debug('Email invocations before test: ' + Limits.getEmailInvocations());
        Test.startTest();
        EventInterviewReminderSchedule scheduler = new EventInterviewReminderSchedule();
        scheduler.execute(null);
        Integer invocations = Limits.getEmailInvocations();
        Test.stopTest();

        System.debug('Email invocations after test: ' + Limits.getEmailInvocations());
        
        // Assert that getEmailInvocations only 1
        System.assertEquals(1, invocations, 'Expected five emails to be sent');

        //query for the Events
        List<Event> processedEvents = [SELECT Id FROM Event WHERE Id = :events AND ActivityDate = :activityDate];
        System.assertEquals(5, processedEvents.size(), 'Expected five events to be processed');
    }
}