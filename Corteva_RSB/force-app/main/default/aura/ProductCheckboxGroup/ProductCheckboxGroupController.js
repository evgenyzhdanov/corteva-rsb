({
    //get Product List from apex controller
    doInit : function(component, event, helper) {
        var action = component.get("c.getProductList");
        var relatedAccount = component.get("v.relatedAccount");
        action.setParams({
            relatedAccountId:relatedAccount
        });
        action.setCallback(this, function(result){
            var state = result.getState();
            if (component.isValid() && state === "SUCCESS"){
                component.set("v.productList",result.getReturnValue());   
            }
        });
        $A.enqueueAction(action);
    },    
    //Select all products
    handleSelectAllProduct: function(component, event, helper) {
        var getID = component.get("v.productList");
        var checkvalue = component.find("selectAll").get("v.value");        
        var checkProduct = component.find("checkProduct"); 
        var productId = "";
        var selectedProductText = "";
        if(checkvalue == true){
            for(var i=0; i<checkProduct.length; i++){
                checkProduct[i].set("v.value",true);
                productId = checkProduct[i].get("v.text");
                selectedProductText = selectedProductText + " " + productId;
            }
            component.set("v.selectedProducts",selectedProductText);  
        }
        else{ 
            for(var i=0; i<checkProduct.length; i++){
                checkProduct[i].set("v.value",false);
            }
            component.set("v.selectedProducts",""); 
        }
    },
    //Process the selected contacts
    handleSelectedProducts: function(component, event, helper) {
        var selectedProducts = "";
        var checkvalue = component.find("checkProduct");
         
        if(!Array.isArray(checkvalue)){
            if (checkvalue.get("v.value") == true) {
                selectedProducts = checkvalue.get("v.text");
            }
        }else{
            for (var i = 0; i < checkvalue.length; i++) {
                if (checkvalue[i].get("v.value") == true) {
                    selectedProducts = selectedProducts + " " + checkvalue[i].get("v.text");
                }
            }
        }
        component.set("v.selectedProducts",selectedProducts);  
    }

})