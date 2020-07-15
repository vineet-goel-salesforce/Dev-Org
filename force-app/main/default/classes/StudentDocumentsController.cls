public with sharing class StudentDocumentsController { 

    private StudentDocumentContinuation stdDocContinuation;
    public string res;
    public void documentCallAll(){
            
            
            try{
                
                stdDocContinuation = new StudentDocumentContinuation();
                
                res = stdDocContinuation.sendRequestAndReceiveResponse();
                system.debug('---StudentDocumentsController.documentCallAll---StudentDocumentsInfoLst---: ' + res);
                
            } catch (exception excp){
                system.debug('---StudentDocumentsController.documentCallAll---excp---: ' + excp);
            }
        }
}