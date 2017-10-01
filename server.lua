--SERVER--
function enterPlane(theVehicle, seat, jacked)
	if (getVehicleType(theVehicle) ~= "Helicopter") then end
		if (getVehicleType(theVehicle) == "Helicopter") then end
			if (getElementModel(theVehicle) ~= 469) then triggerClientEvent(source,"notready",source) return end
				triggerClientEvent(source,"beready",source)
end
addEventHandler("onPlayerVehicleEnter", getRootElement(), enterPlane)