/*
*********************************************************
Apex Class Name    : Job_Application_Trigger_Handler
Created Date       : July 2024
@description       : This trigger handler calls various methods in Job_Application_Utility based on the running context
@author            : Steven Trumble
*********************************************************
*/

public with sharing class Job_Application_Trigger_Handler extends TriggerHandler{
    public override void beforeInsert(){
        if(!isBypassed('beforeInsert')){
            Job_Application_Utility.setPrimaryContact(trigger.new);
        }
    }

    public override void beforeUpdate(){
        if(!isBypassed('beforeUpdate')){
            Job_Application_Utility.setPrimaryContact(trigger.new);
        }
    }
    
    public override void afterInsert(){
        if(!isBypassed('afterInsert')){
            Job_Application_Utility.createJobApplicationTasks(trigger.new);
        }
    }

    public override void afterUpdate(){
        if(!isBypassed('afterUpdate')){
            Job_Application_Utility.createJobApplicationTasks(trigger.new);
        }
    }
}