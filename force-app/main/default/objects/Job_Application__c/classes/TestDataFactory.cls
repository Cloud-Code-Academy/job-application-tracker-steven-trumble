@isTest
public class TestDataFactory {
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