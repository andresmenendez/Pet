/**
 * @author: andresmenendez
*/
global class CheckOldOrdersDaily implements Schedulable {
    
    //Metodo execute, pois se trata de um Schedulable Job
    global void execute(SchedulableContext ctx) {
        //Setando a data para três meses antes da data atual
        Date dataLimiteOrdersMod = System.today().addMonths(-3);
        
        try{
            //Limitando a query em 100 registros por conta da ferramenta para esse tipo de class
            //ref: https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_scheduler.htm
            List<Order> listOrders = [SELECT Id, LastModifiedDate
                FROM Order
                WHERE LastModifiedDate >= :dataLimiteOrdersMod LIMIT 100];
            
            if(!listOrders.isEmpty()){
                delete listOrders;
            }
            
        }catch(Exception ex){
			//PERSISTIR FUTURAMENTE NA SOLUÇÃO DE LOG.
			//Criar classe de tratativa de erro
			System.debug('Erro no processamento. msg =>  ' + ex.getMessage() + ' - ' + ex.getStackTraceString()+ ' - ' + ex.getLineNumber() + ' - ' + ex.getCause());
		
        } 
    }
}