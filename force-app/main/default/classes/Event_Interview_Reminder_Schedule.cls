public with sharing class Event_Interview_Reminder_Schedule implements Schedulable{
   public void execute(SchedulableContext sc){
    Date tomorrow = Date.today().addDays(1);
    List<Event> interviewsTomorrow = [
        SELECT Id, Subject, ActivityDate, OwnerId, Interview_Type__c, Interview_Format__c
        FROM Event
        WHERE (
            Subject like '%Interview%'
            OR Interview_Format__c != null
            OR Interview_Type__c != null
        )
        AND ActivityDate = :tomorrow
    ];
    if(!interviewsTomorrow.isEmpty()){
        emailInterviews(interviewsTomorrow);
       }
    }

    private void emailInterviews(List<Event> interviewsTomorrow){

    }

   
}