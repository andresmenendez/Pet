/**
 * @author: andresmenendez
*/
@isTest
private class CheckOldOrdersDailyTest {
    
    //Expressão em Data, pois o teste é um job executes
    public static String DATE_EXP = '0 0 0 20 9 ? 2022';
    
    //Criando setup das info dos testes
    @testSetup
    static void setup() {
        Account acc = new Account(Name = 'Burlington Textiles Corp of State');
        insert acc;
        
        Contract contract = new Contract(
            Status = 'Draft', 
            StartDate = System.today(), 
            ContractTerm = 12, 
        	AccountId = acc.Id);
        insert contract;
        
        Date dataLimiteOrdersMod = System.today().addMonths(-4);
        List<Order> ordens = new List<Order>();
        for (Integer i = 0; i < 110; i++) {
            Order order = new Order(
                AccountId = acc.Id,
                ContractId = contract.Id,
                Status = 'Draft',
                EffectiveDate = dataLimiteOrdersMod
                );
            ordens.add(order);
        }
        insert ordens;
        
    }
    
    static testmethod void testScheduledJobCheckOldOrdersDaily() {
        //Lista configurada no setup
        List<Order> ordens = [SELECT Id FROM Order];
        
        // Get nos IDs da ordem a serem inseridos
        Map<Id, Order> orderMap = new Map<Id, Order>(ordens);
        List<Id> orderIds = new List<Id>(orderMap.keySet());
        
        //Inicio do teste
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest',
            DATE_EXP,
            new CheckOldOrdersDaily());
        
        Test.stopTest();
        
        //Checagem para verificar os limites setados na apexclass
        System.assert(ordens.size() == 10); 
    }
}