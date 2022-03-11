/**
 * @author: andresmenendez
*/
@RestResource(urlMapping='/UpsertContract/*')
global with sharing class REST_UPSERT_ACC_CONTRACT {
    
	@HttpPost
    global static void upsertAccountContract(String ContaId){
        Contract contrato = [SELECT Id FROM Contract WHERE AccountId = :ContaId LIMIT 1];
        
        try{
            contrato.AccountId = ContaId;
            contrato.Status = 'Draft';
            contrato.StartDate = System.TODAY();
            contrato.ContractTerm = 5;
            
            upsert contrato;
            RestContext.response.responseBody = Blob.valueOf('Conta inserida ou atualizada com sucesso.' );
        }catch(Exception e){
            RestContext.response.responseBody = Blob.valueOf('Error: '+ e.getMessage());
        }
    }
}