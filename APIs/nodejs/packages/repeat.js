;(function(){
	
	var setTimeout = require("timers").setTimeout;
	
	function repeatAsync(env, args){
		var repeat = true;
		var isRunning = true;
		
		function thisGetsRepeated(){
			GLang.callObject(args[1], env, []);
			if(repeat){
				setTimeout(thisGetsRepeated, args[0].value);
			}else{
				isRunning = false;	
			}
		}
		thisGetsRepeated();
		
		return GLang.wrapJsToValue({
			exit:function(){repeat = false},
			isRunning:function(){return isRunning}
		});
	}
	
	function repeat(env, args){
		while(true){
			GLang.callObject(args[0], env, []);
		}
	}

	GLang.defaultRuntimeEnvironment.setInnerVariable("repeatAsync", {value:repeatAsync, display:"function"});
	GLang.defaultRuntimeEnvironment.setInnerVariable("repeat", {value:repeat, display:"function"});
})();