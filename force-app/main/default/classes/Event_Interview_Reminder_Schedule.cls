/**
 * @class Event_Interview_Reminder_Schedule
 * @description Scheduled Apex class to send email reminders for upcoming interviews.
 *              This class queries for interviews scheduled for the next day and sends
 *              reminder emails to the event owners.
 *
 * Input:
 * - When executed as a scheduled job, it takes no direct input.
 * - It queries Event objects for interviews scheduled for the next day.
 *
 * Output:
 * - Sends email reminders to event owners for each interview scheduled for the next day.
 * - Logs debug information about the execution process.
 * - Sends an error email if exceptions occur during execution.
 *
 * Usage:
 * To schedule this job to run daily at 9am:
 * System.schedule('Event_Interview_Reminder_Schedule', '0 0 9 * * ?', new Event_Interview_Reminder_Schedule());
 */

public with sharing class Event_Interview_Reminder_Schedule implements Schedulable{
        /**
     * @description Executes the scheduled job. Queries for tomorrow's interviews and sends reminders.
     * @param sc The SchedulableContext
     */
   public void execute(SchedulableContext sc){
        Date tomorrow = Date.today().addDays(1);
        
        List<Event> interviewsTomorrow = [
            SELECT Id, Subject, ActivityDate, OwnerId, Interview_Type__c, Interview_Format__c, Who.Name, What.Name 
            FROM Event
            WHERE (
                Subject like '%Interview%'
                OR Interview_Format__c != null
                OR Interview_Type__c != null
            )
            AND ActivityDate = :tomorrow
        ];
        if(!interviewsTomorrow.isEmpty()){
            //system.debug('interviewsTomorrow list not empty');
            emailInterviews(interviewsTomorrow);
        }
    }
    
    /**
     * @description Prepares and sends email reminders for the given list of interviews.
     * @param interviewsTomorrow List of Event objects representing tomorrow's interviews
     */
    private void emailInterviews(List<Event> interviewsTomorrow){
        Set<Id> ownerIds = new Set<Id>();
        for (Event interview : interviewsTomorrow){
            ownerIds.add(interview.OwnerId);
        }
        System.debug('Number of unique owners: ' + ownerIds.size());

        Map<Id, User> ownerMap = new Map<Id, User>([
            SELECT Id,Email
            FROM User
            WHERE Id = :ownerIds
        ]);
        System.debug('Number of users retrieved: ' + ownerMap.size());

        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();

        for(Event interview : interviewsTomorrow){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

            User owner = ownerMap.get(interview.OwnerId);
            email.setToAddresses(new List<String>{owner.Email});
            
            email.setSaveAsActivity(false);
            email.setSubject('Reminder: Interview tomorrow - ' + interview.Subject);

            String body = 'This is a reminder that you have an interview scheduled tomorrow! <br>';
            body += 'Subject: ' + interview.Subject + '<br>';
            body += 'Date: ' + interview.ActivityDate.format() + '<br>';
            body += 'Interview Type: ' + (interview.Interview_Type__c ?? '(not specified)') + '<br>';
            body += 'Interview Format: ' + (interview.Interview_Format__c ?? '(not specified)') + '<br>';
            body += 'Job Application: ' + (interview.What.Name ?? '(not specified)') + '<br>';
            body += 'Contact: ' + (interview.Who.Name ?? '(not specified)');
            
            email.setHtmlBody(body);
            emailMessages.add(email);
        }
        if(!emailMessages.isEmpty()){
            try{
                System.debug('Attempting to send ' + emailMessages.size() + ' emails');
                Messaging.SendEmailResult[] results = Messaging.sendEmail(emailMessages);
                for(Messaging.SendEmailResult result : results){
                    if(result.isSuccess()){
                        System.debug('Email sent successfully');
                    } else {
                        System.debug('Email send failed: ' + result.getErrors()[0].getMessage());
                    }
                }
            } catch (Exception e){
                System.debug('Error sending emails: ' + e.getMessage());
            }
        } else {
            System.debug('No email messages to send');
        }
    }   
}