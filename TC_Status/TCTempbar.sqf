


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


	if(isNull ((uiNamespace getVariable "RscStatusBar")displayCtrl 881488)) then
	{
	diag_log "statusbar is null create";
	disableSerialization;
	_rscLayer = "RscStatusBar" call BIS_fnc_rscLayer;
	_rscLayer cutRsc ["RscStatusBar","PLAIN",1,false];

	};

//_hypoTH = player getVariable ["hypoValue", 1.0]; //ignore
_Temp = player getVariable ["_TCTemperature", "Normal"];
//_Temp = selectRandom _Temperature; //ignore
_hydration = player getVariable ["thirst", 100];
_nutrition = player getVariable ["hunger", 100];
//_health = player call rvg_fnc_getHealth; // needs more work to implement into UI


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
_colornormal 	    	= parseText "#FBFCFE";
_colorcold 	        = parseText "#00DAFF";
_colorFreezing	    = parseText "#0011FF";
_colorWet 	        = parseText "#7CDAFF";
_colorhypothermic   = parseText "#64008B";
_colorsoaked 	    = parseText "#00A0FF";
_colorwarming 		= parseText "#FFA000";
_colorsick 		    = parseText "#C9FF00";
_colorsickness 		= parseText "#99C200";
_colorsickbetter 	= parseText "#ECDF00";
_colorverysick    = parseText "#D55DFF";
_colorverycold		=	parseText	"#008AFF";
_colorfreezingwet = parseText "#8F00FF";
_colorfreezingweather = parseText "#0084FF";
_colorweathersickr = parseText "#FFFC00";
_colorwethypor = parseText "#FF9500";
_colorelevr = parseText "#5F17FC";
_coloreill	=	parseText	"#F5D930";

//________________ Changing Colour based on Temperature ________________
_color_thermo = Nil;
 switch (true) do
 {
 case (_Temp isEqualTo	"Normal") : {_color_thermo = _color_TDefault};
 case (_Temp isEqualTo "Cold") : {_color_thermo =  _colorcold};
 case (_Temp isEqualTo "freezing") : {_color_thermo =  _colorFreezing};
 case (_Temp isEqualTo "wet") : {_color_thermo =  _colorWet};
 case (_Temp isEqualTo "Hypothermic") : {_color_thermo =  _colorhypothermic};
 case (_Temp isEqualTo "Soaked") : {_color_thermo =  _colorsoaked};
 case (_Temp isEqualTo "Warming Up...") : {_color_thermo =  _colorwarming};
 case (_Temp isEqualTo "Getting Sick...") : {_color_thermo =  _colorsick};
 case (_Temp isEqualTo "Sick") : {_color_thermo =  _colorsickness};
 case (_Temp isEqualTo "Getting better...") : {_color_thermo =  _colorsickbetter};
 case (_Temp isEqualTo "Cold Elevation")	: {_color_thermo	=	_colorverycold};
 case	(_Temp isEqualTo "Freezing and Drenched")	:	{_color_thermo	=	_colorfreezingwet};
 case (_Temp isEqualTo "Freezing from Weather") : {_color_thermo = _colorfreezingweather};
 case (_Temp isEqualTo "Sickness risk +") : {_color_thermo = _colorweathersickr};
 case (_Temp isEqualTo "Hypothermia risk +") : {_color_thermo = _colorwethypor};
 case (_Temp isEqualTo "Freeze Risk") : {_color_thermo = _colorelevr};
 case (_Temp isEqualTo "illness Risk") : {_color_thermo = _coloreill};
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


//________________ Changing Colour based on Health ________________
//_colour_Health = _colour_Default;
//if(_health >= 100) then{_colour_Health = _colour_Default;};
//if((_health >= 90) && (_health < 100)) then {_colour_Health =  _colour90;};
//if((_health >= 80) && (_health < 90)) then {_colour_Health =  _colour80;};
//if((_health >= 70) && (_health < 80)) then {_colour_Health =  _colour70;};
//if((_health >= 60) && (_health < 70)) then {_colour_Health =  _colour60;};
//if((_health >= 50) && (_health < 60)) then {_colour_Health =  _colour50;};
//if((_health >= 40) && (_health < 50)) then {_colour_Health =  _colour40;};
//if((_health >= 30) && (_health < 40)) then {_colour_Health =  _colour30;};
//if((_health >= 20) && (_health < 30)) then {_colour_Health =  _colour20;};
//if((_health >= 10) && (_health < 20)) then {_colour_Health =  _colour10;};
//if((_health >= 1) && (_health < 10)) then {_colour_Health =  _colour0;};
//if(_health < 1) then{_colour_Health =  _colourDead;}; //needs more work for me to implement

//________________ display information ________________
/*
You can delete the Line that you dont want. The numbers at the end of the lines , are defined  below
At the end of the lines , are the spaces between the next number and logo

IMPORTANT ! as mentioned above , edit your selection for MP or SP score
________________ Switch your Selection below ________________
_Kills = score player; //Returns the person's score in MP.
_count_dead = format ["%1 ",count allDeadMen];//Returns the person's score in SP.
*///55554


((uiNamespace getVariable "RscStatusBar")displayCtrl 881488) ctrlSetStructuredText
parseText format
	["
<t shadow='1' shadowColor='#000000' color='%4'>%3<img size='1.8' image='images\thermometerS.paa'	/></t><br/><br/>
<t shadow='1' shadowColor='#000000' color='%7'>%5%1<img size='1.5' image='images\canteen2.paa'	/></t><br/><br/>
<t shadow='1' shadowColor='#000000' color='%8'>%6%1<img size='1.4' image='images\IMG_0193.paa'	/></t><br/><br/>",
		"%",									//1
		count playableUnits,	//2
		_Temp,	             	//3
		_color_thermo,       	//4
		_hydration,						//5
		_nutrition,						//6
		_colour_Hydration,		//7
		_colour_Nutrition			//8
		];
	};
};
