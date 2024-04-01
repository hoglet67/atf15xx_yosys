@echo off
set VAR_ROOT=%~dp0
if not defined VAR_FITTERDIR (
	if exist "%VAR_ROOT%vendor\atmel.std" (
		set VAR_FITTERDIR=%VAR_ROOT%\vendor
	) else (
		set VAR_FITTERDIR=C:\ATMEL_PLS_Tools\Prochip\pldfit
	)
)
if not exist "%VAR_FITTERDIR%\atmel.std" (
	echo Unable to locate Atmel fitters
	exit /b 1
)

REM Process command line args
set VAR_DEVICE=ATF1508AS
set VAR_PACKAGE=PLCC84
set VAR_SPEED=15
set VAR_OPTS=
goto :getopts
:getoptsComplete

echo Name    = %VAR_NAME%
echo Device  = %VAR_DEVICE%
echo Package = %VAR_PACKAGE%
echo Speed   = %VAR_SPEED%
echo Options = %VAR_OPTS%


REM # Atmel foldback = Altera shareable expander
REM # Atmel cascade = Altera parallel expander

REM # Fitter Defaults
REM  Device_name = PQFP100
REM  Tech_name = ATF1508AS
REM  Package_type = PQFP
REM  Preassignment = try
REM  Security_mode = OFF
REM  Pin-Keeper = OFF
REM  supporter = ABEL
REM  optimize = ON
REM  Xor_synthesis = OFF
REM  Foldback_logic = OFF
REM  Cascade_logic = OFF
REM  Output_fast = ON
REM  SSTL_input = off
REM  Power down pin 1 = OFF
REM  Power down pin 2 = OFF
REM  power_reset = OFF
REM  JTAG = ON
REM  TDI pullup = OFF
REM  TMS pullup = OFF
REM  MC_power = OFF
REM  Open_collector = OFF
REM  ITD0 = ON
REM  ITD1 = ON
REM  ITD2 = ON
REM  Fast_inlatch = off
REM  Latch_synthesis = off
REM  Push_gate = on
REM  Verilog_sim = off
REM  VHDL_sim = off
REM  Out_Edif = off
REM  Logic Doubling = off

set VAR_FITTER=fit%VAR_DEVICE:~3,4%.exe

findstr /R /C:"//PIN:" "%VAR_NAME%.v">"%VAR_NAME%.temp.pin"
(for /f "usebackq tokens=* delims=//PIN: " %%I in ("%VAR_NAME%.temp.pin") do echo %%I) >%VAR_NAME%.pin
del /f /q "%VAR_NAME%.temp.pin">nul

if exist "%VAR_NAME%.fit" del /f /q "%VAR_NAME%.fit">nul

echo %VAR_FITTERDIR%\%VAR_FITTER% ^
-i "%VAR_NAME%.edif" ^
-ifmt edif ^
-o "%VAR_NAME%.jed" ^
-lib "%VAR_FITTERDIR%\aprim.lib" ^
-tech "%VAR_DEVICE%" ^
-device "%VAR_PACKAGE%" ^
-tpd "%VAR_SPEED%" ^
 %VAR_OPTS%

%VAR_FITTERDIR%\%VAR_FITTER% ^
-i "%VAR_NAME%.edif" ^
-ifmt edif ^
-o "%VAR_NAME%.jed" ^
-lib "%VAR_FITTERDIR%\aprim.lib" ^
-tech "%VAR_DEVICE%" ^
-device "%VAR_PACKAGE%" ^
-tpd "%VAR_SPEED%" ^
 %VAR_OPTS%


findstr /R /C:"^    " "%VAR_NAME%.fit"
echo.

echo Logic Array Block       Macro Cells     I/O Pins        Foldbacks       TotalPT         FanIN           Cascades
findstr /R /C:"^[A-H]:" "%VAR_NAME%.fit"
echo.

findstr /R /C:"^Total" "%VAR_NAME%.fit"
echo.

findstr /R /C:"^$Device" "%VAR_NAME%.fit"
echo.

exit /b 0


:PrintUsage
    echo "Usage: $0 [-h] [-d <device>] [-p <package>] [-s <speed>] <name> [ fitter options ]"
    echo
    echo "Defaults:"
    echo "  <device>  = ${DEVICE}"
    echo "  <package> = ${PACKAGE}"
    echo "  <speed>   = ${SPEED}"
    echo
    echo "additional options are passed through to the fitter"
    exit /b 1

:getopts
	if /I "%~1" == "-h" ( call :PrintUsage
	) else if /I "%~1" == "--h" ( call :PrintUsage
	) else if /I "%~1" == "/h" ( call :PrintUsage
	) else if /I "%~1" == "-d" ( set "VAR_DEVICE=%~1
	) else if /I "%~1" == "--d" ( set VAR_DEVICE=%~1
	) else if /I "%~1" == "/d" ( set VAR_DEVICE=%~1
	) else if /I "%~1" == "-p" ( set VAR_PACKAGE=%~1
	) else if /I "%~1" == "--p" ( set VAR_PACKAGE=%~1
	) else if /I "%~1" == "/p" ( set VAR_PACKAGE=%~1
	) else if /I "%~1" == "-s" ( set VAR_SPEED=%~1
	) else if /I "%~1" == "--s" ( set VAR_SPEED=%~1
	) else if /I "%~1" == "/s" ( set VAR_SPEED=%~1
	) else (
		set VAR_NAME=%~1
		shift
		goto :getoptsPassthrough
	)
	shift
	goto :getopts
:getoptsPassthrough
	if /I "%~1" == "" goto :getoptsComplete
	if not defined VAR_OPTS (
		set VAR_OPTS=%1
	) else (
		set VAR_OPTS=%VAR_OPTS% %1
	)
	shift
	goto :getoptsPassthrough
