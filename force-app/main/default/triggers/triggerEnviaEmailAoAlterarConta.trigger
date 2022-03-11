trigger triggerEnviaEmailAoAlterarConta on Account (after insert, after update) {
    
    if(Trigger.isAfter){
              if(Trigger.isUpdate || Trigger.isInsert){
                     if(Trigger.new[0].Enviar_email_conta__c == true & Trigger.new[0].Contact__c != null){
                        String contatoSetId = Trigger.new[0].Contact__c;
                        Contact contatoSetado = [Select Id, Email From Contact Where Id =: contatoSetId LIMIT 1 ];
                        emailUtility.enviarEmailConta(contatoSetado.Email);
                    }
              }
      }
}