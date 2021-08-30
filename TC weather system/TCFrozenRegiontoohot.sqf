//TCColdRegion.sqf: v1.0

//** TCColdRegionTooHot by TenuredCLOUD **//
{

private _Temperature = ["cold", "wet", "freezing", "Normal", "Soaked", "Hot", "Hypothermic", "Warming Up...","Getting Sick...","Cooling off..."];
 
//private _Temperature = player getVariable "Temperature";
 
 };
MRZ_effectsCheck = 30;
_Temperature = ["cold", "wet", "freezing", "Normal", "Soaked", "Hot", "Hypothermic", "Warming Up...", "Getting Sick...","Cooling off..."];

[] spawn {
while {alive player} do {
waituntil{ 
if((getPosASL player select 2 )< 680 && uniform player == "CUP_I_B_PMC_Unit_29") then {

    systemchat"";
    
    player setdamage damage player + 0.02;
    enableCamShake false;
    addCamShake [5, 3, 60];  

    cutText [selectrandom["'gasp' 'gasp' This damn jacket is too hot!","'Ugh' My head is pounding...","It's too hot.","I need to remove some clothes."], "PLAIN DOWN", 0.5, true, true];
		
    player say3D [selectrandom ["WoundedGuyA_02","WoundedGuyA_01","WoundedGuyA_03","WoundedGuyA_07","WoundedGuyA_05","WoundedGuyA_06","WoundedGuyA_08"], 15, 1];
	
	player setVariable ["_Temperature", "Hot"];
 
 uiSleep MRZ_effectsCheck;
    } else {
    
    systemchat"";
    player setVariable ["_Temperature", "Normal"];
uiSleep MRZ_effectsCheck;
    };
    };
	};
};
