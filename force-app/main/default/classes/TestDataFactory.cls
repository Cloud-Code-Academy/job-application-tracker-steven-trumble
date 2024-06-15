/*
*********************************************************
Apex Class Name    : TestDataFactory
Created Date       : July 2024
@description       : This test data factory can be used to simplify testing logic
@author            : Steven Trumble
*********************************************************
*/
@isTest
public class TestDataFactory {

/*
*********************************************************
@Method Name    : createJobApplicationsWithStatus
@author         : Steven Trumble
@description    : method to is used to create Job Application(s) with a specific Status__c
@param          : Integer - numJobApplications - number of job applications that need tasks created
                    String - status - the Job_Application__c.Status__c 
@return         : List of inserted Job Applications
********************************************************
*/    
    public static List<Job_Application__c> createJobApplicationsWithStatus(Integer numJobApplications, String status) {
        List<Job_Application__c> jobApplications = new List<Job_Application__c>();
        for (Integer i = 0; i < numJobApplications; i++){
            Job_Application__c jobApplication = new Job_Application__c(Status__c = status);
            jobApplications.add(jobApplication);
        }
        insert jobApplications;
        return jobApplications;
    }
}