@echo off
cls

:loop

mingw32-make -s clean
mingw32-make -s all 

pause>nul
cls
goto loop