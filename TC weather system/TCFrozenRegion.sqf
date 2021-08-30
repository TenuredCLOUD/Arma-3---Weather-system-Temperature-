 //TCFrozenRegion.sqf: v5.0

//** TCFrozenRegion by TenuredCLOUD based off of Detrimental Weather effects by JohnO **//


 
{

private ["_TCfrozen","_TCexitFrZregionfreezing","_fire","_damage","_building","_clothes","_distanceToBuilding","_distanceToFire","_showfreeze","_showFreezing","TCFZ_effectsCheck","_StableRegion","_FZregionfreezing","_vehicle","_exitA"];
 };

{

private _TCTemperature = ["Normal","Cold","freezing","wet","Hypothermic","Soaked","Warming Up...","Getting Sick...","Sick","Getting better..."];
 };


_showfreeze = true; //True to show FZregionfreezing status.
_showFreezing = true; //True to enable whether or not you are wet.
TCFZ_effectsCheck = 30; //Time in seconds that the script fires. multiply by x2**//
FZregionfreezing = false;
TCfrozen = false;
_StableRegion = true;
Freezing = 0;
_freezeChance = 0;
freezeValue = 0;
_damage = damage player;
_building = nearestBuilding player;
_fire = nearestObject[player,"FirePlace_burning_F"];
_distanceToFire = player distance _fire;
_vehicle = vehicle player iskindOf "LandVehicle";
_distanceToBuilding = player distance _building;
_clothes = uniform player;
_sounds = ["sound1","sound2","sound3","sound4","sound5"];
_FZregionwarm = ["CUP_I_B_PMC_Unit_26"];
_TCTemperature = ["Normal","Cold","freezing","wet","Hypothermic","Soaked","Warming Up...","Getting Sick...","Sick","Getting better..."];

[FZregionfreezing,freezeValue,Freezing] spawn
{
        _exitA = false;
        waituntil
        {

                if (!alive player) then
                {
                        FZregionfreezing = false;
                        Freezing = 0;
                        freezeValue = 0;
                        player enableStamina false;
                        player allowSprint true;
                };
                uiSleep 1;
                _exitA
        };

};



