public with sharing class StudentDocumentContinuation{
        // Unique label corresponding to the continuation
        public String requestLabel;
        public string l{get;set;}
        public string Content = 'application/Json';
        

        public String sendRequestAndReceiveResponse(){
            String Long_URL = 'https://requestbin.io/x3c7nux3';
            startRequest(Long_URL);
            system.debug('l----'+l);
            return l;   
        }
        
        public Object startRequest(string url) {
                HttpRequest request = new HttpRequest();
                // Create continuation with a timeout
            Continuation con = new Continuation(60);
            // Set callback method
            con.continuationMethod='processResponse';

            request.setEndpoint(url);
            request.setMethod('GET');
            request.setHeader('Content-Type', Content);
            //request.setHeader('Content-Type', 'Application/Json');
            
            system.debug('---StudentDocumentContinuation.sendRequestAndReceiveResponse---request---'+request);
            this.requestLabel = con.addHttpRequest(request);
            system.debug('requestLabel---'+requestLabel);
            // Return the continuation
            return con;
        }
        
        // Callback method 
        public Object processResponse() {
            System.debug('StudentDocumentContinuation.processResponse');
            HttpResponse HttpResp = new HttpResponse();
             // Get the response by using the unique label
            HttpResp = Continuation.getResponse(this.requestLabel);
            
            system.debug('---StudentDocumentContinuation.sendRequestAndReceiveResponse---response---'+HttpResp);
            system.debug('---StudentDocumentContinuation.sendRequestAndReceiveResponse---response.Body---'+HttpResp.getBody());
                //Added for LeadSyncIntegration
                this.l = HttpResp.getBody();

           
            //system.debug('---StudentDocumentContinuation.sendRequestAndReceiveResponse---Time taken for call out ----- =' +totalTime);
            system.debug('---StudentDocumentContinuation.sendRequestAndReceiveResponse------'+l);   
            return null;
        }    
        
    }