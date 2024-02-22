-- funkcje
function upd(...)
	if not {...} then return end
	local query=dbExec(db, ...)
	return query
end

function wyb(...)
	if not {...} then return end
	local query=dbQuery(db, ...)
	local result=dbPoll(query, -1)
	return result
end
-- dbconnect
addEventHandler("onResourceStart", resourceRoot, function()
    db = dbConnect( "mysql", "dbname=;host=;charset=utf8", "", "" )
	if(db) then outputDebugString("Połączono!") else outputDebugString("Nie udało się połączyć!") end
end)