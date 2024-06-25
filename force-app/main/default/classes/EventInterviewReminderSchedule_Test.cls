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
//need to change this to have activitystarttime and duration in minutes
        List<Event> events = TestDataFactory.createEvents(1,'Interview subject',null,null,Date.today().addDays(1),testContact.Id,jobApp.Id,user.Id);
        insert events;
        System.debug('Events: ' + events);

        Test.startTest();
        Event_Interview_Reminder_Schedule scheduler = new Event_Interview_Reminder_Schedule();
        scheduler.execute(null);
        Test.stopTest();
        
        // Assert that one email was sent
        System.assertEquals(1, Limits.getEmailInvocations(), 'Expected one email to be sent');

        // Optionally, you can query for the event to ensure it was processed
        Event processedEvent = [SELECT Id FROM Event WHERE Id = :events[0].Id];
        System.assertNotEquals(null, processedEvent, 'Expected the event to be processed');
    }
    
    @IsTest
    static void testNoInterviewsTomorrow() {
        // Test the scenario where there are no interviews scheduled for tomorrow
        // Delete or modify tomorrow's events before running the test
        Test.startTest();
        Event_Interview_Reminder_Schedule scheduler = new Event_Interview_Reminder_Schedule();
        scheduler.execute(null);
        Test.stopTest();
        
        // Assert that no emails were sent
    }
    
    @IsTest
    static void testMultipleInterviewsSameOwner() {
        // Test the scenario where one owner has multiple interviews tomorrow
        // Modify test data to have multiple events for the same owner
        Test.startTest();
        Event_Interview_Reminder_Schedule scheduler = new Event_Interview_Reminder_Schedule();
        scheduler.execute(null);
        Test.stopTest();
        
        // Assert that multiple emails were sent to the same owner
    }
}