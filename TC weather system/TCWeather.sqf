//TCWeather.sqf: v5.0

//** TCWeather by TenuredCLOUD based off of Detrimental Weather effects by JohnO **//

{

private ["_TCweath","_TCexitweather","_fire","_damage","_building","_clothes","_distanceToBuilding","_rainLevel","_distanceToFire","_showsickness","_showcoldness","TC_weatherCheck","_SuitableWeather","_sickness","_vehicle","_exitA","_exitB"];
 };

{

private _TCTemperature = ["Normal","Cold","freezing","wet","Hypothermic","Soaked","Warming Up...","Getting Sick...","Sick","Getting better..."];
 };


_showsickness = true; //True to show sickness status.
_showcoldness = true; //True to enable whether or not you are wet.
TC_weatherCheck = 30; //Time in seconds that the script fires. multiply by x2**//
sickness = false;
TCweath = false;
_SuitableWeather = true;
coldness = 0;
_sickChance = 0;
sickValue = 0;
_rainLevel = rain;
_damage = damage player;
_building = nearestBuilding player;
_fire = nearestObject[player,"FirePlace_burning_F"];
_distanceToFire = player distance _fire;
_vehicle = vehicle player iskindOf "LandVehicle";
_distanceToBuilding = player distance _building;
_clothes = uniform player;
_sounds = ["sound1","sound2","sound3","sound4","sound5"];
_TCTemperature = ["Normal","Cold","freezing","wet","Hypothermic","Soaked","Warming Up...","Getting Sick...","Sick","Getting better..."];
_WarmClothes = ["U_I_Wetsuit_rvg",
"U_O_Wetsuit_rvg",
"U_B_Wetsuit_rvg",
"CUP_I_B_PMC_Unit_26",
"rvg_bandit",
"rvg_bandit_1",
"rvg_camo",
"rvg_camo_1",
"rvg_diamond",
"rvg_diamond_1",
"rvg_independant",
"rvg_independant_1",
"rvg_survivor",
"rvg_survivor_1",
"U_O_PilotCoveralls",
"CUP_U_I_Ghillie_Top",
"CUP_U_B_CZ_WDL_Ghillie",
"U_FRITH_RUIN_SDR_snip_hawk",
"U_FRITH_RUIN_SDR_snip_crow",
"U_FRITH_RUIN_SDR_snip_bld"];

[sickness,sickValue,coldness] spawn
{
        _exitA = false;
        waituntil
        {

                if (!alive player) then
                {
                        sickness = false;
                        coldness = 0;
                        sickValue = 0;
                        player enableStamina false;
                        player allowSprint true;
                };
                uiSleep 1;
                _exitA
        };

};

[] spawn
{
        _exitB = false;
        waituntil
        {
                if (damage player > 0.75) then
                {
                        enableCamShake true;
                        addCamShake [5, 3, 30];
                        [120] call BIS_fnc_bloodEffect;
						uiSleep 5;
				};
                uiSleep 1;
                _exitB
        };
};

