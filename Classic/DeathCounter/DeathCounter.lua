local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", function(self, event)
    self:COMBAT_LOG_EVENT_UNFILTERED(CombatLogGetCurrentEventInfo())
end)

if DeathCount == nil then DeathCount = 0 end
if DeathPlayer == nil then DeathPlayer = "Freesia" end

function f:COMBAT_LOG_EVENT_UNFILTERED(...)
    local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = ...
    if subevent == "UNIT_DIED" then
        if destName==DeathPlayer then 
            DeathCount = DeathCount+1
        end
    end
end


local function ANNOUNCE(type)
    if type == "s" then SendChatMessage(("I've witnessed Freesia die %s times now"):format(DeathCount), "SAY") end
    if type == "p" then SendChatMessage(("I've witnessed Freesia die %s times now"):format(DeathCount), "PARTY") end
    if type == "r" then SendChatMessage(("I've witnessed Freesia die %s times now"):format(DeathCount), "RAID") end
    if type == "rw" then SendChatMessage(("I've witnessed Freesia die %s times now"):format(DeathCount), "RAID_WARNING") end
    if type == "reset" then DeathCount = 0 end
    if type == "count" then print(("Freesia Death Count: %s"):format(DeathCount)) end
    if type == "" or type == "h" or type == "help" or type == "?" then
        print("\nXEROSTATE'S CUSTOM DEATH COUNTER")
        print("\n\n/dc track PLAYER -> Configures which player to death track, also resets count to 0")
        print("\n/dc reset -> Resets the DeathCount to 0")
        print("\n\n/dc s -> Announces DeathCount to SAY")
        print("\n/dc p -> Announces DeathCount to PARTY")
        print("\n/dc r -> Announces DeathCount to RAID")
        print("\n/dc rw -> announces DeathCount to RAID WARNING")
        print("\n/dc count -> Prints current death count to console/n ")
    end
end

SLASH_DC1 = '/dc'
SlashCmdList["DC"] = ANNOUNCE
