GLang.defaultRuntimeEnvironment.setInnerVariable("uiTextfieldOnaction", {value:GLang.arrayFun(function(env, args){
	var textfield = document.createElement("input");
	textfield.type="text";
	textfield.value=args[1].value;
	textfield.onkeyup=function(e){
		if(e.key === "Enter"){
			GLang.callObject(args[0], env, [GLang.stringValue(textfield.value)]);
		}
	}
	return {value:textfield, display:"dom"};
})})
GLang.defaultRuntimeEnvironment.setInnerVariable("uiTextfieldOnchange", {value:GLang.arrayFun(function(env, args){
	var textfield = document.createElement("input");
	textfield.type="text";
	textfield.value=args[1].value;
	
	function callback(){
		GLang.callObject(args[0], env, [GLang.stringValue(textfield.value)]);
	}
	
	textfield.addEventListener("change", callback, false);
	textfield.addEventListener("keyup", callback, false);
	
	return {value:textfield, display:"dom"};
})})