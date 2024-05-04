public class MyQueueableClass implements Queueable {

    private List<Contact> contacts;

    // Constructor where is passed the list of contacts to process

    public MyQueueableClass(List<Contact> myContacts) {
        contacts = myContacts;
    }
    
    public void execute(QueueableContext context) {
        // Loop through the contacts passed
        for (Contact con:contacts) {
            // String response = anotherClass.calloutMethod(con.Id,
            //         con.FirstName,
            //         con.LastName,
            //         con.Email);
        }
    }
}

// public class ExecuteQueueClass{

//     public static void ExecuteQueueMethod(){
//         List<Contact> contacts = [SELECT Id, LastName, FirstName, Email FROM Contact WHERE Is_Active__c = true];
//         Id jobId = System.enqueueJob(new MyQueueableClass(contacts));
//     }
// }