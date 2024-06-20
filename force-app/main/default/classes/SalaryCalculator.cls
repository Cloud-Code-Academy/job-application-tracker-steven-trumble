public with sharing class SalaryCalculator {
    public static void calculateTaxesAndTakeHomePay(List<Job_Application__c> jobAplications) {
        final Decimal  SOCIAL_SECURITY_RATE = 0.062;
        final Decimal  MEDICARE_WITHHOLDING_RATE = 0.0145;
        
        for(Job_Application__c jobApplication : jobAplications){
            Decimal salary = jobApplication.Salary__c;

            Decimal socialSecurityRate;
            if(jobApplication.Social_Security_Rate__c == null){
                socialSecurityRate = SOCIAL_SECURITY_RATE;
            } else {
                socialSecurityRate = jobApplication.Social_Security_Rate__c;
            }


            Decimal medicareWithholdingRate; 
            if(jobApplication.Medicare_Withholding_Rate__c == null){
                medicareWithholdingRate = MEDICARE_WITHHOLDING_RATE;
            } else {
                medicareWithholdingRate = jobApplication.Medicare_Withholding_Rate__c;
            }

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
            





            Decimal totalWithholdings = socialSecurityWithholding + medicareWithholding + federalIncomeTax;
            Decimal annualTakeHomePay = salary - totalWithholdings;
            Decimal monthlyTakeHomePay = annualTakeHomePay/12;

            jobApplication.Social_Security__c = socialSecurityWithholding;
            jobApplication.Medicare_Withholding__c = medicareWithholding;
            jobApplication.Federal_Income_Tax__c = federalIncomeTax;
            jobApplication.Annual_Take_Home_Pay__c = annualTakeHomePay;
            jobApplication.Monthly_Take_Home_Pay__c = monthlyTakeHomePay;
        }
    }

    private static Decimal calculateFederalIncomeTaxSingle(Decimal salary){
        Decimal federalIncomeTax = 0;
        //different tax rates based on income https://www.nerdwallet.com/taxes/tax-calculator#How%20this%20income%20tax%20calculator%20works
        
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
    }

    private static Decimal calculateFederalIncomeTaxMarriedJointly(Decimal salary){
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
    }

    private static Decimal calculateFederalIncomeTaxMarriedSeparately(Decimal salary){
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
    }

    private static Decimal calculateFederalIncomeTaxHeadOfHousehold(Decimal salary){
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
    }
}