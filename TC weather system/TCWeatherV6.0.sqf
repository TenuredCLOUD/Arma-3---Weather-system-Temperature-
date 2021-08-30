//TCWeatherv5.sqf: v6.0 ~STABLE///

//** TCWeather by TenuredCLOUD aka "MuRaZorWitchKING" based off of Detrimental Weather effects by JohnO, rewritten by TenuredCLOUD with a GREAT amount of help from my good friend Haleks.**//

{

private ["_TCreset","_TCweath","_TCexitweather","_fire","_damage","_building","_clothes","_distanceToBuilding","_rainLevel","_distanceToFire","_showsickness","_showcoldness","TC_weatherCheck","_SuitableWeather","_sickness","_vehicle","_exitA","_exitB","_TCwet","_TCexitColdwaters","_showhypo","_showwetness","TCwater_effectsCheck","_SuitableWater","_hypothermia","_TCfrozen","_TCexitFrZregionfreezing","_showfreeze","_showFreezregion","TCFZ_effectsCheck","_StableRegion","_FZregionfreezing"];
 };

{

private _TCTemperature = ["Normal","Cold","freezing","wet","Hypothermic","Soaked","Warming Up...","Getting Sick...","Sick","Getting better...","Cold Elevation","Freezing and Drenched","Freezing from Weather","Sickness risk +","Hypothermia risk +"];
 };

_TCreset = player setVariable ["_TCTemperature", "Normal"];
_showsickness = true; //True to show sickness status.(rain, time of day)
_showcoldness = true; //Var
_showhypo = true; //True to show hypothermia status.(water)
_showwetness = true; //True to enable whether or not you are wet.
_showfreeze = true; //True to show FZregionfreezing status.(elevation)
_showFreezregion = true; //Var
TC_weatherCheck = 4; //Time in seconds that the script checks
sickness = false;
TCweath = false;
TCwater_effectsCheck = 4; //Time in seconds that the script checks
hypothermia = false;
TCwet = false;
TCFZ_effectsCheck = 4; //Time in seconds that the script checks
FZregionfreezing = false;
TCfrozen = false;
_StableRegion = true;
Freezregion = 0;
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
_TCTemperature = ["Normal","Cold","freezing","wet","Hypothermic","Soaked","Warming Up...","Getting Sick...","Sick","Getting better...","Cold Elevation","Freezing and Drenched","Freezing from Weather","Sickness risk +","Hypothermia risk +"];
_WarmClothes = ["U_I_Wetsuit_rvg",  "U_O_Wetsuit_rvg",  "U_B_Wetsuit_rvg",  "rvg_bandit",  "rvg_bandit_1",  "rvg_camo",  "rvg_camo_1",  "rvg_diamond",  "rvg_diamond_1",  "rvg_independant",  "rvg_independant_1",  "rvg_survivor",  "rvg_survivor_1","U_BG_Guerrilla_6_1NG","U_O_PilotCoveralls","U_O_FullGhillie_lsh","U_B_GhillieSuit", "U_C_WorkerCoverallsBandit","U_C_WorkerCoverallsBlack","U_C_WorkerCoverallsCamo"];
_WetClothes = ["U_I_Wetsuit_rvg",
"U_O_Wetsuit_rvg",
"U_B_Wetsuit_rvg",
"U_I_Wetsuit",
"U_O_Wetsuit",
"U_B_Wetsuit"];
_FZregionwarm = ["U_O_CombatUniform_oucamo"];

