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

             //only run when salary provided
             List<Job_Application__c> jobAppsWithSalary = new List<Job_Application__c>();
             for (Job_Application__c jobApp : (List<Job_Application__c>)trigger.new){
                 if(jobApp.Salary__c != null){
                     jobAppsWithSalary.add(jobApp);
                 }
             }
             if(!jobAppsWithSalary.isEmpty()){
                 SalaryCalculator.calculateTaxesAndTakeHomePay(jobAppsWithSalary);
             }
        }
    }

    public override void beforeUpdate(){
        if(!isBypassed('beforeUpdate')){
            Job_Application_Utility.setPrimaryContact(trigger.new);
            
            //only run when salary provided
            List<Job_Application__c> jobAppsWithSalary = new List<Job_Application__c>();
            for (Job_Application__c jobApp : (List<Job_Application__c>)trigger.new){
                if(jobApp.Salary__c != null){
                    jobAppsWithSalary.add(jobApp);
                }
            }
            if(!jobAppsWithSalary.isEmpty()){
                SalaryCalculator.calculateTaxesAndTakeHomePay(jobAppsWithSalary);
            }
        }
    }
    
    public override void afterInsert(){
        if(!isBypassed('afterInsert')){
            Job_Application_Utility.createJobApplicationTasks(trigger.new);
        }
    }

    public override void afterUpdate(){
        if(!isBypassed('afterUpdate')){
            //only run when Status__c is updated
            List<Job_Application__c> jobAppsChangedStatus = new List<Job_Application__c>();
            for (Id recordId : trigger.newMap.keyset()){
                Job_Application__c newRecord = (Job_Application__c)trigger.newMap.get(recordId);
                Job_Application__c oldRecord = (Job_Application__c)trigger.oldMap.get(recordId);
                if(newRecord.Status__c != oldRecord.Status__c){
                    jobAppsChangedStatus.add(newRecord);
                }
            }
            if(!jobAppsChangedStatus.isEmpty()){
                Job_Application_Utility.createJobApplicationTasks(trigger.new);
            }
        }
    }
}