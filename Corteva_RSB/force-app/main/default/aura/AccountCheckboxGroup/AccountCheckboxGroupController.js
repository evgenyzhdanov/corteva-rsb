({
    //get Account List from apex controller
    doInit : function(component, event, helper) {
        var action = component.get("c.getAccountList");
        var accountType = component.get("v.accountType");
        action.setParams({
            accountType:accountType
        });
        action.setCallback(this, function(result){
            var state = result.getState();
            if (component.isValid() && state === "SUCCESS"){
                component.set("v.accountList",result.getReturnValue());   
            }
        });
        $A.enqueueAction(action);
    },     
    //Select all accounts
    handleSelectAllAccount: function(component, event, helper) {
        var getID = component.get("v.accountList");
        var checkvalue = component.find("selectAll").get("v.value");        
        var checkAccount = component.find("checkAccount"); 
        var accountId = "";
        var selectedAccountText = "";
        if(checkvalue == true){
            for(var i=0; i<checkAccount.length; i++){
                checkAccount[i].set("v.value",true);
                accountId = checkAccount[i].get("v.text");
                selectedAccountText = selectedAccountText + " " + accountId;
            }
            component.set("v.selectedAccounts",selectedAccountText);  
        }
        else{ 
            for(var i=0; i<checkAccount.length; i++){
                checkAccount[i].set("v.value",false);
            }
            component.set("v.selectedAccounts",""); 
        }
    },
    //Process the selected accounts
    handleSelectedAccounts: function(component, event, helper) {
        var selectedAccounts = "";
        var checkvalue = component.find("checkAccount");
         
        if(!Array.isArray(checkvalue)){
            if (checkvalue.get("v.value") == true) {
                selectedAccounts = checkvalue.get("v.text");
            }
        }else{
            for (var i = 0; i < checkvalue.length; i++) {
                if (checkvalue[i].get("v.value") == true) {
                    selectedAccounts = selectedAccounts + " " + checkvalue[i].get("v.text");
                }
            }
        }
        component.set("v.selectedAccounts",selectedAccounts);  
    }

})