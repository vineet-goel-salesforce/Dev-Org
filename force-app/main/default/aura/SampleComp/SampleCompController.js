({
	doInit : function(component, event, helper) {
		 var colorList = [];
       // colorList.push('red');
         colorList.push('yellow');
        component.set("v.test", colorList);
	},
    
    getValue : function(component, event, helper) {
        console.log(component.find("colorSelection"));
        console.log(component.find("colorSelection").get("v.value"));
    },
    
    onSelectChange : function(component, event, helper) {
    var selected = component.find("colorSelection").get("v.value");
        console.log(selected);
    }
})