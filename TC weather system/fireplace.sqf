{
                                                                                                                                                                                        
private ["_fire","_distanceToFire","_fireplace"];
 };

_fire = nearestObject[player,"FirePlace_burning_F"];
_distanceToFire = player distance _fire;
_fireplace = true;

if (_distanceToFire < 5) then
                                                {
                                                        titleText ["<t color='#ffffff' size='1' align='right' valign='bottom'>Near Fireplace</t><br/>", "PLAIN DOWN", 0.5, true, true];
                                                         _txt = format ["<img shadow='0.2' size='1.5' image='%1' /><t size='1'>%2</t>", "images\fire2.paa"];
	                                                    [_txt, safezoneX +  safezoneW - 0.65, safeZoneY + safezoneH - 0.4, 45, 0, 0, 888] spawn bis_fnc_dynamicText;
												};

