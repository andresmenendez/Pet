/**
 * @author: andresmenendez
*/
@RestResource(urlMapping='/InsertORDER/*')
global with sharing class REST_INSERT_ORDER {
    
    
	@HttpPost
    global static void insertOrder(Order ordem){
        
        try{
            if(ordem != null){
                
                insert ordem;
                RestContext.response.responseBody = Blob.valueOf('Ordem inserida com sucesso.' );
            }
        }catch(Exception e){
            RestContext.response.responseBody = Blob.valueOf('Error: '+ e.getMessage());
        }
    }
}