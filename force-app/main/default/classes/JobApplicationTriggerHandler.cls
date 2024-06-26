/*
*********************************************************
Apex Class Name    : JobApplicationTriggerHandler
Created Date       : June 2024
@description       : This trigger handler calls various methods in JobApplicationUtility and SalaryCalculator based on the running context.
@author            : Steven Trumble
*********************************************************
*/

public with sharing class JobApplicationTriggerHandler extends TriggerHandler {
    public override void beforeInsert() {
        if (!isBypassed('beforeInsert')) {
            JobApplicationUtility.setPrimaryContact(Trigger.new);
            List<Job_Application__c> jobAppsWithSalary = getJobAppsWithSalary(Trigger.new);
            if (!jobAppsWithSalary.isEmpty()) {
                SalaryCalculator.calculateTaxesAndTakeHomePay(jobAppsWithSalary);
            }
        }
    }

    public override void beforeUpdate() {
        if (!isBypassed('beforeUpdate')) {
            JobApplicationUtility.setPrimaryContact(Trigger.new);
            List<Job_Application__c> jobAppsWithSalary = getJobAppsWithSalary(Trigger.new);
            if (!jobAppsWithSalary.isEmpty()) {
                SalaryCalculator.calculateTaxesAndTakeHomePay(jobAppsWithSalary);
            }
        }
    }
    
    public override void afterInsert() {
        if (!isBypassed('afterInsert')) {
            JobApplicationUtility.createJobApplicationTasks(Trigger.new);
        }
    }

    public override void afterUpdate() {
        if (!isBypassed('afterUpdate')) {
            List<Job_Application__c> jobAppsChangedStatus = getJobAppsWithChangedStatus(Trigger.new, Trigger.oldMap);
            if (!jobAppsChangedStatus.isEmpty()) {
                JobApplicationUtility.createJobApplicationTasks(jobAppsChangedStatus);
            }
        }
    }

    /*
*********************************************************
@Method Name    : getJobAppsWithSalary
@author         : Steven Trumble
@description    : method to is used to find which Job Applications should enter the SalaryCalculator.calculateTaxesAndTakeHomePay method.
@param          : List of Job_Application__c records from trigger.new
@return         : List of Job_Application__c records that have a value in Salary__c
********************************************************
*/
    private List<Job_Application__c> getJobAppsWithSalary(List<Job_Application__c> jobApps) {
        List<Job_Application__c> jobAppsWithSalary = new List<Job_Application__c>();
        for (Job_Application__c jobApp : jobApps) {
            if (jobApp.Salary__c != null) {
                jobAppsWithSalary.add(jobApp);
            }
        }
        return jobAppsWithSalary;
    }
    /*
*********************************************************
@Method Name    : getJobAppsWithChangedStatus
@author         : Steven Trumble
@description    : method to is used to find which Job Applications should enter the SalaryCalculator.calculateTaxesAndTakeHomePay method.
@param          : List<SObject> newSObjects - Trigger.new
@param          : Map<Id, SObject> oldSObjectsMap - Trigger.oldMap
@return         : List of Job_Application__c records that have a changed Status__c
********************************************************
*/
    private List<Job_Application__c> getJobAppsWithChangedStatus(List<SObject> newSObjects, Map<Id, SObject> oldSObjectsMap) {
        List<Job_Application__c> jobAppsChangedStatus = new List<Job_Application__c>();
        for (SObject newSObj : newSObjects) {
            Job_Application__c newJobApp = (Job_Application__c)newSObj;
            Job_Application__c oldJobApp = (Job_Application__c)oldSObjectsMap.get(newJobApp.Id);
            if (newJobApp.Status__c != oldJobApp.Status__c) {
                jobAppsChangedStatus.add(newJobApp);
            }
        }
        return jobAppsChangedStatus;
    }
}