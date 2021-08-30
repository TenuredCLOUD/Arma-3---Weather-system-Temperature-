


//________________  Author : TenuredCLOUD ___________ 03.24.20 _____________

/*
________________ TenuredCLOUD Temperature Status effect ________________

include this in your initPlayerLocal :

[] execVM "TC_Status\TCTempbar.sqf";
*/

waitUntil {!(isNull (findDisplay 46))};
disableSerialization;

[] spawn
{
	_uid = getPlayerUID player;

	while {true} do
	{

	sleep 0.01;

	_rscLayer = "RscStatusBar" call BIS_fnc_rscLayer;
	_rscLayer cutRsc ["RscStatusBar","PLAIN",1,false];


	if(isNull ((uiNamespace getVariable "RscStatusBar")displayCtrl 55554)) then
	{
	diag_log "statusbar is null create";
	disableSerialization;
	_rscLayer = "RscStatusBar" call BIS_fnc_rscLayer;
	_rscLayer cutRsc ["RscStatusBar","PLAIN",1,false];

	};

_Temp = player getVariable ["_TCTemperature", "Normal"];
//_Temp = selectRandom _Temperature;
_hydration = player getVariable ["thirst", 100];
_nutrition = player getVariable ["hunger", 100];

//________________ Color Gradient ________________
//Additional color codes can be found here:  http://html-color-codes.com/
_colour_Default 	= parseText "#FBFCFE";
_colour90 			= parseText "#F5E6EC";
_colour80 			= parseText "#F0D1DB";
_colour70 			= parseText "#EBBBC9";
_colour60 			= parseText "#E6A6B8";
_colour50 			= parseText "#E191A7";
_colour40 			= parseText "#DB7B95";
_colour30 			= parseText "#D66684";
_colour20 			= parseText "#D15072";
_colour10 			= parseText "#CC3B61";
_colour0 			= parseText "#C72650";
_colourDead 		= parseText "#000000";

//________________ Color Gradient ________________
_color_TDefault     = parseText "#FBFCFE";
_colornormal 	    = parseText "#FBFCFE";
_colorcold 	        = parseText "#00DAFF";
_colorFreezing	    = parseText "#0011FF";
_colorWet 	        = parseText "#7CDAFF";
_colorhypothermic   = parseText "#64008B";
_colorsoaked 	    = parseText "#00A0FF";
_colorwarming 		= parseText "#FFA000";
_colorsick 		    = parseText "#C9FF00";
_colorsickness 		= parseText "#99C200";
_colorsickbetter 	= parseText "#ECDF00";
_colorverysick    	= parseText "#D55DFF";

//________________ Changing Colour based on Temperature ________________
_color_thermo = _color_TDefault;
 switch _Temp do
 {
 case (_Temp == "") : {_color_thermo = _colornormal;};
 case (_Temp == "v") : {_color_thermo =  _colorcold;};
 case (_Temp == "V") : {_color_thermo =  _colorFreezing;};
 case (_Temp == "wet") : {_color_thermo =  _colorWet;};
 case (_Temp == "Hypothermic") : {_color_thermo =  _colorhypothermic;};
 case (_Temp == "Soaked") : {_color_thermo =  _colorsoaked;};
 case (_Temp == "^") : {_color_thermo =  _colorwarming;};
 case (_Temp == "v~") : {_color_thermo =  _colorsick;};
 case (_Temp == "V~") : {_color_thermo =  _colorsickness;};
 case (_Temp == "^~") : {_color_thermo =  _colorsickbetter;};
};

//_color_thermo = _color_TDefault;
 // if !(_Temp == "Normal") then {_color_thermo = _colornormal;};
 // if !(_Temp == "Cold") then {_color_thermo =  _colorcold;};
 // if !(_Temp == "freezing") then {_color_thermo =  _colorFreezing;};
 // if !(_Temp == "wet") then {_color_thermo =  _colorWet;};
 // if !(_Temp == "Hypothermic") then {_color_thermo =  _colorhypothermic;};
 // if !(_Temp == "Hot") then {_color_thermo =  _colorhot;};
 // if !(_Temp == "Soaked") then {_color_thermo =  _colorsoaked;};

//________________ Changing Colour based on Thirst ________________
_colour_Hydration = _colour_Default;
switch true do
	{
	case(_hydration >= 100) : {_colour_Hydration = _colour_Default;};
	case((_hydration >= 90) && (_hydration < 100)) :  {_colour_Hydration =  _colour90;};
	case((_hydration >= 80) && (_hydration < 90)) :  {_colour_Hydration =  _colour80;};
	case((_hydration >= 70) && (_hydration < 80)) :  {_colour_Hydration =  _colour70;};
	case((_hydration >= 60) && (_hydration < 70)) :  {_colour_Hydration =  _colour60;};
	case((_hydration >= 50) && (_hydration < 60)) :  {_colour_Hydration =  _colour50;};
	case((_hydration >= 40) && (_hydration < 50)) :  {_colour_Hydration =  _colour40;};
	case((_hydration >= 30) && (_hydration < 40)) :  {_colour_Hydration =  _colour30;};
	case((_hydration >= 20) && (_hydration < 30)) :  {_colour_Hydration =  _colour20;};
	case((_hydration >= 10) && (_hydration < 20)) :  {_colour_Hydration =  _colour10;};
	case((_hydration >= 1) && (_hydration < 10)) :  {_colour_Hydration =  _colour0;};
	case(_hydration < 1) : {_colour_Hydration =  _colourDead;};
	};

//________________ Changing Colour based on Hunger ________________
_colour_Nutrition = _colour_Default;
if(_nutrition >= 100) then{_colour_Nutrition = _colour_Default;};
if((_nutrition >= 90) && (_nutrition < 100)) then {_colour_Nutrition =  _colour90;};
if((_nutrition >= 80) && (_nutrition < 90)) then {_colour_Nutrition =  _colour80;};
if((_nutrition >= 70) && (_nutrition < 80)) then {_colour_Nutrition =  _colour70;};
if((_nutrition >= 60) && (_nutrition < 70)) then {_colour_Nutrition =  _colour60;};
if((_nutrition >= 50) && (_nutrition < 60)) then {_colour_Nutrition =  _colour50;};
if((_nutrition >= 40) && (_nutrition < 50)) then {_colour_Nutrition =  _colour40;};
if((_nutrition >= 30) && (_nutrition < 40)) then {_colour_Nutrition =  _colour30;};
if((_nutrition >= 20) && (_nutrition < 30)) then {_colour_Nutrition =  _colour20;};
if((_nutrition >= 10) && (_nutrition < 20)) then {_colour_Nutrition =  _colour10;};
if((_nutrition >= 1) && (_nutrition < 10)) then {_colour_Nutrition =  _colour0;};
if(_nutrition < 1) then{_colour_Nutrition =  _colourDead;};

//________________ display information ________________
/*
You can delete the Line that you dont want. The numbers at the end of the lines , are defined  below
At the end of the lines , are the spaces between the next number and logo

IMPORTANT ! as mentioned above , edit your selection for MP or SP score
________________ Switch your Selection below ________________
_Kills = score player; //Returns the person's score in MP.
_count_dead = format ["%1 ",count allDeadMen];//Returns the person's score in SP.
*/


((uiNamespace getVariable "RscStatusBar")displayCtrl 55554) ctrlSetStructuredText
parseText format
	["
<t shadow='1' shadowColor='#000000' color='%4'>%3<img size='1.7' image='images\thermometerS.paa' />     </t>
<t shadow='1' shadowColor='#000000' color='%7'>%5%1<img size='1.3' image='images\canteen2.paa' />				</t>
<t shadow='1' shadowColor='#000000' color='%8'>%6%1<img size='1.2' image='images\IMG_0193.paa' />				</t>",
		"%",					//1
		count playableUnits,	//2
		_Temp,	                //3
		_color_thermo,           //4
		_hydration,				//5
		_nutrition,				//6
		_colour_Hydration,		//7
		_colour_Nutrition		//8
		];
	};
};
