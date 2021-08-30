# Arma-3---Weather-system-Temperature-
This is a FULL release of my temperature system that I no longer use, to use it you will need to use the Ravage mod to get it's FULL potential, and to utilize the HUD.

8/29/21~
This is the **FINAL** Version that was written by me, and is the FULL release of this system.

This will **NO LONGER** Recieve any updates of ANY kind.

This script and it's systems are AS IS, unless you modify these files.

Please note: This system was never truly finished, and the code was never optimized, there are some errors redundant, and executed that need to be fixed. Other than those flaws this system DOES work.

How to use:

You will need to call from your init.sqf file:

[] execVM "TCWeathercfg.sqf";
[] execVM "TCTempbar.sqf";


That will execute the temperature script code, you will also need to put into your description.ext file this code:

class RscTitles{
	class Default {
		idd = -1;
		fadein = 0;
		fadeout = 0;
		duration = 0;
	};
#include "TC_Status\TCStatus.hpp"
};

--------------------------------------------------------------------------------------------------

