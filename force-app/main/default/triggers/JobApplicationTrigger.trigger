/*
*********************************************************
Apex Trigger Name  : Job_Application_Trigger
Created Date       : July 2024
@description       : This trigger creates a new run sintance for the Job_Application_Trigger_Handler using the run()
@author            : Steven Trumble
*********************************************************
*/

trigger JobApplicationTrigger on Job_Application__c (before insert, after insert, before update, after update) {
    new Job_Application_Trigger_Handler().run();
}