 //TCColdwaters.sqf: v3.0

//** TCColdwaters by TenuredCLOUD based off of Detrimental Weather effects by JohnO **//



{

private ["_TCwet","_TCexitColdwaters","_fire","_damage","_building","_clothes","_distanceToBuilding","_distanceToFire","_showhypo","_showwetness","TCwater_effectsCheck","_SuitableWater","_hypothermia","_vehicle","_exitA","_TCTemperature"];
 };

//{

//THIS IS FOR UI Ignore //private _TCTemperature = ["Normal","Cold","freezing","wet","Hypothermic","Soaked","Warming Up...","Getting Sick...","Sick","Getting better..."];
// };

//_TCTemperature is for UI ignore it ** un "//" later if UI is wanted//

_showhypo = true; //True to show hypothermia status.
_showwetness = true; //True to enable whether or not you are wet.
TCwater_effectsCheck = 15; //Time in seconds that the script fires. multiply by x2**//
hypothermia = false;
TCwet = false;
_SuitableWater = true;
wetness = 0;
_hypoChance = 0;
hypoValue = 0;
_damage = damage player;
_building = nearestBuilding player;
_fire = nearestObject[player,"FirePlace_burning_F"];
_distanceToFire = player distance _fire;
_vehicle = vehicle player iskindOf "LandVehicle";
_distanceToBuilding = player distance _building;
_clothes = uniform player;
//_TCTemperature = ["Normal","Cold","freezing","wet","Hypothermic","Soaked","Warming Up...","Getting Sick...","Sick","Getting better..."];

_WetClothes = ["U_I_Wetsuit_rvg",
"U_O_Wetsuit_rvg",
"U_B_Wetsuit_rvg",
"U_I_Wetsuit",
"U_O_Wetsuit",
"U_B_Wetsuit"];

