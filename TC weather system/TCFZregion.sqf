//TCColdRegion.sqf: v1.0

//** TCColdRegion by TenuredCLOUD **//
{

private _Temperature = ["cold", "wet", "freezing", "Normal", "Soaked", "Hot", "Hypothermic", "Warming Up...","Getting Sick..."];
 
//private _Temperature = player getVariable "Temperature";
 
 };
MRZ_effectsCheck = 30; 
_Temperature = ["cold", "wet", "freezing", "Normal", "Soaked", "Hot", "Hypothermic", "Warming Up...", "Getting Sick..."];

[] spawn {
while {alive player} do {
waituntil{ 
if((getPosASL player select 2 )> 680 && vehicle player isEqualTo player && uniform player != "CUP_I_B_PMC_Unit_26") then {

    systemchat"";
    
    player setdamage damage player + 0.02;
    enableCamShake true;
    addCamShake [5, 3, 60];  

    cutText [selectrandom["'gasp' 'gasp' This cold takes my breath away.","'Ugh' The winds are too strong up here.","It's very cold.","I need warmer clothes.","My Ears and nose are burning from the cold."], "PLAIN DOWN", 0.5, true, true];
		
    player say3D [selectrandom ["WoundedGuyA_02","WoundedGuyA_01","WoundedGuyA_03","WoundedGuyA_07","WoundedGuyA_05","WoundedGuyA_06","WoundedGuyA_08"], 15, 1];
	
	player setVariable ["_Temperature", "freezing"];
 
 uiSleep MRZ_effectsCheck;
    } else {
    
    systemchat"";
    
uiSleep MRZ_effectsCheck;
    };
    };
    };
};
