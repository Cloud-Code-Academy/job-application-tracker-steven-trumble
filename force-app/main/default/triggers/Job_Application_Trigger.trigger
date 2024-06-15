trigger Job_Application_Trigger on Job_Application__c (before insert, after insert, before update, after update) {
    new Job_Application_Trigger_Handler().run();
}