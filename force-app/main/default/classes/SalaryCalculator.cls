/*
*********************************************************
Apex Class Name    : SalaryCalculator
Created Date       : June 2024
@description       : This utility class handles logic needed for tax calculations on Job_Application__c based off of Salary__c
@author            : Steven Trumble
@param throwTestException - boolen to throw test exception to test catch block
@param lastExceptionMessage - string to test catch block for any excpetions
*********************************************************
*/

public with sharing class SalaryCalculator {
    @TestVisible  private static Boolean throwTestException = false;
    @TestVisible  private static String lastExceptionMessage;

    /*
*********************************************************
@Method Name    : calculateTaxesAndTakeHomePay
@author         : Steven Trumble
@description    : method to is used to calculate take home pay and amount of taxes paid
@param          : List of Job_Applicaiton__c records from trigger.new
@return         : jobApplication.Social_Security__c                
                jobApplication.Medicare_Withholding__c 
                jobApplication.Federal_Income_Tax__c
                jobApplication.Annual_Take_Home_Pay__c 
                jobApplication.Monthly_Take_Home_Pay__c
********************************************************
*/
    public static void calculateTaxesAndTakeHomePay(List<Job_Application__c> jobAplications) {
        //set default constants for Social_Security_Rate__c and Medicare_Withholding_Rate__c based on 2024 figures in case not provided in record
        final Decimal  SOCIAL_SECURITY_RATE = 0.062;
        final Decimal  MEDICARE_WITHHOLDING_RATE = 0.0145;
        
        for(Job_Application__c jobApplication : jobAplications){
            try{ 
                if(Test.isRunningTest() && throwTestException){
                    throw new TestException('Forced exception for testing.');
                }
                if (jobApplication.Salary__c == null) {
                    // Skip calculations for null salaries
                    continue;
                }
                Decimal salary = jobApplication.Salary__c;
                Decimal socialSecurityRate = jobApplication.Social_Security_Rate__c != null ? jobApplication.Social_Security_Rate__c :  SOCIAL_SECURITY_RATE;
                
                Decimal medicareWithholdingRate = jobApplication.Medicare_Withholding_Rate__c != null ? jobApplication.Medicare_Withholding_Rate__c : MEDICARE_WITHHOLDING_RATE;

                Decimal socialSecurityWithholding = salary * (socialSecurityRate / 100);
                Decimal medicareWithholding = salary * (medicareWithholdingRate / 100);
                
                Decimal federalIncomeTax;
                switch on jobApplication.Filing_Status__c {
                    when  'Single', null{
                        federalIncomeTax = calculateFederalIncomeTaxSingle(salary);        
                    }
                    when 'Married Filing Jointly'{
                        federalIncomeTax = calculateFederalIncomeTaxMarriedJointly(salary);
                    }
                    when 'Married Filing Separately'{
                        federalIncomeTax = calculateFederalIncomeTaxMarriedSeparately(salary);
                    }
                    when 'Head of Household' {
                        federalIncomeTax = calculateFederalIncomeTaxHeadOfHousehold(salary);
                    }
                }
                //calculate values
                Decimal totalWithholdings = socialSecurityWithholding + medicareWithholding + federalIncomeTax;
                Decimal annualTakeHomePay = salary - totalWithholdings;
                Decimal monthlyTakeHomePay = annualTakeHomePay/12;

                //set values
                jobApplication.Social_Security__c = socialSecurityWithholding;
                jobApplication.Medicare_Withholding__c = medicareWithholding;
                jobApplication.Federal_Income_Tax__c = federalIncomeTax;
                jobApplication.Annual_Take_Home_Pay__c = annualTakeHomePay;
                jobApplication.Monthly_Take_Home_Pay__c = monthlyTakeHomePay;
                
            } catch (Exception e){
                lastExceptionMessage = e.getMessage();
                System.debug(LoggingLevel.ERROR, 'Unexpected Error: ' + lastExceptionMessage);
            }
        }    
    }

    /*
*********************************************************
@Method Name    : calculateFederalIncomeTaxSingle
@description    : Calculate Federal Income tax for Filing Status = Single
@param          : Decimal salary
@return         : Decimal federalIncomeTax

Note: different tax rates based on income https://www.nerdwallet.com/taxes/tax-calculator#How%20this%20income%20tax%20calculator%20works
********************************************************
*/

    private static Decimal calculateFederalIncomeTaxSingle(Decimal salary){
        try{
            Decimal federalIncomeTax = 0;
            //Single
            if (salary <= 11000) {
                federalIncomeTax = salary * 0.10;
            } else if (salary <= 44725) {
                federalIncomeTax = 1100 + (salary - 11000) * 0.12;
            } else if (salary <= 95375) {
                federalIncomeTax = 5146.80 + (salary - 44725) * 0.22;
            } else if (salary <= 182100) {
                federalIncomeTax = 16290.08 + (salary - 95375) * 0.24;
            } else if (salary <= 231250) {
                federalIncomeTax = 37128 + (salary - 182100) * 0.32;
            } else if (salary <= 578125) {
                federalIncomeTax = 52818 + (salary - 231250) * 0.35;
            } else {
                federalIncomeTax = 174238.75 + (salary - 578125) * 0.37;
            }

            return federalIncomeTax;
        } catch (Exception e){
            System.debug('Error calculating federal income tax for single filing status: ' + e.getMessage());
            return 0;
        }
    }
    /*
*********************************************************
@Method Name    : calculateFederalIncomeTaxSingle
@description    : Calculate Federal Income tax for Filing Status = Married Filing Jointly
@param          : Decimal salary
@return         : Decimal federalIncomeTax
********************************************************
*/
    private static Decimal calculateFederalIncomeTaxMarriedJointly(Decimal salary){
        try{
            Decimal federalIncomeTax = 0;

            if (salary <= 22000) {
                federalIncomeTax = salary * 0.10;
            } else if (salary <= 89450) {
                federalIncomeTax = 2200 + (salary - 22000) * 0.12;
            } else if (salary <= 190750) {
                federalIncomeTax = 10294 + (salary - 89450) * 0.22;
            } else if (salary <= 364200) {
                federalIncomeTax = 32714 + (salary - 190750) * 0.24;
            } else if (salary <= 462500) {
                federalIncomeTax = 74228 + (salary - 364200) * 0.32;
            } else if (salary <= 693750) {
                federalIncomeTax = 105664 + (salary - 462500) * 0.35;
            } else {
                federalIncomeTax = 186601.25 + (salary - 693750) * 0.37;
            }

            return federalIncomeTax;
        } catch (Exception e){
            System.debug('Error calculating federal income tax for Married filing Jointly status: ' + e.getMessage());
            return 0;
        }
    }
    /*
*********************************************************
@Method Name    : calculateFederalIncomeTaxSingle
@description    : Calculate Federal Income tax for Filing Status = Married Filing Seperately
@param          : Decimal salary
@return         : Decimal federalIncomeTax
********************************************************
*/
    private static Decimal calculateFederalIncomeTaxMarriedSeparately(Decimal salary){
        try{
            Decimal federalIncomeTax = 0;

            if (salary <= 11000) {
                federalIncomeTax = salary * 0.10;
            } else if (salary <= 44725) {
                federalIncomeTax = 1100 + (salary - 11000) * 0.12;
            } else if (salary <= 95375) {
                federalIncomeTax = 5146.80 + (salary - 44725) * 0.22;
            } else if (salary <= 182100) {
                federalIncomeTax = 16290.08 + (salary - 95375) * 0.24;
            } else if (salary <= 231250) {
                federalIncomeTax = 37128 + (salary - 182100) * 0.32;
            } else if (salary <= 346875) {
                federalIncomeTax = 52818 + (salary - 231250) * 0.35;
            } else {
                federalIncomeTax = 93373.75 + (salary - 346875) * 0.37;
            }
            
            return federalIncomeTax;
        } catch (Exception e){
        System.debug('Error calculating federal income tax for Married filing Separately status: ' + e.getMessage());
        return 0;
        }
    }
    /*
*********************************************************
@Method Name    : calculateFederalIncomeTaxSingle
@description    : Calculate Federal Income tax for Filing Status = Head of Household
@param          : Decimal salary
@return         : Decimal federalIncomeTax
********************************************************
*/
    private static Decimal calculateFederalIncomeTaxHeadOfHousehold(Decimal salary){
        try{
        Decimal federalIncomeTax = 0;

        if (salary <= 15700) {
            federalIncomeTax = salary * 0.10;
        } else if (salary <= 59850) {
            federalIncomeTax = 1570 + (salary - 15700) * 0.12;
        } else if (salary <= 95350) {
            federalIncomeTax = 6862 + (salary - 59850) * 0.22;
        } else if (salary <= 182100) {
            federalIncomeTax = 14638 + (salary - 95350) * 0.24;
        } else if (salary <= 231250) {
            federalIncomeTax = 33498 + (salary - 182100) * 0.32;
        } else if (salary <= 578100) {
            federalIncomeTax = 51826 + (salary - 231250) * 0.35;
        } else {
            federalIncomeTax = 174238.75 + (salary - 578100) * 0.37;
        }
        
        return federalIncomeTax;
    } catch (Exception e){
        System.debug('Error calculating federal income tax for Married filing Separately status: ' + e.getMessage());
        return 0;
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