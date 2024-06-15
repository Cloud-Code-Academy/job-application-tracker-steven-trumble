public with sharing class Job_Application_Utility {
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
            insert tasksToInsert;
            }
        
    }
    //helper method to create tasks
    private static Task createTask(Id jobAppId, String subject, Integer daysUntilDue){
        Task newTask = new Task();
        newTask.WhatId = jobAppId;
        newTask.Subject = subject;
        newTask.Status = 'Not Started';
        newTask.Priority = 'Normal';
        newTask.ActivityDate = system.today()+daysUntilDue;
        return newTask;
    }
}