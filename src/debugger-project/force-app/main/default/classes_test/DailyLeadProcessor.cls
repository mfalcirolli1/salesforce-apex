public class DailyLeadProcessor implements Schedulable{
	
    public void execute(SchedulableContext ctx){
        
        List<Lead> leads = [SELECT Id, Name, LeadSource FROM Lead LIMIT 200];
        List<Lead> lstLead = new List<Lead>();
        
        for(Lead ld : leads){
            ld.LeadSource = 'Dreamforce';
            lstLead.add(ld);
        }
        
        if(lstLead.size() > 0)
        {
            update lstLead;
        }
    }
}