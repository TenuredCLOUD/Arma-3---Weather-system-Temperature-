//TCWeatherv5.sqf: v5.2 ~STABLE///

//** TCWeather by TenuredCLOUD based off of Detrimental Weather effects by JohnO rewritten by TenuredCLOUD **//

{

private ["_TCreset","_TCweath","_TCexitweather","_fire","_damage","_building","_clothes","_distanceToBuilding","_rainLevel","_distanceToFire","_showsickness","_showcoldness","TC_weatherCheck","_SuitableWeather","_sickness","_vehicle","_exitA","_exitB","_TCwet","_TCexitColdwaters","_showhypo","_showwetness","TCwater_effectsCheck","_hypothermia","_TCfrozen","_TCexitFrZregionfreezing","_showfreeze","_showFreezing","TCFZ_effectsCheck","_FZregionfreezing"];
 };

{

private _TCTemperature = ["","v","V","wet","Hypothermic","Soaked","^","v~","V~","^~"];
 };

_TCreset = player setVariable ["_TCTemperature", ""];
_showsickness = true; //True to show sickness status.
_showcoldness = true; //Var
_showhypo = true; //True to show hypothermia status.
_showwetness = true; //True to enable whether or not you are wet.
_showfreeze = true; //True to show FZregionfreezing status.
_showFreezing = true; //Var
TC_weatherCheck = 10; //Time in seconds that the script fires. multiply by x2**//
sickness = false;
TCweath = false;
TCwater_effectsCheck = 15; //Time in seconds that the script fires. multiply by x2**//
hypothermia = false;
TCwet = false;
TCFZ_effectsCheck = 30; //Time in seconds that the script fires. multiply by x2**//
FZregionfreezing = false;
TCfrozen = false;
Freezing = 0;
_freezeChance = 0;
freezeValue = 0;
_SuitableWeather = true;
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
_TCTemperature = ["","v","V","wet","Hypothermic","Soaked","^","v~","V~","^~"];
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

[sickness,sickValue,coldness] spawn {
          _exitA = false;
          waituntil {
            if (!alive player) then {
                          sickness = false;
                          coldness = 0;
                          sickValue = 0;
                          player enableStamina false;
                          player allowSprint true;
                        };
                        Sleep 1;
                        _exitA
                      };
                    };

[] spawn  {
        _exitB = false;
        waituntil {
                if (damage player > 0.75) then  {
                        enableCamShake true;
                        addCamShake [5, 3, 30];
                        [120] call BIS_fnc_bloodEffect;
						                  Sleep 5;
				                        };
                                Sleep 1;
                                _exitB
                              };
                            };

