//Trigger that sends an e-mail once specific event occurs
trigger ExampleTrigger on Contact (before insert, after delete) {
	    if (Trigger.isInsert) {
        Integer recordCount = Trigger.New.size();
        // Call a utility method from another class
        EmailManager.sendMail('example_mail@gmail.com', 'Yooo Bruh.', 
                    recordCount + ' contact(s) were inserted.');
    }
    else if (Trigger.isDelete) {
        // Process after delete
        Integer recordCount = Trigger.Old.size() - Trigger.New.size();
        EmailManager.sendMail('example_mail@gmail.com', 'Yooo Bruh.', 
                    recordCount + ' contact(s) were deletato.');
    }
}
