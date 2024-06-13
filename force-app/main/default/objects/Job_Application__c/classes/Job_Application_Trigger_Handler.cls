public with sharing class Job_Application_Trigger_Handler extends TriggerHandler{
    public override void afterInsert(){
        Job_Application_Utility.createJobApplicationTasks(trigger.new);
    }
    public override void afterUpdate(){
        Job_Application_Utility.createJobApplicationTasks(trigger.new);
    }
}