_TCexitweather = false;
waitUntil {
        if (alive player) then  {

                              if (sickValue <= 0) then  {
                                sickValue = 0;
                                }else{
                                  if (sickValue >= 1) then  {
                                sickValue = 1;
                              };
                            };
                            if (coldness <= 0) then {
                              coldness = 0;
                            }else{
                              if (coldness >= 1) then {
                                  coldness = 0.9;
                                };
                              };

Sleep TC_weatherCheck;


                _TCreset = player setVariable ["_TCTemperature", ""];
                _rainLevel = rain;
                _damage = damage player;
                _fire = nearestObject [player,"FirePlace_burning_F"];
                _distanceToFire = player distance _fire;
                _vehicle = vehicle player iskindOf "LandVehicle";
                _distanceToBuilding = player distance _building;
                _building = nearestBuilding player;
				        _clothes = uniform player;
                _TCTemperature = ["","v","V","wet","Hypothermic","Soaked","^","v~","V~","^~"];

        if (_rainLevel > 0.3 ) then {_SuitableWeather = false};

				if (daytime >= 18 || daytime < 7) then {_SuitableWeather = false};

				if !(player == vehicle player) then {_SuitableWeather = true};

        if (!_SuitableWeather && _distanceToFire < 5 || _distanceToBuilding < 20) then {_SuitableWeather = true};

				if (_clothes in _WarmClothes) then {_SuitableWeather = true};

        if ((underwater player) or (getPosASLW player select 2) < -1) then {_SuitableWeather = false};

        if (_clothes in _WetClothes) then {_SuitableWeather = true};

        if ((getPosASL player select 2 )> 680) then {_SuitableWeather = false};

        if (_clothes in _FZregionwarm) then {_SuitableWeather = true};

        if (_SuitableWeather) then {
          _TCreset  = true;
        }else{
          if !(_SuitableWeather) then {
            _TCreset  = false;
        };
      };

        if (_SuitableWeather) then {
                            _SuitableWeather = true;
                            coldness = coldness - 0.1;
                            if (coldness <= 0) then  {
                              if (sickValue >= 0) then  {
                                sickValue = sickValue - 0.05;
                                if (sickValue <= 0.25) then {
                                  sickness = false;
                                  TCweath = false;
                                                enableCamShake false;
                                                player enableStamina false;
                                                player allowSprint true;
                                                Sleep 1;
                                                if ((_showsickness) && (sickValue >= 0 && sickValue <= 0.25)) then { _TCreset  = true;
                                                  };
                                                };
                                              };
                                            };
                                        }else{
                                            _SuitableWeather  = false;
                                              coldness = coldness + 0.1;
                                              TCweath = true;
                                            };

                if (_showcoldness && !_SuitableWeather) then  {
                  if (coldness >= 0 && coldness <=0.1)  then  {
                    titleText ["<t color='#ffffff' size='1' align='left' valign='bottom'>You are getting cold</t><br/>", "PLAIN DOWN", 0.5, true, true];
                    player setVariable ["_TCTemperature", "v"];
                  }else{
                    if (coldness >= 0.2 && coldness <= 0.3)  then  {
                        titleText ["<t color='#42aaf4' size='1' align='left' valign='bottom'>You are starting to freeze</t><br/>", "PLAIN DOWN", 0.5, true, true];
                        player setVariable ["_TCTemperature", "V"];
                         };
                      };
                    }else{
                      if (_SuitableWeather &&  TCweath) then{
                          if ((_showcoldness) && (coldness <= 0.2)) then{
                            player setVariable ["_TCTemperature", "^"];
                          };
                        };
                      };

Sleep TC_weatherCheck;


                if (coldness > 0.3 && !_SuitableWeather) then {
                        coldness = coldness + 0.1;
                        player setDamage _damage +0.01;
                        enableCamShake true;
                        addCamShake [1, 5, 10];
                        if (_showcoldness) then {
                                titleText ["<t color='#00BEFF' size='1' align='left' valign='bottom'>You are freezing, find shelter immediately</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                player setVariable ["_TCTemperature", "V"];
						                        };
                                  };
                if (!_SuitableWeather && coldness > 0.3 ) then  {
                  _sickChance = random 1;

                        if (_sickChance > 0.2 || sickValue > 0) then  {
                          sickness = true;
                          sickValue = sickValue + 0.05;

                                if (_showsickness && sickValue < 0.25) then {

                                  titleText ["<t color='#b25905' size='1' align='left' valign='bottom'>Sickness Risk +</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                  player setVariable ["_TCTemperature", "v~"];
                                };

                                if (sickValue > 0.25 && sickValue < 0.50) then
                                  {

                                        player enableStamina false;
                                        player allowSprint false;
                                        enableCamShake true;
                                        addCamShake [5, 3, 30];


                                        if (_showsickness) then {
                                          titleText ["<t color='#c9701e' size='1' align='left' valign='bottom'>You are sick, seek fire and shelter</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                          player setVariable ["_TCTemperature", "V~"];
                                        };

                                }else{
                                        if (sickValue > 0.50) then  {

                                                player enableStamina false;
                                                player allowSprint false;
                                                enableCamShake true;
                                                addCamShake [10, 10, 15];
                                                [120] call BIS_fnc_bloodEffect;
                                                player setDamage _damage + 0.02;


                                                if (_showsickness) then {
                                                          titleText ["<t color='#a80b0b' size='1' align='left' valign='bottom'>You are Dying from Sickness...</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                                          player setVariable ["_TCTemperature", "V~"];

												                                            };
                                                      };
                                                    };
                                                  };
                                                };
                if (_SuitableWeather && sickness) then  {


                        if (_showsickness && sickValue < 0.25) then {
                                  titleText ["<t color='#90a014' size='1' align='left' valign='bottom'>Sickness risk -</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                  player setVariable ["_TCTemperature", "^~"];
                                };

                        if (sickValue > 0.25 && sickValue < 0.50) then {
                                enableCamShake true;
                                addCamShake [5, 3, 30];
                                if (_showsickness) then {
                                          titleText ["<t color='#c9701e' size='1' align='left' valign='bottom'>You are sick, seek fire and shelter</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                          player setVariable ["_TCTemperature", "V~"];
								                                };
                        }else{
                                  if (sickValue > 0.50) then  {
                                        player enableStamina false;
                                        player allowSprint false;
                                        enableCamShake true;
                                        addCamShake [10, 10, 15];
                                        [120] call BIS_fnc_bloodEffect;
                                        player setDamage _damage + 0.03;


                                        if (_showsickness) then {
                                                  titleText ["<t color='#a80b0b' size='1' align='left' valign='bottom'>You are Dying of Sickness...</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                                  player setVariable ["_TCTemperature", "V~"];
										                                      };
                                              };
                                            };
                                          };
                                        };
                                        Sleep 1;
                                        _TCexitweather
                                      };
