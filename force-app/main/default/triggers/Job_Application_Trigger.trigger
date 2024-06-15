trigger Job_Application_Trigger on Job_Application__c (after insert, after update) {
    new Job_Application_Trigger_Handler().run();
}