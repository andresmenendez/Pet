/**
 * @author: andresmenendez
*/
public class emailUtility {
    public static void enviarEmailConta(String emailAcc){
        //Inicializando a isntancia do Messaging.SingleEmailMessage 
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        //Atribuindo o email recebido no parametro ao array de enderecos 
        String [] enderecos = new String [] {emailAcc};
        
        //Criando e atribuindo valores ao objeto referente ao envio do email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSubject('Nova Atividade de Conta Salesforce');
        mail.setPlainTextBody('Uma nova conta relacionada a você foi inserida ou modificada dentro do Salesforce.');
        mail.setToAddresses(enderecos);
        mailList.add(mail);
        //Metodo que envia de fato, o email para a lista de emails,
        //que neste caso é somente um, porém, deixamos gernérico para futuras implementações
        Messaging.sendEmail(mailList);
    }
}