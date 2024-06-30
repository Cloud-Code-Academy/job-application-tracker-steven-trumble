/*
*********************************************************
Apex Class Name    : JobApplicationUtility
Created Date       : June 2024
@description       : This utility class handles logic needed for Job_Application__c automations
@author            : Steven Trumble
*********************************************************
*/

public with sharing class JobApplicationUtility {
    @TestVisible  private static Boolean throwTestException = false;
    @TestVisible  private static String lastExceptionMessage;
/*
*********************************************************
@Method Name    : createJobApplicationTasks
@author         : Steven Trumble
@description    : method to is used to create Tasks related to Job Applications depending on the Status__c
@param          : List of Job_Applicaiton__c records from trigger.new
@param throwTestException - boolen to throw test exception to test catch block
@param lastExceptionMessage - string to test catch block for any excpetions
@return         : New Tasks
********************************************************
*/
    public static void createJobApplicationTasks(List<Job_Application__c> jobApplications) {       
        //want different actions based on the different stages saved, applying, applied, interviewing, negotiating, accepted
        List<Task> tasksToInsert = new List<Task>();

        //loop through job applications
        for(Job_Application__c jobApplication : jobApplications){
            switch on jobApplication.Status__c {
                when  'Saved'{
                    tasksToInsert.add(createTask(jobApplication.Id, 'Check if the job description aligns with your interests and values', 1));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Review the highlighted skills to see if the role is a good fit', 1));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Research the company or role and mark your excitement level', 2));
                }
                when 'Applying'{
                    tasksToInsert.add(createTask(jobApplication.Id, 'Find and research someone who works at the company and add them as a contact', 1));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Set up an informational interview to learn more about the role/company', 2));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Identify potential referrals to help get your application on the top of the pile', 2));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Customize your work achievements using the job description keywords', 3));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Submit your application on the company website if possible', 5));
                }
                when 'Applied'{
                    tasksToInsert.add(createTask(jobApplication.Id, 'Reach out to the hiring manager or recruiter', 1));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Follow up on your application via email weekly', 1));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Continue identifying and saving similar job opportunities', 1));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Set up weekly networking calls to explore similar companies/roles', 1));
                }
                when 'Interviewing'{
                    tasksToInsert.add(createTask(jobApplication.Id, 'Prepare your blurb or “tell me about yourself” response', 0));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Practice answering behavioral interview questions', 0));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Research the company and your interviewers', 0));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Set up your virtual interview space and test your tech', 0));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Send thank you emails within 24 hours', 1));
                }
                when 'Negotiating'{
                    tasksToInsert.add(createTask(jobApplication.Id, 'Research your market value and know your numbers', 1));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Prepare your negotiation scripts', 1));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Evaluate your offer and decline or accept', 1));
                }
                when 'Accepted'{
                    tasksToInsert.add(createTask(jobApplication.Id, 'Plan your resignation if applicable', 3));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Take some time to relax and recharge', 7));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Prepare for your first day of onboarding', 1));
                }
                when 'Closed'{
                    tasksToInsert.add(createTask(jobApplication.Id, 'Send a follow-up email thanking the interviewer and asking for feedback', 1));
                    tasksToInsert.add(createTask(jobApplication.Id, 'Review your notes and reflect on areas of improvement', 1));
                }
                when else {
                    tasksToInsert.add(createTask(jobApplication.Id, 'Select a Status for this Job Application', 0));
                }
            }
        }
       if (!tasksToInsert.isEmpty()){
            try{
                if(Test.isRunningTest() && throwTestException){
                    throw new TestException('Forced exception for testing.');
                }
                insert tasksToInsert;
            } catch (DmlException dmlEx){
                for (Integer i=0; i < dmlEx.getNumDml(); i++){
                    System.debug('DML Operation ' + i + ' failed with status: ' + dmlEx.getDmlMessage(i));
                }
            } catch (Exception e){
                lastExceptionMessage = e.getMessage();
                System.debug(LoggingLevel.ERROR, 'Unexpected Error: ' + lastExceptionMessage);
            }
       }
    }
    /*
*********************************************************
@Method Name    : createTask
@description    : helper method to return tasks that can be inserted
********************************************************
*/
    private static Task createTask(Id jobAppId, String subject, Integer daysUntilDue){
        Task newTask = new Task();
        newTask.WhatId = jobAppId;
        newTask.Subject = subject;
        newTask.Status = 'Not Started';
        newTask.Priority = 'Normal';
        newTask.ActivityDate = system.today()+daysUntilDue;
        return newTask;
    }

    /*
*********************************************************
@Method Name    : setPrimaryContact
@author         : Steven Trumble
@description    : set the primary contact on the job application if the primary contact is null 
                and there is at least one related contact. Use the first contact available in the 
                Job_Application_Contact__c related list or the first contact related to the Company_Name__c (Account).
@param  List<Job_Application__c> jobApplications: List of Job_Application__c records from Trigger.new
@return         : contactId
********************************************************
*/
    public static void setPrimaryContact(List<Job_Application__c> jobApplications){
        try{
            if(Test.isRunningTest() && throwTestException){
            throw new TestException('Forced exception for testing.');
            }
            Set<Id> jobAppIds = new Set<Id>();
            Set<Id> accountIds = new Set<Id>();

            //collect job Applications and Account ids
            for(Job_Application__c jobApplication : jobApplications){
                if(jobApplication.Primary_Contact__c == null){
                    jobAppIds.add(jobApplication.Id);
                    
                    if(jobApplication.Company_Name__c != null){
                        accountIds.add(jobApplication.Company_Name__c);
                    }
                }
            }
            // Map to store the first created Job_Application_Contact__c for each Job_Application__c
            Map<Id, Id> jobAppContactMap = new Map<Id, Id>();
            // Query related Job_Application_Contact__c records
            List<Job_Application_Contact__c> jobAppContacts = [
                SELECT Job_Application__c, Contact__c
                FROM Job_Application_Contact__c
                WHERE Job_Application__c IN :jobAppIds
                ORDER BY CreatedDate ASC
            ];
        
            // Populate the map with the first created Job Application Contact for each Job_Application__c
            for (Job_Application_Contact__c jobAppContact : jobAppContacts) {
                if (!jobAppContactMap.containsKey(jobAppContact.Job_Application__c)) {
                    jobAppContactMap.put(jobAppContact.Job_Application__c, jobAppContact.Contact__c);
                }
            }

            // Map to store the first created contact for each Account
            Map<Id, Id> accountContactMap = new Map<Id, Id>();
            if (!accountIds.isEmpty()) {
                // Query related contacts for the accounts
                List<Contact> contacts = [
                    SELECT Id, AccountId
                    FROM Contact
                    WHERE AccountId IN :accountIds
                    ORDER BY CreatedDate ASC
                ];
                // Populate the map with the first created contact for each Account
                for (Contact contact : contacts) {
                    if (!accountContactMap.containsKey(contact.AccountId)) {
                        accountContactMap.put(contact.AccountId, contact.Id);
                    }
                }
            }
            // Set Primary_Contact__c for each job application if it is currently null
            for (Job_Application__c jobApplication : jobApplications) {
                if (jobApplication.Primary_Contact__c == null) {
                    // Check if there's a related Job_Application_Contact__c record
                    Id contactId = jobAppContactMap.get(jobApplication.Id);
                    if (contactId != null) {
                        jobApplication.Primary_Contact__c = contactId;
                    } else if (jobApplication.Company_Name__c != null) {
                        // If no Job_Application_Contact__c record found, check related contacts for the account
                        contactId = accountContactMap.get(jobApplication.Company_Name__c);
                        if (contactId != null) {
                            jobApplication.Primary_Contact__c = contactId;
                        }
                    }
                }
            }
        } catch (QueryException qe) {
            lastExceptionMessage = qe.getMessage();
            System.debug(LoggingLevel.ERROR, 'Query Exception in setPrimaryContact: ' + lastExceptionMessage);
        } catch (NullPointerException npe) {
            lastExceptionMessage = npe.getMessage();
            System.debug(LoggingLevel.ERROR, 'Null Pointer Exception in setPrimaryContact: ' + lastExceptionMessage);
        } catch (Exception e) {
            lastExceptionMessage = e.getMessage();
            System.debug(LoggingLevel.ERROR, 'Unexpected Exception in setPrimaryContact: ' + lastExceptionMessage);
        }
    }
        /*
*********************************************************
Inner Class Name   : TestException
Created Date       : June 2024
@description       : inner exception class so can throw exception in testing
*********************************************************
*/
    public class TestException extends Exception{}
}