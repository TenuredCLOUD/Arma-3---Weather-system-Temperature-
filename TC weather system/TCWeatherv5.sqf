//TCWeatherv5.sqf: v5.0 ~STABLE///

//** TCWeather by TenuredCLOUD based off of Detrimental Weather effects by JohnO rewritten by TenuredCLOUD **//

{

private ["_TCweath","_TCexitweather","_fire","_damage","_building","_clothes","_distanceToBuilding","_rainLevel","_distanceToFire","_showsickness","_showcoldness","TC_weatherCheck","_SuitableWeather","_sickness","_vehicle","_exitA","_exitB","_TCwet","_TCexitColdwaters","_showhypo","_showwetness","TCwater_effectsCheck","_SuitableWater","_hypothermia","_TCfrozen","_TCexitFrZregionfreezing","_showfreeze","_showFreezing","TCFZ_effectsCheck","_StableRegion","_FZregionfreezing"];
 };

{

private _TCTemperature = ["Normal","Cold","freezing","wet","Hypothermic","Soaked","Warming Up...","Getting Sick...","Sick","Getting better..."];
 };


_showsickness = true; //True to show sickness status.
_showcoldness = true; //True to enable whether or not you are wet.
_showhypo = true; //True to show hypothermia status.
_showwetness = true; //True to enable whether or not you are wet.
_showfreeze = true; //True to show FZregionfreezing status.
_showFreezing = true; //True to enable whether or not you are wet.
TC_weatherCheck = 30; //Time in seconds that the script fires. multiply by x2**//
sickness = false;
TCweath = false;
TCwater_effectsCheck = 15; //Time in seconds that the script fires. multiply by x2**//
hypothermia = false;
TCwet = false;
TCFZ_effectsCheck = 30; //Time in seconds that the script fires. multiply by x2**//
FZregionfreezing = false;
TCfrozen = false;
_StableRegion = true;
Freezing = 0;
_freezeChance = 0;
freezeValue = 0;
_SuitableWeather = true;
_SuitableWater = true;
coldness = 0;
wetness = 0;
_hypoChance = 0;
hypoValue = 0;
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
_WetClothes = ["U_I_Wetsuit_rvg",
"U_O_Wetsuit_rvg",
"U_B_Wetsuit_rvg",
"U_I_Wetsuit",
"U_O_Wetsuit",
"U_B_Wetsuit"];
_FZregionwarm = ["CUP_I_B_PMC_Unit_26"];

[sickness,sickValue,coldness,hypothermia,hypoValue,wetness,FZregionfreezing,freezeValue,Freezing] spawn
{
        _exitA = false;
        waituntil
        {

                if (!alive player) then
                {
                        sickness = false;
                        coldness = 0;
                        sickValue = 0;
                        hypothermia = false;
                        wetness = 0;
                        hypoValue = 0;
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

        if ((underwater player) or (getPosASLW player select 2) < -1) then {_SuitableWater = false};

        if !((player == vehicle player)) then {_SuitableWater = true};

        if ((!_SuitableWater) && (_distanceToFire < 5) || (_distanceToBuilding < 20)) then {_SuitableWater = true};

        if (_clothes in _WetClothes) then {_SuitableWater = true};

        if ((getPosASL player select 2 )> 680) then {_StableRegion = false};

        if !((player == vehicle player)) then {_StableRegion = true};

        if ((!_StableRegion) && (_distanceToFire < 5) || (_distanceToBuilding < 20)) then {_StableRegion = true};

        if (_clothes in _FZregionwarm) then {_StableRegion = true};

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
                     //titleText ["<t color='#ffffff' size='1' align='left' valign='bottom'>You are no longer cold.</t><br/>", "PLAIN DOWN", 0.5, true, true];
                     player setVariable ["_TCTemperature", "Normal"];
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
                   player setVariable ["_TCTemperature", "wet"];
              }else{
                   if ((_showwetness) && (wetness >= 0.2 && wetness <= 0.3) && (!_SuitableWater)) then{
                       titleText ["<t color='#42aaf4' size='1' align='left' valign='bottom'>You are Soaked</t><br/>", "PLAIN DOWN", 0.5, true, true];
                      player setVariable ["_TCTemperature", "Soaked"];
             };
         };
             if ((_SuitableWater) && (TCwet)) then{
               if ((_showwetness) && (wetness < 0.25)) then{
                       titleText ["<t color='#FFB700' size='1' align='right' valign='bottom'>You are warming up.</t><br/>", "PLAIN DOWN", 0.5, true, true];
               //_txt = format ["<img shadow='0.2' size='1.5' image='%1' /><t size='1'>%2</t>", "images\fire2.paa"];
                       //[_txt, safezoneX +  safezoneW - 0.65, safeZoneY + safezoneH - 0.2, 30, 0, 0, 888] spawn bis_fnc_dynamicText;
                 player setVariable ["_TCTemperature", "Warming Up..."];
             };
           };

           if ((_SuitableWater) or !(TCwet)) then{
               if ((_showwetness) && (wetness <= 0)) then{
                       player setVariable ["_TCTemperature", "Normal"];
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
               player setVariable ["_TCTemperature", "freezing"];
             };
               };

               if ((!_SuitableWater) && (wetness > 0.3 )) then {
                   _hypoChance = random 1;

                   if ((_hypoChance > 0.2) || (hypoValue > 0)) then {
                       hypothermia = true;
                       hypoValue = hypoValue + 0.05;
                       if ((_showhypo) && (hypoValue < 0.25)) then{
                           titleText ["<t color='#C9FF00' size='1' align='left' valign='bottom'>Sick Risk +</t><br/>", "PLAIN DOWN", 0.5, true, true];
                           player setVariable ["_TCTemperature", "Getting Sick..."];
               };
                       if ((hypoValue > 0.25) && (hypoValue < 0.50)) then{
                           player enableStamina false;
                           player allowSprint false;
                           enableCamShake true;
                           addCamShake [5, 3, 30];


                           if (_showhypo) then{
                               titleText ["<t color='#c9701e' size='1' align='left' valign='bottom'>You have Hypothermia, seek fire and shelter</t><br/>", "PLAIN DOWN", 0.5, true, true];
                               player setVariable ["_TCTemperature", "Hypothermic"];
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
                                   player setVariable ["_TCTemperature", "Hypothermic"];
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
                 player setVariable ["_TCTemperature", "Warming Up..."];
             };
                   if ((hypoValue > 0.25) && (hypoValue < 0.50)) then{
                       enableCamShake true;
                       addCamShake [5, 3, 30];
                       if (_showhypo) then{
                           titleText ["<t color='#c9701e' size='1' align='left' valign='bottom'>You have Hypothermia, seek fire and shelter</t><br/>", "PLAIN DOWN", 0.5, true, true];
                           player setVariable ["_TCTemperature", "Hypothermic"];
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
                               player setVariable ["_TCTemperature", "Hypothermic"];
                 };
                       };
                   };
               };
           };
           uiSleep 1;
           _TCexitColdwaters
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