_TCexitweather = false;
waitUntil
{
        if (alive player) then
        {


                if (sickValue <= 0) then
                {
                        sickValue = 0;
                }
                else
                {
                        if (sickValue >= 1) then
                        {
                                sickValue = 1;
                        };
                };
                if (coldness <= 0) then
                {
                        coldness = 0;
                }
                else
                {
                        if (coldness >= 1) then
                        {
                                coldness = 0.9;
                        };
                };

                uiSleep TC_weatherCheck;

                _rainLevel = rain;
                _damage = damage player;
                _fire = nearestObject [player,"FirePlace_burning_F"];
                _distanceToFire = player distance _fire;
                _vehicle = vehicle player iskindOf "LandVehicle";
                _distanceToBuilding = player distance _building;
                _building = nearestBuilding player;
				_clothes = uniform player;
                _TCTemperature = ["Normal","Cold","freezing","wet","Hypothermic","Soaked","Warming Up...","Getting Sick...","Sick","Getting better..."];
                if ((_rainLevel > 0.3 )) then {_SuitableWeather = false};

				if ((daytime >= 18 || daytime < 7)) then {_SuitableWeather = false};

				if !((player == vehicle player)) then {_SuitableWeather = true};

                if ((!_SuitableWeather) && (_distanceToFire < 5) || (_distanceToBuilding < 20)) then {_SuitableWeather = true};

				if (_clothes in _WarmClothes) then {_SuitableWeather = true};

                if (_SuitableWeather) then
			    {
                        _SuitableWeather = true;
                        coldness = coldness - 0.1;
                        if (coldness <= 0) then
                        {
                                if (sickValue >= 0) then
                                {
                                        sickValue = sickValue - 0.05;
                                        if (sickValue <= 0.25) then
                                        {
                                                sickness = false;
                                                enableCamShake false;
                                                player enableStamina false;
                                                player allowSprint true;
                                                uiSleep 1;
                                                if ((_showsickness) && (sickValue >= 0 && sickValue <= 0.25)) then
                                                {
                                                player setVariable ["_TCTemperature", "Normal"];
												};
                                        };
                                };
                        };
                }
                else
                {
                        _SuitableWeather = false;
                        coldness = coldness + 0.1;
                        TCweath = true;
			   };
                if ((_showcoldness) && (coldness >= 0 && coldness <=0.1) && (!_SuitableWeather)) then
                {
                        titleText ["<t color='#ffffff' size='1' align='left' valign='bottom'>You are getting cold</t><br/>", "PLAIN DOWN", 0.5, true, true];
                        player setVariable ["_TCTemperature", "cold"];
				}
                else
                {
                        if ((_showcoldness) && (coldness >= 0.2 && coldness <= 0.3) && (!_SuitableWeather)) then
                        {
                                titleText ["<t color='#42aaf4' size='1' align='left' valign='bottom'>You are starting to freeze</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                player setVariable ["_TCTemperature", "freezing"];
						};
                };


				if ((_SuitableWeather) && (TCweath)) then{
			  if ((_showcoldness) && (coldness < 0.25)) then{
                titleText ["<t color='#FFB700' size='1' align='right' valign='bottom'>You are warming up.</t><br/>", "PLAIN DOWN", 0.5, true, true];
				//_txt = format ["<img shadow='0.2' size='1.5' image='%1' /><t size='1'>%2</t>", "images\fire2.paa"];
                //[_txt, safezoneX +  safezoneW - 0.65, safeZoneY + safezoneH - 0.2, 30, 0, 0, 888] spawn bis_fnc_dynamicText;
			    player setVariable ["_TCTemperature", "Warming Up..."];
			};
		};

		if ((_SuitableWeather) or !(TCweath)) then{
			  if ((_showcoldness) && (coldness <= 0)) then{
                player setVariable ["_TCTemperature", "Normal"];
	        };
		};

		    uiSleep TC_weatherCheck;

                if ((coldness > 0.3) && (!_SuitableWeather)) then
                {
                        coldness = coldness + 0.1;
                        player setDamage _damage +0.01;
                        enableCamShake true;
                        addCamShake [1, 5, 10];
                        if (_showcoldness) then
                        {
                                titleText ["<t color='#00BEFF' size='1' align='left' valign='bottom'>You are freezing, find shelter immediately</t><br/>", "PLAIN DOWN", 0.5, true, true]; playSound (_sounds select ([0,(count _sounds)-1] call BIS_fnc_randomInt));
                                player setVariable ["_TCTemperature", "freezing"];
						};
                };

                if ((!_SuitableWeather) && (coldness > 0.3 )) then
                {
                        _sickChance = random 1;

                        if ((_sickChance > 0.2) || (sickValue > 0)) then
                        {
                                sickness = true;
                                sickValue = sickValue + 0.05;
                                if ((_showsickness) && (sickValue < 0.25)) then
                                {

                                        titleText ["<t color='#b25905' size='1' align='left' valign='bottom'>Sickness Risk +</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                        player setVariable ["_TCTemperature", "Getting Sick..."];


								};
                                if ((sickValue > 0.25) && (sickValue < 0.50)) then
                                {
                                        player enableStamina false;
                                        player allowSprint false;
                                        enableCamShake true;
                                        addCamShake [5, 3, 30];


                                        if (_showsickness) then
                                        {
                                                titleText ["<t color='#c9701e' size='1' align='left' valign='bottom'>You are sick, seek fire and shelter</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                                player setVariable ["_TCTemperature", "Sick"];


										};
                                }
                                else
                                {
                                        if (sickValue > 0.50) then
                                        {
                                                player enableStamina false;
                                                player allowSprint false;
                                                enableCamShake true;
                                                addCamShake [10, 10, 15];
                                                [120] call BIS_fnc_bloodEffect;
                                                player setDamage _damage + 0.02;


                                                if (_showsickness) then
                                                {
                                                        titleText ["<t color='#a80b0b' size='1' align='left' valign='bottom'>You are Dying from Sickness...</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                                        player setVariable ["_TCTemperature", "Sick"];

												};
                                        };
                                };
                        };
                };
                if ((_SuitableWeather) && (sickness)) then
                {
                        if ((_showsickness) && (sickValue < 0.25)) then
                        {
                                titleText ["<t color='#90a014' size='1' align='left' valign='bottom'>Sickness risk -</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                player setVariable ["_TCTemperature", "Getting better..."];


						};
                        if ((sickValue > 0.25) && (sickValue < 0.50)) then
                        {

                                enableCamShake true;
                                addCamShake [5, 3, 30];


                                if (_showsickness) then
                                {
                                        titleText ["<t color='#c9701e' size='1' align='left' valign='bottom'>You are sick, seek fire and shelter</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                        player setVariable ["_TCTemperature", "Sick"];
								};
                        }
                        else
                        {
                                if (sickValue > 0.50) then
                                {
                                        player enableStamina false;
                                        player allowSprint false;
                                        enableCamShake true;
                                        addCamShake [10, 10, 15];
                                        [120] call BIS_fnc_bloodEffect;
                                        player setDamage _damage + 0.03;


                                        if (_showsickness) then
                                        {
                                                titleText ["<t color='#a80b0b' size='1' align='left' valign='bottom'>You are Dying of Sickness...</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                                player setVariable ["_TCTemperature", "Sick"];
										};
                                };
                        };
                };
        };
        uiSleep 1;
        _TCexitweather
};
