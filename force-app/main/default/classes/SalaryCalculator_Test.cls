@isTest
private class SalaryCalculator_Test {

    @isTest
    static void calculateTaxesAndTakeHomePay_singleFiler_correctCalculations() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(100000, 'Single');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        // Add more specific assertions based on your expected values
        // For example:
        // System.assertEquals(18289.50, jobApp.Federal_Income_Tax__c, 'Federal Income Tax calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_marriedFilingJointly_correctCalculations() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(150000, 'Married Filing Jointly');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        // Add more specific assertions
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_marriedFilingSeparately_correctCalculations() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(75000, 'Married Filing Separately');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        // Add more specific assertions
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_headOfHousehold_correctCalculations() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(120000, 'Head of Household');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        // Add more specific assertions
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_customRates_correctCalculations() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(100000, 'Single');
        jobApp.Social_Security_Rate__c = 6.5;
        jobApp.Medicare_Withholding_Rate__c = 1.6;
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertEquals(6500, jobApp.Social_Security__c, 'Social Security calculation is incorrect');
        System.assertEquals(1600, jobApp.Medicare_Withholding__c, 'Medicare Withholding calculation is incorrect');
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        // Add more specific assertions
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_bulkCalculation_allRecordsProcessed() {
        List<Job_Application__c> jobApps = TestDataFactory.createMultipleJobApplicationSalaries(5);
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(jobApps);
        Test.stopTest();
        
        // Assert the results for each job application
        for(Job_Application__c jobApp : jobApps) {
            System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
            System.assertNotEquals(null, jobApp.Social_Security__c);
            System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
            System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
            System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        }
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_lowSalary_correctCalculations() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(10000, 'Single');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertEquals(1000, jobApp.Federal_Income_Tax__c, 'Federal Income Tax calculation is incorrect');
        System.assertEquals(620, jobApp.Social_Security__c, 'Social Security calculation is incorrect');
        System.assertEquals(145, jobApp.Medicare_Withholding__c, 'Medicare Withholding calculation is incorrect');
        System.assertEquals(8235, jobApp.Annual_Take_Home_Pay__c, 'Annual Take Home Pay calculation is incorrect');
        System.assertEquals(686.25, jobApp.Monthly_Take_Home_Pay__c, 'Monthly Take Home Pay calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_highSalary_correctCalculations() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(1000000, 'Married Filing Jointly');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertEquals(62000, jobApp.Social_Security__c, 'Social Security calculation is incorrect');
        System.assertEquals(14500, jobApp.Medicare_Withholding__c, 'Medicare Withholding calculation is incorrect');
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        // Add more specific assertions for high salary scenario
    }
}