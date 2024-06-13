@isTest
private class DailyLeadProcessorTest {
	
    @testSetup
    static void setup() {
        List<Lead> leads = new List<Lead>();

        // insert 200 leads
        for (Integer i=0;i<200;i++) {
            leads.add(new Lead(FirstName='Lead'+ i, LastName='Test'+ i, Company='Company '+ i, LeadSource='TestSource'));
        }
        
        insert leads;
    }
    
    @isTest 
    static void TestList()
     {
         String cron = '0 0 0 15 3 ? 2042';
         
         Test.startTest();
         String jobId = System.schedule('ScheduledApexTest', cron, new DailyLeadProcessor());
         Test.stopTest();
         
         System.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);
      }
}