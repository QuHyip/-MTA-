--CLIENT--
--	local screenWidth, screenHeight = guiGetScreenSize ()
--	dxDrawText(UpTimesKD .. " сек", 44, screenHeight - 43, screenWidth, screenHeight, tocolor( 255, 255, 255, 255 ), 1, "pricedown")
--Helicopter 469
FireKD = 0
UpTimesKD = 30
RocketInPocket = 14

function startTimer()
	UpTimesKD = UpTimesKD - 1
	if UpTimesKD == 0 then
		killTimer(timerKDD)
		UpTimesKD = 30
		RocketInPocket = 14
	end
end

function SparrowReadyToFire()
	outputChatBox("НАР готовы к запуску!", 255, 255, 255)
	FireReadyInSparrow = true
end
addEvent("beready", true)
addEventHandler("beready", root, SparrowReadyToFire)

function SparrowNotReadyToFire()
	FireReadyInSparrow = false
	killTimer(timerKD)
	killTimer(timerKDD)
end
addEvent("notready", true)
addEventHandler("notready", root, SparrowNotReadyToFire)
addEventHandler("onClientPlayerVehicleExit", root, SparrowNotReadyToFire)

function doShoot()
	if FireKD == 7 then
		timerKD = setTimer(SparrowReadyToFire, 30000, 1)
		timerKDD = setTimer(startTimer, 1000, 0)
		outputChatBox("Ракеты перезаряжаются", 200, 0, 0)
		FireKD = 0
		FireReadyInSparrow = false
	end
	if FireReadyInSparrow ~= true then return end
		local theVehicle = getPedOccupiedVehicle(getLocalPlayer())
		local x,y,z = getElementPosition(theVehicle)
		local rX,rY,rZ = getElementRotation(theVehicle)
		local x = x+4*math.cos(math.rad(rZ+90))
		local y = y+4*math.sin(math.rad(rZ+90))
		createProjectile(theVehicle, 19, x+1, y-1, z, 1.0, nil)
		createProjectile(theVehicle, 19, x-1, y+1, z, 1.0, nil)
		FireKD = FireKD + 1
		RocketInPocket = RocketInPocket - 2
end

for keyName, state in pairs(getBoundKeys("fire")) do
 bindKey(keyName, "down", doShoot)
end

function createText()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	vehicle= getVehicleName(vehicle)
	if vehicle ~= "Sparrow" then return end
	local screenWidth, screenHeight = guiGetScreenSize ()
	dxDrawText(UpTimesKD .. " сек", 44, screenHeight - 55, screenWidth, screenHeight, tocolor( 255, 255, 255, 255 ), 1, "pricedown")
	dxDrawText(RocketInPocket .. " шт", 44, screenHeight - 30, screenWidth, screenHeight, tocolor( 255, 255, 255, 255 ), 1, "pricedown")
end

function HandleTheRendering ()
    addEventHandler ( "onClientRender", root, createText )
end
function hmmm()
addEventHandler("onClientRender", root, createText)
end
addEventHandler("onClientVehicleEnter", getRootElement(), hmmm)