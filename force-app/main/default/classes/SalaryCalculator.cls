public with sharing class SalaryCalculator {
    public static void calculateTaxesAndTakehHomePay(List<Job_Application__c> jobAplications) {
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
            Decimal federalIncomeTax = calculateFederalIncomeTax(salary);

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

    private static Decimal calculateFederalIncomeTax(Decimal salary){
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

    //let's build this out for diff filing statuses. separete method for each. add picklist for status
}