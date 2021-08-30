//________________  Author : TenuredCLOUD ___________ 03.24.20 _____________

/*
________________ TenuredCLOUD Status Bar for temperature________________

include this in the desrcription.ext :

//____________________________________________________
class RscTitles
{
	#include "TC_Status\TCStatus.hpp"
};
//____________________________________________________

*/

//	https://community.bistudio.com/wiki/Dialog_Control

class RscStatusBar
{
    idd = -1;
		duration = 10000000000;
    onLoad = "uiNamespace setVariable ['RscStatusBar', _this select 0];";
		fadein = 0;
		fadeout = 0;
		movingEnable = 0;
		objects[] = {};

//____________________________________________________


//________________ Images and status ________________
class controls
{
        class statusBarText
      {
        idc = 881488;
        x = 0.925 * safezoneW + safezoneX;	//1.50 	left  	 1.20 	right	1.90 for 1920 ,	1.38 for 1024
        y = 0.522 * safezoneH + safezoneY;	//70 	down 	 75 	up		0.070
        w = 0.075 * safezoneW;
        h = 0.253 * safezoneH;
        colorBackground[] = {0,0,0,0};
        shadow = 1;
        font = "EtelkaMonospaceProBold";
        size = 0.035;
        type = 13;
	       style = 2;
        text = "";

        class Attributes
        {
        align="right";
        valign = "middle";
        shadow = 2;
        shadowColor = "#000000";
        color = "#ffffff";
        font = "RobotoCondensed";
        size = 1;
		// https://community.bistudio.com/wiki/FXY_File_Format#Available_Fonts
        };
      };
   };
};
