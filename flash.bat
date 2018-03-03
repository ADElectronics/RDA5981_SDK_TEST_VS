@echo off
cls

:loop
JLink.exe -Device CORTEX-M4 -If SWD -Speed 4000 tools\RDA5981_Flash.JLinkScript

pause>nul
goto loop