[hypothermia,hypoValue,wetness] spawn
{
        _exitA = false;
        waituntil
        {

                if (!alive player) then
                {
                        hypothermia = false;
                        wetness = 0;
                        hypoValue = 0;
                        player enableStamina false;
                        player allowSprint true;
                };
                uiSleep 1;
                _exitA
        };

};

 _TCexitColdwaters = false;
        waituntil {
		if (alive player) then {
        if (hypoValue <= 0) then {
            hypoValue = 0;
        } else {
            if (hypoValue >= 1) then {
                hypoValue = 1;
            };
        };
        if (wetness <= 0) then {
            wetness = 0;
        } else {
            if (wetness >= 1) then {
                wetness = 0.9;
            };
        };

        uiSleep TCwater_effectsCheck;

        _damage = damage player;
        _fire = nearestObject [player,"FirePlace_burning_F"];
        _distanceToFire = player distance _fire;
        _vehicle = vehicle player iskindOf "LandVehicle";
        _distanceToBuilding = player distance _building;
        _building = nearestBuilding player;
        _clothes = uniform player;
        _TCTemperature = ["Normal","Cold","freezing","wet","Hypothermic","Soaked","Warming Up...","Getting Sick...","Sick","Getting better..."];


		if ((underwater player) or (getPosASLW player select 2) < -1) then {_SuitableWater = false};
        if !((player == vehicle player)) then {_SuitableWater = true};
		if ((!_SuitableWater) && (_distanceToFire < 5) || (_distanceToBuilding < 20)) then {_SuitableWater = true};
        if (_clothes in _WetClothes) then {_SuitableWater = true};


		if (_SuitableWater) then{
            _SuitableWater = true;
            wetness = wetness - 0.1;
            if (wetness <= 0) then {
                if (hypoValue >= 0) then {
                    hypoValue = hypoValue - 0.05;
                    if (hypoValue <= 0.25) then {
                        hypothermia = false;
                        TCwet = false;
						enableCamShake false;
                        player enableStamina false;
                        player allowSprint true;
                        uiSleep 1;
                        if ((_showhypo) && (hypoValue >= 0 && hypoValue <= 0.25)) then {
						  titleText ["<t color='#ffffff' size='1' align='left' valign='bottom'>You are no longer cold.</t><br/>", "PLAIN DOWN", 0.5, true, true];
						 // player setVariable ["_TCTemperature", "Normal"];
						};
                    };
                };
            };
        }else{
           _SuitableWater = false;
           wetness = wetness + 0.1;
		       TCwet = true;
	};
		   if ((_showwetness) && (wetness >= 0 && wetness <=0.1) && (!_SuitableWater)) then {
           titleText ["<t color='#ffffff' size='1' align='left' valign='bottom'>You are wet</t><br/>", "PLAIN DOWN", 0.5, true, true];
            //player setVariable ["_TCTemperature", "wet"];
		   }else{
            if ((_showwetness) && (wetness >= 0.2 && wetness <= 0.3) && (!_SuitableWater)) then{
                titleText ["<t color='#42aaf4' size='1' align='left' valign='bottom'>You are Soaked</t><br/>", "PLAIN DOWN", 0.5, true, true];
              // player setVariable ["_TCTemperature", "Soaked"];
	    };
	};
	    if ((_SuitableWater) && (TCwet)) then{
			  if ((_showwetness) && (wetness < 0.25)) then{
                titleText ["<t color='#FFB700' size='1' align='right' valign='bottom'>You are warming up.</t><br/>", "PLAIN DOWN", 0.5, true, true];
				//_txt = format ["<img shadow='0.2' size='1.5' image='%1' /><t size='1'>%2</t>", "images\fire2.paa"];
                //[_txt, safezoneX +  safezoneW - 0.65, safeZoneY + safezoneH - 0.2, 30, 0, 0, 888] spawn bis_fnc_dynamicText;
			   // player setVariable ["_TCTemperature", "Warming Up..."];
			};
		};

		if ((_SuitableWater) or !(TCwet)) then{
			  if ((_showwetness) && (wetness <= 0)) then{
              //  player setVariable ["_TCTemperature", "Normal"];
	        };
		};

		uiSleep TCwater_effectsCheck;

        if ((wetness > 0.3) && (!_SuitableWater)) then{
            wetness = wetness + 0.1;
            player setDamage _damage +0.05;
            enableCamShake true;
            addCamShake [1, 5, 10];
            if (_showwetness) then{
                titleText ["<t color='#00BEFF' size='1' align='left' valign='bottom'>You are freezing, find shelter immediately</t><br/>", "PLAIN DOWN", 0.5, true, true];
			//	player setVariable ["_TCTemperature", "freezing"];
			};
        };

        if ((!_SuitableWater) && (wetness > 0.3 )) then {
            _hypoChance = random 1;

            if ((_hypoChance > 0.2) || (hypoValue > 0)) then {
                hypothermia = true;
                hypoValue = hypoValue + 0.05;
                if ((_showhypo) && (hypoValue < 0.25)) then{
                    titleText ["<t color='#C9FF00' size='1' align='left' valign='bottom'>Sick Risk +</t><br/>", "PLAIN DOWN", 0.5, true, true];
                //    player setVariable ["_TCTemperature", "Getting Sick..."];
				};
                if ((hypoValue > 0.25) && (hypoValue < 0.50)) then{
                    player enableStamina false;
                    player allowSprint false;
                    enableCamShake true;
                    addCamShake [5, 3, 30];


                    if (_showhypo) then{
                        titleText ["<t color='#c9701e' size='1' align='left' valign='bottom'>You have Hypothermia, seek fire and shelter</t><br/>", "PLAIN DOWN", 0.5, true, true];
                    //    player setVariable ["_TCTemperature", "Hypothermic"];
					};
                }else{
                    if (hypoValue > 0.50) then{
                        player enableStamina false;
                        player allowSprint false;
                        enableCamShake true;
                        addCamShake [10, 10, 15];
                        [120] call BIS_fnc_bloodEffect;
                        player setDamage _damage + 0.02;

                        if (_showhypo) then{
                            titleText ["<t color='#a80b0b' size='1' align='left' valign='bottom'>You are Dying of Hypothermia...</t><br/>", "PLAIN DOWN", 0.5, true, true];
                    //        player setVariable ["_TCTemperature", "Hypothermic"];
						};
                    };
                };
            };
        };
        if ((_SuitableWater) && (hypothermia)) then{
            if ((_showhypo) && (hypoValue < 0.25)) then{
                titleText ["<t color='#FFB700' size='1' align='right' valign='bottom'>You are warming up.</t><br/>", "PLAIN DOWN", 0.5, true, true];
				//_txt = format ["<img shadow='0.2' size='1.5' image='%1' /><t size='1'>%2</t>", "images\fire2.paa"];
                //[_txt, safezoneX +  safezoneW - 0.65, safeZoneY + safezoneH - 0.2, 30, 0, 0, 888] spawn bis_fnc_dynamicText;
			//    player setVariable ["_TCTemperature", "Warming Up..."];
			};
            if ((hypoValue > 0.25) && (hypoValue < 0.50)) then{
                enableCamShake true;
                addCamShake [5, 3, 30];
                if (_showhypo) then{
                    titleText ["<t color='#c9701e' size='1' align='left' valign='bottom'>You have Hypothermia, seek fire and shelter</t><br/>", "PLAIN DOWN", 0.5, true, true];
          //          player setVariable ["_TCTemperature", "Hypothermic"];
				};
            }else{
                if (hypoValue > 0.50) then{
                    player enableStamina false;
                    player allowSprint false;
                    enableCamShake true;
                    addCamShake [10, 10, 15];
                    [120] call BIS_fnc_bloodEffect;
                    player setDamage _damage + 0.03;

                    if (_showhypo) then{
                        titleText ["<t color='#a80b0b' size='1' align='left' valign='bottom'>You are Dying of Hypothermia...</t><br/>", "PLAIN DOWN", 0.5, true, true];
                  //      player setVariable ["_TCTemperature", "Hypothermic"];
					};
                };
            };
        };
    };
    uiSleep 1;
    _TCexitColdwaters
};
