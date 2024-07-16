/*
*********************************************************
Apex Trigger Name  : JobApplicationTrigger
Created Date       : July 2024
@description       : This trigger creates a new run sintance for the JobApplicationTriggerHandler using the run()
@author            : Steven Trumble
*********************************************************
*/

trigger JobApplicationTrigger on Job_Application__c (before insert, after insert, before update, after update) {
    new JobApplicationTriggerHandler().run();
}