addEventHandler("onPlayerCommand", root, function(command)
if command == "register" then cancelEvent() return end
if command == "setskin" then cancelEvent() return end
if command == "msg" then cancelEvent() return end
if command == "Toggle" then return end
if command == "Next" then  return end
if command == "Previous" then  return end
if command == "say" then return end
if command == "nick" then cancelEvent() return end
--if command == "report" then cancelEvent() return end
--if command == "me" then cancelEvent() return end
--if getElementData(source, "player:admin") then
--triggerEvent("admin:logs", root, "Admin> /"..tostring(command).." Nick:"..getPlayerName(source).." UID("..getElementData(source, "player:uid")..")")
--end
end
)
--// blokada zmiany nicku
addEventHandler("onPlayerChangeNick", root, function()
	cancelEvent()
end)






