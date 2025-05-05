
--- Displays all pings in the table for each world view. The ping format is the same as defined in the DoPing function.
-- @param data A table where each element is data about a ping.
function DisplayPing(data)
    --Table of all map views to display pings in
    local views = import('/lua/ui/game/worldview.lua').GetWorldViews()

    -- for each ping
    for index, ping in data do

        -- for each world view (think about split-screen)
        for _, viewControl in views do

            -- perform the corresponding action
            if viewControl and ping.Action ~= 'renew' then
                if ping.Action then
                    viewControl:UpdatePing(ping)
                    if ping.Action == 'delete' then
                        markers[ping.Owner][ping.ID] = nil
                    elseif ping.Action == 'flush' then
                        markers = {}
                    end
                else
                    viewControl:DisplayPing(ping)
                    if ping.Marker then
                        if not markers[ping.Owner] then markers[ping.Owner] = {} end
                        markers[ping.Owner][ping.ID] = ping
                    end
                end
            end
        end

        -- for new pings we perform a sound
        if ping.Sound and not ping.Renew then
            PlaySound(Sound{Bank = 'pings', Cue = 'ping'})
        end
    end
end
