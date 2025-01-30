local funcs = import("../funcs.lua")
local CommandMode = import("/lua/ui/game/commandmode.lua")


local opticsIndex = 1

function optics_chose_target()
	local data = { name="RULEUCC_Script", AbilityName="TargetLocation", TaskName="TargetLocation" }
	CommandMode.StartCommandMode("order", data)
end

function get_next_optics()
	local opticsUnits = funcs.ui_SelByCat({ str="OPTICS AEON" })
	if opticsUnits then
		local listSize = table.getn(opticsUnits)
		local nextUnit = opticsUnits[opticsIndex] or opticsUnits[1]
		print(listSize .. "/" .. opticsIndex)
		SelectUnits({ nextUnit })
		optics_chose_target()
		opticsIndex = opticsIndex + 1
		if opticsIndex > listSize then
			opticsIndex = 1
		end
	end
end
