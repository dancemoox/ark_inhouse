ark_mapTeleportEnabled = false;

ark_admin_tools_fnc_assignMapTeleport = {
    params ["_teleportEnabled"];

    ark_mapTeleportEnabled = _teleportEnabled;
    publicVariable "ark_mapTeleportEnabled";
};

ark_admin_tools_fnc_enableMapTeleport = {
    params ["_unit"];

    [["\x\ark\addons\ark_main\resources\click_enable.paa", 2.0], ["Click on map to teleport"]] call CBA_fnc_notify;
    openMap [true, true];
    _unit onMapSingleClick {
        [_this, _pos] call ark_admin_tools_fnc_teleportUnit;
    };
};

ark_admin_tools_fnc_teleportUnit = {
    params ["_unit","_pos"];

    if (surfaceIsWater _pos) then {
        [
            {
                (_this #0) setposASL [(_this #1),(_this #2),0];
                openMap [false, false];
                onMapSingleClick "";
            },
            [_unit, _pos #0, _pos #1]
        ] call CBA_fnc_execNextFrame;
    } else {
        [
            {
                (_this #0) setposATL [(_this #1),(_this #2),0];
                openMap [false, false];
                onMapSingleClick "";
            },
            [_unit, _pos #0, _pos #1]
        ] call CBA_fnc_execNextFrame;
    };
};