//debugger, keep **DO NOT REMOVE**
//0 spawn {
//	while {true} do {
//		hintSilent parseText format ["
//		<t size='1.15' align='left'>sickness: </t><t size='1.15' align='right'>%1</t><br/>
//		<t size='1.15' align='left'>sickValue: </t><t size='1.15' align='right'>%2</t><br/>
//		<t size='1.15' align='left'>coldness: </t><t size='1.15' align='right'>%3</t><br/>
//		<t size='1.15' align='left'>hypothermia: </t><t size='1.15' align='right'>%4</t><br/>
//		<t size='1.15' align='left'>hypoValue: </t><t size='1.15' align='right'>%5</t><br/>
//		<t size='1.15' align='left'>wetness: </t><t size='1.15' align='right'>%6</t><br/>
//		<t size='1.15' align='left'>FZregionfreezing: </t><t size='1.15' align='right'>%7</t><br/>
//		<t size='1.15' align='left'>freezeValue: </t><t size='1.15' align='right'>%8</t><br/>
//		<t size='1.15' align='left'>Freezregion: </t><t size='1.15' align='right'>%9</t><br/>
//		",
//		sickness,sickValue,coldness,hypothermia,hypoValue,wetness,FZregionfreezing,freezeValue,Freezregion
//		];
//		sleep 0.25;
//	};
//};

