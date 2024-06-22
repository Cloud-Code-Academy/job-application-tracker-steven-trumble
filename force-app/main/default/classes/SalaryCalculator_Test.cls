@isTest
private class SalaryCalculator_Test {

    @isTest
    static void calculateTaxesAndTakeHomePay_singleFiler_correctCalculations1stBracket() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(8000, 'Single');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        System.assertEquals(800,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(6588,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_singleFiler_correctCalculations2ndBracket() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(15000, 'Single');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        System.assertEquals(1580,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(12272,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_singleFiler_correctCalculations3rdBracket() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(55000, 'Single');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        System.assertEquals(7407,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(43385,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_singleFiler_correctCalculations4thBracket() {
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
        
        System.assertEquals(17400,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(74950,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_singleFiler_correctCalculations5thBracket() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(190000, 'Single');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        System.assertEquals(39656,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(135809,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_singleFiler_correctCalculations6thBracket() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(250000, 'Single');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        System.assertEquals(59380,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(171494,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_singleFiler_correctCalculations7thBracket() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(750000, 'Single');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        System.assertEquals(237832,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(454792,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_marriedFilingJointly_correctCalculations1stBracket() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(20000, 'Married Filing Jointly');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        System.assertEquals(2000,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(16470,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }
    @isTest
    static void calculateTaxesAndTakeHomePay_marriedFilingJointly_correctCalculations3rdBracket() {
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
        
        System.assertEquals(23615,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(114910,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }
    @isTest
    static void calculateTaxesAndTakeHomePay_marriedFilingJointly_correctCalculations5thBracket() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(380000, 'Married Filing Jointly');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        System.assertEquals(79284,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(271646,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_marriedFilingJointly_correctCalculations7thBracket() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(700000, 'Married Filing Jointly');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        System.assertEquals(188914,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(457536,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_marriedFilingSeparately_correctCalculations1stBracket() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(6000, 'Married Filing Separately');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        System.assertEquals(600,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(4941,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_marriedFilingSeparately_correctCalculations3rdBracket() {
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
        
        System.assertEquals(11807,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(57455,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_marriedFilingSeparately_correctCalculations6thBracket() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(345000, 'Married Filing Separately');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        System.assertEquals(92630,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(225977,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_marriedFilingSeparately_correctCalculations7thBracket() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(347000, 'Married Filing Separately');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        System.assertEquals(93420,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(227034,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_headOfHousehold_correctCalculations2ndBracket() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(16000, 'Head of Household');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        System.assertEquals(1606,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(13170,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_headOfHousehold_correctCalculations4thBracket() {
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
        
        System.assertEquals(20554,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(90266,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_headOfHousehold_correctCalculations6thBracket() {
        Job_Application__c jobApp = TestDataFactory.createJobApplicationSalary(250000, 'Head of Household');
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert the results
        System.assertNotEquals(null, jobApp.Federal_Income_Tax__c);
        System.assertNotEquals(null, jobApp.Social_Security__c);
        System.assertNotEquals(null, jobApp.Medicare_Withholding__c);
        System.assertNotEquals(null, jobApp.Annual_Take_Home_Pay__c);
        System.assertNotEquals(null, jobApp.Monthly_Take_Home_Pay__c);
        
        System.assertEquals(58388,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(172486,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
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
        
        System.assertEquals(17400,  jobApp.Federal_Income_Tax__c.round(), 'Federal Income Tax calculation is incorrect');
        System.assertEquals(74500,  jobApp.Annual_Take_Home_Pay__c.round(), 'Annual Take-Home Pay calculation is incorrect');
    }

    @isTest
    static void calculateTaxesAndTakeHomePay_bulkCalculation_allRecordsProcessed() {
        List<Job_Application__c> jobApps = TestDataFactory.createMultipleJobApplicationSalaries(10);
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(jobApps);
        Test.stopTest();
        
        // Assert the results for each job application
        for(Integer i = 0; i < jobApps.size(); i++) {
            Job_Application__c jobApp = jobApps[i];
            Decimal salary = 50000 + (i * 10000);
            
            // Calculate expected values
            Decimal expectedSocialSecurity = salary * 0.062;
            Decimal expectedMedicare = salary * 0.0145;
            
            // Assert Social Security and Medicare calculations
            System.assertEquals(expectedSocialSecurity, jobApp.Social_Security__c, 'Social Security calculation is incorrect for salary: ' + salary);
            System.assertEquals(expectedMedicare, jobApp.Medicare_Withholding__c, 'Medicare Withholding calculation is incorrect for salary: ' + salary);
            
            // Assert Federal Income Tax - cannot know exact number due to random filing status
            System.assertNotEquals(null, jobApp.Federal_Income_Tax__c,'Federal Income Tax should not be null for salary: ' + salary);
            System.assert(jobApp.Federal_Income_Tax__c > 0, 'Federal Income Tax should be greater than 0 for salary: ' + salary);
            
            // Assert Take Home Pay calculations
            Decimal expectedAnnualTakeHomePay = salary - (jobApp.Federal_Income_Tax__c + expectedSocialSecurity + expectedMedicare);
            System.assertEquals(expectedAnnualTakeHomePay, jobApp.Annual_Take_Home_Pay__c, 'Annual Take Home Pay calculation is incorrect for salary: ' + salary);
            System.assertEquals(expectedAnnualTakeHomePay / 12, jobApp.Monthly_Take_Home_Pay__c, 'Monthly Take Home Pay calculation is incorrect for salary: ' + salary);
            
            // Additional assertions
            System.assert(jobApp.Annual_Take_Home_Pay__c < salary, 'Annual Take Home Pay should be less than salary for salary: ' + salary);
            System.assert(jobApp.Federal_Income_Tax__c + expectedSocialSecurity + expectedMedicare < salary, 'Total deductions should be less than salary for salary: ' + salary);
            
            // Check that Federal Income Tax is within a reasonable range (e.g., between 10% and 37% of salary)
            System.assert(jobApp.Federal_Income_Tax__c >= salary * 0.10 && jobApp.Federal_Income_Tax__c <= salary * 0.37, 'Federal Income Tax should be between 10% and 37% of salary for salary: ' + salary);
        }
    }


    @isTest
    static void calculateTaxesAndTakeHomePay_nullSalary_noCalculationsPerformed() {
        // Create a job application with null salary
        Job_Application__c jobApp = new Job_Application__c(
            Salary__c = null,
            Filing_Status__c = 'Single'
        );
        
        Test.startTest();
        SalaryCalculator.calculateTaxesAndTakeHomePay(new List<Job_Application__c>{jobApp});
        Test.stopTest();
        
        // Assert that no calculations were performed
        System.assertEquals(null, jobApp.Federal_Income_Tax__c, 
            'Federal Income Tax should be null for null salary');
        System.assertEquals(null, jobApp.Social_Security__c, 
            'Social Security should be null for null salary');
        System.assertEquals(null, jobApp.Medicare_Withholding__c, 
            'Medicare Withholding should be null for null salary');
        System.assertEquals(null, jobApp.Annual_Take_Home_Pay__c, 
            'Annual Take Home Pay should be null for null salary');
        System.assertEquals(null, jobApp.Monthly_Take_Home_Pay__c, 
            'Monthly Take Home Pay should be null for null salary');
    }
}