_TCexitFrZregionfreezing = false;
        waituntil {
		if (alive player) then {
        if (freezeValue <= 0) then {
            freezeValue = 0;
        } else {
            if (freezeValue >= 1) then {
                freezeValue = 1;
            };
        };
        if (Freezing <= 0) then {
            Freezing = 0;
        } else {
            if (Freezing >= 1) then {
                Freezing = 0.9;
            };
        };

        uiSleep TCFZ_effectsCheck;

        _damage = damage player;
        _fire = nearestObject [player,"FirePlace_burning_F"];
        _distanceToFire = player distance _fire;
        _vehicle = vehicle player iskindOf "LandVehicle";
        _distanceToBuilding = player distance _building;
        _building = nearestBuilding player;
        _clothes = uniform player;
		_TCTemperature = ["Normal","Cold","freezing","wet","Hypothermic","Soaked","Warming Up...","Getting Sick...","Sick","Getting better..."];
        if ((getPosASL player select 2 )> 680) then {_StableRegion = false};
		if !((player == vehicle player)) then {_StableRegion = true};
        if ((!_StableRegion) && (_distanceToFire < 5) || (_distanceToBuilding < 20)) then {_StableRegion = true};
        if (_clothes in _FZregionwarm) then {_StableRegion = true};

        if (_StableRegion) then{
            _StableRegion = true;
            Freezing = Freezing - 0.1;
            if (Freezing <= 0) then {
                if (freezeValue >= 0) then {
                    freezeValue = freezeValue - 0.05;
                    if (freezeValue <= 0.25) then {
                        FZregionfreezing = false;
                        enableCamShake false;
                        player enableStamina false;
                        player allowSprint true;
                        uiSleep 1;
                        if ((_showfreeze) && (freezeValue >= 0 && freezeValue <= 0.25)) then
						{
                        player setVariable ["_TCTemperature", "Normal"];
						};
                    };
                };
            };
        }else{
            _StableRegion = false;
            Freezing = Freezing + 0.1;
            TCfrozen = true;
		};
        if ((_showFreezing) && (Freezing >= 0 && Freezing <=0.1) && (!_StableRegion)) then {
            titleText ["<t color='#ffffff' size='1' align='left' valign='bottom'>You are very, very cold.</t><br/>", "PLAIN DOWN", 0.5, true, true];
            player setVariable ["_TCTemperature", "cold"];
		}else{
            if ((_showFreezing) && (Freezing >= 0.2 && Freezing <= 0.3) && (!_StableRegion)) then{
                titleText ["<t color='#42aaf4' size='1' align='left' valign='bottom'>You are going to freeze to death...</t><br/>", "PLAIN DOWN", 0.5, true, true];
                player setVariable ["_TCTemperature", "freezing"];
			};
        };

		 if ((_StableRegion) && (TCfrozen)) then{
			  if ((_showFreezing) && (Freezing < 0.25)) then{
                titleText ["<t color='#FFB700' size='1' align='right' valign='bottom'>You are warming up.</t><br/>", "PLAIN DOWN", 0.5, true, true];
				//_txt = format ["<img shadow='0.2' size='1.5' image='%1' /><t size='1'>%2</t>", "images\fire2.paa"];
                //[_txt, safezoneX +  safezoneW - 0.65, safeZoneY + safezoneH - 0.2, 30, 0, 0, 888] spawn bis_fnc_dynamicText;
			    player setVariable ["_TCTemperature", "Warming Up..."];
			};
		};

		if ((_StableRegion) or !(TCfrozen)) then{
			  if ((_showFreezing) && (Freezing <= 0)) then{
                player setVariable ["_TCTemperature", "Normal"];
	        };
		};


		uiSleep TCFZ_effectsCheck;

        if ((Freezing > 0.3) && (!_StableRegion)) then{
            Freezing = Freezing + 0.1;
            player setDamage _damage +0.05;
            enableCamShake true;
            addCamShake [1, 5, 10];
            if (_showFreezing) then{
                titleText ["<t color='#00BEFF' size='1' align='left' valign='bottom'>You are freezing, find shelter immediately</t><br/>", "PLAIN DOWN", 0.5, true, true]; playSound (_sounds select ([0,(count _sounds)-1] call BIS_fnc_randomInt));
                player setVariable ["_TCTemperature", "freezing"];
			};
        };

        if ((!_StableRegion) && (Freezing > 0.3 )) then {
            _freezeChance = random 1;

            if ((_freezeChance > 0.2) || (freezeValue > 0)) then {
                FZregionfreezing = true;
                freezeValue = freezeValue + 0.05;
                if ((_showfreeze) && (freezeValue < 0.25)) then{
                    titleText ["<t color='#b25905' size='1' align='left' valign='bottom'>freezing Risk +</t><br/>", "PLAIN DOWN", 0.5, true, true];
                    player setVariable ["_TCTemperature", "freezing"];
				};
                if ((freezeValue > 0.25) && (freezeValue < 0.50)) then{
                    player enableStamina false;
                    player allowSprint false;
                    enableCamShake true;
                    addCamShake [5, 3, 30];


                    if (_showfreeze) then{
                        titleText ["<t color='#c9701e' size='1' align='left' valign='bottom'>You are freezing, seek fire and shelter</t><br/>", "PLAIN DOWN", 0.5, true, true];
                        player setVariable ["_TCTemperature", "freezing"];
                    };
                }else{
                    if (freezeValue > 0.50) then{
                        player enableStamina false;
                        player allowSprint false;
                        enableCamShake true;
                        addCamShake [10, 10, 15];
                        [120] call BIS_fnc_bloodEffect;
                        player setDamage _damage + 0.02;

                        if (_showfreeze) then{
                            titleText ["<t color='#a80b0b' size='1' align='left' valign='bottom'>You are freezing to death...</t><br/>", "PLAIN DOWN", 0.5, true, true];
                            player setVariable ["_TCTemperature", "freezing"];
						};
                    };
                };
            };
        };
        if ((_StableRegion) && (FZregionfreezing)) then{
            if ((_showfreeze) && (freezeValue < 0.25)) then{
                titleText ["<t color='#90a014' size='1' align='left' valign='bottom'>freezing risk -</t><br/>", "PLAIN DOWN", 0.5, true, true];
                player setVariable ["_TCTemperature", "Warming Up..."];

			};
            if ((freezeValue > 0.25) && (freezeValue < 0.50)) then{
                enableCamShake true;
                addCamShake [5, 3, 30];
                if (_showfreeze) then{
                    titleText ["<t color='#c9701e' size='1' align='left' valign='bottom'>You are freezing, seek fire and shelter</t><br/>", "PLAIN DOWN", 0.5, true, true];
                    player setVariable ["_TCTemperature", "freezing"];
                };
            }else{
                if (freezeValue > 0.50) then{
                    player enableStamina false;
                    player allowSprint false;
                    enableCamShake true;
                    addCamShake [10, 10, 15];
                    [120] call BIS_fnc_bloodEffect;
                    player setDamage _damage + 0.03;

                    if (_showfreeze) then{
                        titleText ["<t color='#a80b0b' size='1' align='left' valign='bottom'>You are dying from the cold...</t><br/>", "PLAIN DOWN", 0.5, true, true];
                        player setVariable ["_TCTemperature", "freezing"];
					};
                };
            };
        };
    };
    uiSleep 1;
    _TCexitFrZregionfreezing
};
