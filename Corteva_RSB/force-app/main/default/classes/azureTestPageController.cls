public class azureTestPageController {

    public String receiveFromAzureResult {get;set;}
    public String sendToAzureResult {get;set;}
    public String accessTokenResult {get;set;}
    public String accessToken {get;set;}
    public Integer messageCountResult {get;set;}

    public String accessTokenResult2 {get;set;}
    public String accessToken2 {get;set;}
    public Integer messageCountResult2 {get;set;}
    public Integer activeMessageCountResult2 {get;set;}

    public azureTestPageController() {

    }

    public void sendToAzure(){

        getAccessToken();

        Http sendToAzureH = new Http();
        HttpRequest sendToAzureReq = new HttpRequest();
        
        String sendToAzureUrl = 'https://wstest-service-bus.servicebus.windows.net/wstest-queue-receive/messages';
        
        sendToAzureReq.setEndpoint(sendToAzureUrl);
        sendToAzureReq.setMethod('POST');
        sendToAzureReq.setHeader('Content-Type','application/json');
        sendToAzureReq.setHeader('Authorization','Bearer ' + accessToken);
        sendToAzureReq.setBody('{"ContractId":"111","Name":"Test Contract2","Amount":22222}');
        
        HttpResponse sendToAzureResp = sendToAzureH.send(sendToAzureReq);
        sendToAzureResult = sendToAzureResp.getBody() + sendToAzureResp.getStatusCode();
    }

    public void receiveFromAzure(){
        Http receiveFromAzureH = new Http();
        HttpRequest receiveFromAzureReq = new HttpRequest();
        
        String receiveFromAzureUrl = 'https://wstest-service-bus.servicebus.windows.net/wstest-queue-receive/messages/head';
        
        receiveFromAzureReq.setEndpoint(receiveFromAzureUrl);
        receiveFromAzureReq.setMethod('DELETE');
        receiveFromAzureReq.setHeader('Authorization','Bearer ' + accessToken);
        
        
        HttpResponse receiveFromAzureResp = receiveFromAzureH.send(receiveFromAzureReq);
        receiveFromAzureResult = receiveFromAzureResp.getBody();
    }

    public void getAccessToken(){
        Http accessTokenH = new Http();
        HttpRequest accessTokenReq = new HttpRequest();
        
        String accessTokenUrl = 'https://login.microsoftonline.com/3e20ecb2-9cb0-4df1-ad7b-914e31dcdda4/oauth2/token';
        
        accessTokenReq.setEndpoint(accessTokenUrl);
        accessTokenReq.setMethod('GET');
        accessTokenReq.setHeader('Content-Type','application/x-www-form-urlencoded');
        accessTokenReq.setHeader('Content-Type','multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW');
        
        accessTokenReq.setBody(
            '------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"grant_type\"\r\n\r\n' + 'client_credentials' + '\r\n' +
            '------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"client_id\"\r\n\r\n' + 'db1387a7-dc1a-4eff-96df-a6038a3f582f' + '\r\n' +
            '------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"client_secret\"\r\n\r\n' + 'tv47Q~nibtlR5jAUHrFEl1xlTCI3Mx89bSoU7' + '\r\n' +
            '------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"resource\"\r\n\r\n' + 'https://servicebus.azure.net' + '\r\n' + 
            '------WebKitFormBoundary7MA4YWxkTrZu0gW--'
        );
        
        HttpResponse accessTokenResp = accessTokenH.send(accessTokenReq);
        accessTokenResult = accessTokenResp.getBody();

        System.debug('es debug accessTokenResult' + accessTokenResult);

        AccessTokenData accessTokenData = (AccessTokenData)JSON.deserialize(accessTokenResp.getBody(), AccessTokenData.class);

        accessToken = accessTokenData.access_token;
    }

    public class AccessTokenData{
        public String access_token {get;set;}
    }

    public void getMessageCount(){
        Http messageCountH = new Http();
        HttpRequest messageCountReq = new HttpRequest();
        
        String messageCountUrl = 'https://wstest-service-bus.servicebus.windows.net/wsqueue';
        
        messageCountReq.setEndpoint(messageCountUrl);
        messageCountReq.setMethod('GET');
        messageCountReq.setHeader('Content-Type','application/json');
        messageCountReq.setHeader('Authorization','Bearer ' + accessToken);
        
        HttpResponse messageCountResp = messageCountH.send(messageCountReq);
        messageCountResult = Integer.valueOf(messageCountResp.getBody().substringBetween('<MessageCount>', '</MessageCount>'));
    }

    public void getAccessToken2(){
        Http accessTokenH = new Http();
        HttpRequest accessTokenReq = new HttpRequest();
        
        String accessTokenUrl = 'https://login.microsoftonline.com/3e20ecb2-9cb0-4df1-ad7b-914e31dcdda4/oauth2/token';
        
        accessTokenReq.setEndpoint(accessTokenUrl);
        accessTokenReq.setMethod('GET');
        accessTokenReq.setHeader('Content-Type','application/x-www-form-urlencoded');
        accessTokenReq.setHeader('Content-Type','multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW');
        //accessTokenReq.setBody('{"grant_type":"client_credentials","client_id":"23b4007b-adc2-4597-9209-cc1666b1f440","client_secret":"2G-_Jw96Cd6VSU~z7-yTA.f_3Ehy1fd_G1","resource":"https://servicebus.azure.net"}');
        accessTokenReq.setBody(
            '------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"grant_type\"\r\n\r\n' + 'client_credentials' + '\r\n' +
            '------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"client_id\"\r\n\r\n' + '23b4007b-adc2-4597-9209-cc1666b1f440' + '\r\n' +
            '------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"client_secret\"\r\n\r\n' + '2G-_Jw96Cd6VSU~z7-yTA.f_3Ehy1fd_G1' + '\r\n' +
            '------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"resource\"\r\n\r\n' + 'https://management.azure.com' + '\r\n' + 
            '------WebKitFormBoundary7MA4YWxkTrZu0gW--'
        );
        
        HttpResponse accessTokenResp = accessTokenH.send(accessTokenReq);
        accessTokenResult2 = accessTokenResp.getBody();

        System.debug('es debug accessTokenResult' + accessTokenResult2);

        AccessTokenData accessTokenData = (AccessTokenData)JSON.deserialize(accessTokenResp.getBody(), AccessTokenData.class);

        accessToken2 = accessTokenData.access_token;
    }

    public void getMessageCount2(){
        Http messageCountH = new Http();
        HttpRequest messageCountReq = new HttpRequest();
        
        String messageCountUrl = 'https://management.azure.com/subscriptions/359777ae-8362-4a41-836f-a5c736c61c77/resourceGroups/AzureResourceGroup1/providers/Microsoft.ServiceBus/namespaces/AZUREWST1/queues/wsqueue?api-version=2017-04-01';
        
        messageCountReq.setEndpoint(messageCountUrl);
        messageCountReq.setMethod('GET');
        messageCountReq.setHeader('Content-Type','application/json');
        messageCountReq.setHeader('Authorization','Bearer ' + accessToken2);
        
        HttpResponse messageCountResp = messageCountH.send(messageCountReq);
        
        QueueData queueuDetails = (QueueData)JSON.deserialize(messageCountResp.getBody(), QueueData.class);
        System.debug('es debug getMessageCount2 ' + messageCountResp.getBody());
        System.debug('es debug queueuDetails ' + queueuDetails);
        messageCountResult2 = queueuDetails.properties.messageCount;
        activeMessageCountResult2 = queueuDetails.properties.countDetails.activeMessageCount;
    }


    public class QueueData{
        public PropertiesData properties {get;set;}
    }

    public class PropertiesData{
        public CountDetailsData countDetails {get;set;}
        public Integer messageCount {get;set;}
    }

    public class CountDetailsData{
        public Integer activeMessageCount {get;set;}
    }
}