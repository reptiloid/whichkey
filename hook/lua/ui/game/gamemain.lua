local originalCreateUI = CreateUI
function CreateUI(isReplay) 
	originalCreateUI(isReplay)
	import('/mods/whichkey/modules/main.lua').init()
end
