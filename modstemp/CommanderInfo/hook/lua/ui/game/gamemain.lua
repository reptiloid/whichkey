local originalCreateUI = CreateUI
function CreateUI(isReplay) 
	originalCreateUI(isReplay)
	import('/mods/CommanderInfo/modules/main.lua').init()
end
