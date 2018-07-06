trigger ClosedOpportunityTrigger on Opportunity (before insert, before update) {
  List<Task> lsTasks = new List<Task>();
  for(Opportunity opp:Trigger.new) if(opp.stagename=='Closed Won') lsTasks.add(new Task(subject='Follow Up Test Task', whatid=opp.id));
  insert lsTasks;
}