[sickness,sickValue,coldness,hypothermia,hypoValue,wetness,FZregionfreezing,freezeValue,Freezregion] spawn {
          _exitA = false;
          waituntil {
            if (!alive player) then {
                          sickness = false;
                          coldness = 0;
                          sickValue = 0;
                          hypothermia = false;
                          wetness = 0;
                          hypoValue = 0;
                          FZregionfreezing = false;
                          Freezregion = 0;
                          freezeValue = 0;
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
                              if (hypoValue <= 0) then  {
                                hypoValue = 0;
                              }else{
                                if (hypoValue >= 1) then  {
                                  hypoValue = 1;
                                };
                              };
                              if (wetness <= 0) then  {
                                wetness = 0;
                              }else{
                                if (wetness >= 1) then  {
                                  wetness = 0.9;
                                };
                              };
                              if (freezeValue <= 0) then  {
                                freezeValue = 0;
                              }else{
                                if (freezeValue >= 1) then  {
                                  freezeValue = 1;
                                };
                              };
                              if (Freezregion <= 0) then {
                                Freezregion = 0;
                              }else{
                                if (Freezregion >= 1) then {
                                  Freezregion = 0.9;
                                };
                              };
Sleep TC_weatherCheck;

Sleep TCwater_effectsCheck;

Sleep TCFZ_effectsCheck;

                _rainLevel = rain;
                _damage = damage player;
                _fire = nearestObject [player,"FirePlace_burning_F"];
                _distanceToFire = player distance _fire;
                _vehicle = vehicle player iskindOf "LandVehicle";
                _distanceToBuilding = player distance _building;
                _building = nearestBuilding player;
				        _clothes = uniform player;
                _TCTemperature = ["Normal","Cold","freezing","wet","Hypothermic","Soaked","Warming Up...","Getting Sick...","Sick","Getting better...","Cold Elevation","Freezing and Drenched","Freezing from Weather","Sickness risk +","Hypothermia risk +"];

        if (_rainLevel > 0.3 ) then {_SuitableWeather = false};

				if (daytime >= 18 || daytime < 7) then {_SuitableWeather = false};

				if !(player == vehicle player) then {_SuitableWeather = true};

        if (!_SuitableWeather && _distanceToFire < 5 || _distanceToBuilding < 20) then {_SuitableWeather = true};

				if (_clothes in _WarmClothes) then {_SuitableWeather = true};

        if ((underwater player) or (getPosASLW player select 2) < -1) then {_SuitableWater = false};

        if !(player == vehicle player) then {_SuitableWater = true};

        if (!_SuitableWater && _distanceToFire < 5 || _distanceToBuilding < 20) then {_SuitableWater = true};

        if (_clothes in _WetClothes) then {_SuitableWater = true};

        if ((getPosASL player select 2 )> 680) then {_StableRegion = false};

        if !(player == vehicle player) then {_StableRegion = true};

        if (!_StableRegion && _distanceToFire < 5 || _distanceToBuilding < 20) then {_StableRegion = true};

        if (_clothes in _FZregionwarm) then {_StableRegion = true};

        if (sickValue > 0.80) then {_txt = format ["<img shadow='0.2' size='1.5' image='%1' /><t size='1'>%2</t>", "images\microbesdeath.paa"];
        [_txt, safezoneX +  safezoneW - 0.65, safeZoneY + safezoneH - 0.2, 20, 0, 0, 888] spawn bis_fnc_dynamicText;
        hintSilent parseText format ["<t color='#b25905' size='1.15' align='left'>You are deathly ill </t><t size='1.15' align='left'>%1</t><br/>"];
      }else{

      if (sickValue > 0.30) then {_txt = format ["<img shadow='0.2' size='1.5' image='%1' /><t size='1'>%2</t>", "images\microbes1.paa"];
      [_txt, safezoneX +  safezoneW - 0.65, safeZoneY + safezoneH - 0.2, 20, 0, 0, 888] spawn bis_fnc_dynamicText;
    };
  };

        if (hypoValue > 0.80) then {_txt = format ["<img shadow='0.2' size='1.5' image='%1' /><t size='1'>%2</t>", "images\microbesdeath.paa"];
        [_txt, safezoneX +  safezoneW - 0.65, safeZoneY + safezoneH - 0.2, 20, 0, 0, 888] spawn bis_fnc_dynamicText;
        hintSilent parseText format ["<t color='#c9701e' size='1.15' align='left'>You are Hypothermic </t><t size='1.15' align='left'>%1</t><br/>"];
      }else{

      if (hypoValue > 0.30) then {_txt = format ["<img shadow='0.2' size='1.5' image='%1' /><t size='1'>%2</t>", "images\microbes1.paa"];
      [_txt, safezoneX +  safezoneW - 0.65, safeZoneY + safezoneH - 0.2, 20, 0, 0, 888] spawn bis_fnc_dynamicText;
      };
    };


        if (freezeValue > 0.80) then {_txt = format ["<img shadow='0.2' size='1.0' image='%1' /><t size='1'>%2</t>", "images\skullsnowflake.paa"];
        [_txt, safezoneX +  safezoneW - 0.65, safeZoneY + safezoneH - 0.2, 20, 0, 0, 888] spawn bis_fnc_dynamicText;
        hintSilent parseText format ["<t color='#a80b0b' size='1.15' align='left'>You are Freezing to death </t><t size='1.15' align='left'>%1</t><br/>"];
      }else{

      if (freezeValue > 0.30) then {_txt = format ["<img shadow='0.2' size='1.0' image='%1' /><t size='1'>%2</t>", "images\snowflake.paa"];
      [_txt, safezoneX +  safezoneW - 0.65, safeZoneY + safezoneH - 0.2, 20, 0, 0, 888] spawn bis_fnc_dynamicText;
    };
  };

//Rain, time of day //
        if (_SuitableWeather) then {
                            _SuitableWeather = true;
                            coldness = coldness - 0.1;
                            if (coldness <= 0) then  {
                              if (sickValue >= 0) then  {
                                sickValue = sickValue - 0.01;
                                if (sickValue <= 0.25) then {
                                  sickness = false;
                                  TCweath = false;
                                  enableCamShake false;
                                  player enableStamina false;
                                  player allowSprint true;
                                  Sleep 1;
                                  if ((_showsickness) && (sickValue >= 0 && sickValue <= 0.25)) then { player setVariable ["_TCTemperature", "Normal"];

                                    };
                                  };
                                };
                              };

                          }else{
                              _SuitableWeather  = false;
                              coldness = coldness + 0.1;
                              TCweath = true;
                            };
//water//
        if (_SuitableWater) then  {
                        _SuitableWater = true;
                        wetness = wetness - 0.1;
                        if (wetness <= 0) then {
                          if (hypoValue >= 0) then {
                            hypoValue = hypoValue - 0.01;
                            if (hypoValue <= 0.25) then {
                              hypothermia = false;
                              TCwet = false;
                              enableCamShake false;
                              player enableStamina false;
                              player allowSprint true;
                              Sleep 1;
                              if ((_showhypo) && (hypoValue >= 0 && hypoValue <= 0.25)) then {  player setVariable ["_TCTemperature", "Normal"];

                              };
                            };
                          };
                        };

                        }else{
                          _SuitableWater = false;
                          wetness = wetness + 0.1;
                          TCwet = true;
                        };
//Elevation//
        if (_StableRegion) then {
            _StableRegion = true;
              Freezregion = Freezregion - 0.1;
                if (Freezregion <= 0) then {
                  if (freezeValue >= 0) then {
                    freezeValue = freezeValue - 0.01;
                    if (freezeValue <= 0.25) then {
                      FZregionfreezing = false;
                      TCfrozen = false;
                      enableCamShake false;
                      player enableStamina false;
                      player allowSprint true;
                      Sleep 1;
                      if ((_showfreeze) && (freezeValue >= 0 && freezeValue <= 0.25)) then  { player setVariable ["_TCTemperature", "Normal"];

                        };
                      };
                    };
                  };

                }else{
                  _StableRegion = false;
                  Freezregion = Freezregion + 0.1;
                  TCfrozen = true;
                };
//Rain, time of day coldness (basic ailment)//
                if (_showcoldness && !_SuitableWeather) then  {
                  if (coldness >= 0 && coldness <=0.1)  then  {
                    titleText ["<t color='#ffffff' size='1' align='left' valign='bottom'>You are getting cold</t><br/>", "PLAIN DOWN", 0.5, true, true];
                    //cutText [selectrandom ["It's starting to get cold.","My clothes aren't suited for this weather.","Time to find shelter.","I'm gonna freeze soon."], "PLAIN DOWN", 2];
                    player setVariable ["_TCTemperature", "Cold"];
                  }else{
                    if (coldness >= 0.2 && coldness <= 0.3)  then  {
                        titleText ["<t color='#42aaf4' size='1' align='left' valign='bottom'>You are starting to freeze</t><br/>", "PLAIN DOWN", 0.5, true, true];
                        //cutText [selectrandom ["I really need to find shelter.","This isn't worth being this cold.","Brrrr..."], "PLAIN DOWN", 2];
                        player setVariable ["_TCTemperature", "freezing"];
                         };
                      };
                    }else{
                      if (_SuitableWeather &&  TCweath) then{
                          if ((_showcoldness) && (coldness <= 0.9)) then{
                            player setVariable ["_TCTemperature", "Warming Up..."];
                            _txt = format ["<img shadow='0.2' size='1.0' image='%1' /><t size='1'>%2</t>", "images\thermometerwu+.paa"];
                            [_txt, safezoneX +  safezoneW - 0.65, safeZoneY + safezoneH - 0.2, 10, 0, 0, 888] spawn bis_fnc_dynamicText;
                          };
                        };
                        if (_SuitableWeather &&  TCweath) then{
                            if ((_showcoldness) && (coldness <= 0.1)) then{
                              player setVariable ["_TCTemperature", "Normal"];
                            };
                          };
                        };

//Elevation coldness (basic ailment)//
                         if (_showFreezregion && !_StableRegion) then  {
                           if (Freezregion >= 0 && Freezregion <=0.1) then  {
                            titleText ["<t color='#ffffff' size='1' align='left' valign='bottom'>You are very, very cold.</t><br/>", "PLAIN DOWN", 0.5, true, true];
                            //cutText [selectrandom ["If I stay up here I'm going to freeze.","I definitely am not geared for this elevation.","I need warmer clothing."], "PLAIN DOWN", 2];
                            player setVariable ["_TCTemperature", "Cold Elevation"];
                            }else{
                              if (Freezregion >= 0.2 && Freezregion <= 0.3) then  {
                                  titleText ["<t color='#42aaf4' size='1' align='left' valign='bottom'>You are going to freeze to death...</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                  //cutText [selectrandom ["I can't feel my fingers.","My face is going numb...","It's way too cold, I shouldn't be here."], "PLAIN DOWN", 2];
                                  player setVariable ["_TCTemperature", "freezing"];
                                   };
                                 };
                               }else{
                                 if (_StableRegion &&  TCfrozen) then{
                                     if ((_showFreezregion) && (Freezregion <= 0.9)) then{
                                       player setVariable ["_TCTemperature", "Warming Up..."];
                                       _txt = format ["<img shadow='0.2' size='1.0' image='%1' /><t size='1'>%2</t>", "images\thermometerwu+.paa"];
                                       [_txt, safezoneX +  safezoneW - 0.65, safeZoneY + safezoneH - 0.2, 10, 0, 0, 888] spawn bis_fnc_dynamicText;
                                     };
                                   };
                                   if (_StableRegion  &&  TCfrozen) then {
                                     if ((_showFreezregion)  &&  (Freezregion <=  0.1)) then {
                                         player setVariable ["_TCTemperature", "Normal"];
                                        };
                                       };
                                     };

//Water coldness (basic ailment)//
                                   if (_showwetness && !_SuitableWater) then  {
                                     if (wetness >= 0 && wetness <=0.1) then  {
                                      titleText ["<t color='#ffffff' size='1' align='left' valign='bottom'>You are wet</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                      //cutText [selectrandom ["This water is cold!","I need a diving suit if I'm going to swim in this!"], "PLAIN DOWN", 2];
                                      player setVariable ["_TCTemperature", "wet"];
						                                }else{
                                        if  (wetness >= 0.2 && wetness <= 0.3)  then  {
                                          titleText ["<t color='#42aaf4' size='1' align='left' valign='bottom'>You are Soaked</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                        //  cutText [selectrandom ["Why did I go in the water?!","My clothes are Soaked!","I need to build a fire and dry off!"], "PLAIN DOWN", 2];
                                            player setVariable ["_TCTemperature", "Soaked"];
                                          };
                                        };
                                      }else{
                                        if (_SuitableWater &&  TCwet) then{
                                            if ((_showwetness) && (wetness <= 0.9)) then{
                                              player setVariable ["_TCTemperature", "Warming Up..."];
                                              _txt = format ["<img shadow='0.2' size='1.0' image='%1' /><t size='1'>%2</t>", "images\thermometerwu+.paa"];
                                              [_txt, safezoneX +  safezoneW - 0.65, safeZoneY + safezoneH - 0.2, 10, 0, 0, 888] spawn bis_fnc_dynamicText;
                                              //hintSilent parseText format ["<t color='#FFA600' size='1' align='left' valign='top'>You are Warming Up.</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                            };
                                          };
                                          if (_SuitableWater  &&  TCwet)  then {
                                            if((_showwetness) &&  (wetness  <=  0.1)) then {
                                              player setVariable ["_TCTemperature", "Normal"];
                                            };
                                          };
                                        };

Sleep TC_weatherCheck;

Sleep TCwater_effectsCheck;

Sleep TCFZ_effectsCheck;

                if (coldness > 0.3 && !_SuitableWeather) then {
                        coldness = coldness + 0.1;
                        player setDamage _damage +0.01;
                        enableCamShake true;
                        addCamShake [1, 5, 10];
                        if (_showcoldness) then {
                                titleText ["<t color='#00BEFF' size='1' align='left' valign='bottom'>You are freezing, find shelter immediately</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                //cutText [selectrandom ["'shivers'","'warms hands with breath'"], "PLAIN DOWN", 2];
                                player setVariable ["_TCTemperature", "Freezing from Weather"];
						                        };
                                  };
                if (wetness > 0.3 && !_SuitableWater) then  {
                    wetness = wetness + 0.1;
                    player setDamage _damage +0.01;
                    enableCamShake true;
                    addCamShake [1, 5, 10];
                    if (_showwetness) then  {
                          titleText ["<t color='#00BEFF' size='1' align='left' valign='bottom'>You are freezing and Drenched.</t><br/>", "PLAIN DOWN", 0.5, true, true];
                          //cutText [selectrandom ["If I don't dry off I'm going to die..","I need a fire and shelter!","I can't feel my hands, or my feet, my face is numb too..."], "PLAIN DOWN", 2];
                            player setVariable ["_TCTemperature", "Freezing and Drenched"];
                          };
                        };
                if (Freezregion > 0.3 && !_StableRegion) then  {
                    Freezregion = Freezregion + 0.1;
                    player setDamage _damage +0.01;
                    enableCamShake true;
                    addCamShake [1, 5, 10];
                    if (_showFreezregion) then {
                        titleText ["<t color='#00BEFF' size='1' align='left' valign='bottom'>You are freezing from too high of Elevation.</t><br/>", "PLAIN DOWN", 0.5, true, true];
                        //cutText [selectrandom ["I definitely shouldn't be up here..","I'm going to die if I stay much longer...","I don't know how much longer I can bear this cold."], "PLAIN DOWN", 2];
                        player setVariable ["_TCTemperature", "freezing"];
                        };
                  };
                            /////Below needs tweaking for FULL script to take effect. Lines 418 - end of code. Tweaking values should prove persistence. Or even vars. /////done on 6/15/20
//sickness settings (advanced ailment)//
                          if (!_SuitableWeather && coldness > 0.5 ) then  {
                            _sickChance = random 1;

                        if (_sickChance > 0.2 || sickValue > 0) then  {
                          sickness = true;
                          sickValue = sickValue + 0.05;

                          if (_showsickness && sickValue < 0.30) then {

                            //titleText ["<t color='#b25905' size='1' align='left' valign='bottom'>Sickness Risk +</t><br/>", "PLAIN DOWN", 0.5, true, true];
                            //cutText [selectrandom ["I don't feel good.","I think I'm getting sick..."], "PLAIN DOWN", 2];
                            player setVariable ["_TCTemperature", "illness Risk"];
                          };

                          if (sickValue > 0.30 && sickValue < 0.80) then
                            {

                              player enableStamina false;
                              player allowSprint false;
                              enableCamShake true;
                              addCamShake [5, 3, 30];

                              if (_showsickness) then {
                                titleText ["<t color='#c9701e' size='1' align='left' valign='bottom'>You are sick</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                //cutText [selectrandom ["My throat is scratchy...","*Cough* *Cough*","My throat is killing me...","I feel hot...","I don't feel good at all..."], "PLAIN DOWN", 2];
                                player setVariable ["_TCTemperature", "Sick"];
                              };

                              }else{

                                if (sickValue > 0.80) then  {

                                  player enableStamina false;
                                  player allowSprint false;
                                  enableCamShake true;
                                  addCamShake [10, 10, 15];
                                  player setDamage _damage + 0.01;

                                  if (_showsickness) then {
                                            titleText ["<t color='#a80b0b' size='1' align='left' valign='bottom'>You are very sick</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                            //cutText [selectrandom ["I think I'm going to die...","...","... ...","'wheezing'","'panting'"], "PLAIN DOWN", 2];
                                            player setVariable ["_TCTemperature", "Sick"];

                                                      };
                                                    };
                                                  };
                                                }; //Put these two brackets at ending of eack code block for different "ailment markers" **Marked below**VV
                                              }; //
                                                      if (_SuitableWeather && sickness) then  {
                                                        if (_showsickness && sickValue < 0.30) then {
                                                                titleText ["<t color='#90a014' size='1' align='left' valign='bottom'>Sickness risk -</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                                                //cutText [selectrandom ["I think I'm getting better...","I feel a bit better."], "PLAIN DOWN", 2];
                                                                  player setVariable ["_TCTemperature", "Getting better..."];
                                                                };
                                                              };

                                                                if (sickValue > 0.30 && sickValue < 0.80) then {
                                                                        enableCamShake true;
                                                                        addCamShake [5, 3, 30];
                                                                        if (_showsickness) then {
                                                                                  titleText ["<t color='#c9701e' size='1' align='left' valign='bottom'>You are sick</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                                                                  //cutText [selectrandom ["My throat is scratchy...","*Cough* *Cough*","My throat is killing me...","I feel hot...","I don't feel good at all..."], "PLAIN DOWN", 2];
                                                                                  player setVariable ["_TCTemperature", "Sick"];
                                        								                                };

                                                                                          }else{

                                                                                            if (sickValue > 0.80) then  {
                                                                                              player enableStamina false;
                                                                                              player allowSprint false;
                                                                                              enableCamShake true;
                                                                                              addCamShake [10, 10, 15];
                                                                                              player setDamage _damage + 0.01;

                                                                                              if (_showsickness) then {
                                                                                                      //  titleText ["<t color='#a80b0b' size='1' align='left' valign='bottom'>You are very sick.</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                                                                                      //cutText [selectrandom ["...","... ...","I'm so... c.. cold"], "PLAIN DOWN", 2];
                                                                                                        player setVariable ["_TCTemperature", "Sick"];
                                                      										                                      };
                                                                                                              }; // Move them here under this code block for each differnt ailment type if different effects are wanted. <<
                                                                                                            }; //<<
//hypothermia settings (advanced ailment)//
                          if (!_SuitableWater && wetness > 0.5 ) then {
                            _hypoChance = random 1;

                            if (_hypoChance > 0.2 || hypoValue > 0) then  {
                              hypothermia = true;
                              hypoValue = hypoValue + 0.05;

                              if (_showhypo && hypoValue < 0.30) then {

                                //titleText ["<t color='#C9FF00' size='1' align='left' valign='bottom'>Hypothermia Risk +</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                player setVariable ["_TCTemperature", "illness Risk"];
                              };

                              if (hypoValue > 0.30 && hypoValue < 0.80) then
                                {

                                  player enableStamina false;
                                  player allowSprint false;
                                  enableCamShake true;
                                  addCamShake [5, 3, 30];

                                  if (_showhypo) then {
                                    titleText ["<t color='#c9701e' size='1' align='left' valign='bottom'>You have Hypothermia</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                    player setVariable ["_TCTemperature", "Hypothermic"];
                                  };

                                  }else{

                                    if (hypoValue > 0.80) then  {

                                      player enableStamina false;
                                      player allowSprint false;
                                      enableCamShake true;
                                      addCamShake [10, 10, 15];
                                      [120] call BIS_fnc_bloodEffect;
                                      player setDamage _damage + 0.01;

                                      if (_showhypo) then {
                                                titleText ["<t color='#a80b0b' size='1' align='left' valign='bottom'>You have severe Hypothermia</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                                player setVariable ["_TCTemperature", "Hypothermic"];
                                              };
                                            };
                                          };
                                        };
                                      };
                                              if (_SuitableWater && hypothermia) then {
                                                if (_showhypo && hypoValue < 0.30) then {
                                                            titleText ["<t color='#FFB700' size='1' align='right' valign='bottom'>You are warming up.</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                                            player setVariable ["_TCTemperature", "Getting better..."];
                                                          };
                                                        };

                                                          if (hypoValue > 0.30 && hypoValue < 0.80) then  {
                                                                  enableCamShake true;
                                                                  addCamShake [5, 3, 30];
                                                                 if (_showhypo) then  {
                                                                   titleText ["<t color='#c9701e' size='1' align='left' valign='bottom'>You have Hypothermia</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                                                   player setVariable ["_TCTemperature", "Hypothermic"];
                                                                 };

                                                                  }else{

                                                                    if (hypoValue > 0.80) then  {
                                                                      player enableStamina false;
                                                                      player allowSprint false;
                                                                      enableCamShake true;
                                                                      addCamShake [10, 10, 15];
                                                                      [120] call BIS_fnc_bloodEffect;
                                                                      player setDamage _damage + 0.01;

                                                                      if (_showhypo) then {
                                                                                //titleText ["<t color='#a80b0b' size='1' align='left' valign='bottom'>You are Dying of Hypothermia...</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                                                                player setVariable ["_TCTemperature", "Hypothermic"];
                                                                              };
                                                                            };
                                                                          };
//freezing settings (advanced ailment)//
                              if (!_StableRegion && Freezregion > 0.5 ) then {
                                _freezeChance = random 1;

                                if (_freezeChance > 0.2 || freezeValue > 0) then  {
                                  FZregionfreezing = true;
                                  freezeValue = freezeValue + 0.05;

                                if (_showfreeze && freezeValue < 0.30) then {

                                  titleText ["<t color='#b25905' size='1' align='left' valign='bottom'>freezing Risk +</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                  player setVariable ["_TCTemperature", "Freeze Risk"];
                                };
                                if (freezeValue > 0.30 && freezeValue < 0.80) then
                                  {

                                        player enableStamina false;
                                        player allowSprint false;
                                        enableCamShake true;
                                        addCamShake [5, 3, 30];

                                        if (_showfreeze) then {
                                          titleText ["<t color='#c9701e' size='1' align='left' valign='bottom'>You are freezing</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                          player setVariable ["_TCTemperature", "freezing"];
                                        };

                                }else{

                                        if (freezeValue > 0.80) then  {


                                                player enableStamina false;
                                                player allowSprint false;
                                                enableCamShake true;
                                                addCamShake [10, 10, 15];
                                                [120] call BIS_fnc_bloodEffect;
                                                player setDamage _damage + 0.01;

                                                if (_showfreeze) then {
                                                          titleText ["<t color='#a80b0b' size='1' align='left' valign='bottom'>You are freezing from the cold</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                                          player setVariable ["_TCTemperature", "freezing"];
                                                        };
                                                      };
                                                    };
                                                  };
                                                };

                                                if  (_StableRegion && FZregionfreezing) then {
                                                  if (_showfreeze && freezeValue < 0.30) then {
                                                    titleText ["<t color='#90a014' size='1' align='left' valign='bottom'>freezing risk -</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                                    player setVariable ["_TCTemperature", "Getting better..."];
                                                  };
                                                };

                        if (freezeValue > 0.30 && freezeValue < 0.80) then  {
                                enableCamShake true;
                                addCamShake [5, 3, 30];
                                if (_showfreeze) then {
                                  titleText ["<t color='#c9701e' size='1' align='left' valign='bottom'>You are freezing</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                  player setVariable ["_TCTemperature", "freezing"];
                                };

                        }else{

                                      if (freezeValue > 0.80) then {
                                        player enableStamina false;
                                        player allowSprint false;
                                        enableCamShake true;
                                        addCamShake [10, 10, 15];
                                        [120] call BIS_fnc_bloodEffect;
                                        player setDamage _damage + 0.01;

                                        if (_showfreeze) then {
                                                  //titleText ["<t color='#a80b0b' size='1' align='left' valign='bottom'>You are dying from the cold...</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                                  player setVariable ["_TCTemperature", "freezing"];
                                                };
                                              };
                                            };
                                            //End of ailments (sickness, hypothermia, freezing)
                                            };  //End of line 138
                                            Sleep 1;
                                            _TCexitweather
                                            };  //end of script, begin loop ^ Back to line 137
