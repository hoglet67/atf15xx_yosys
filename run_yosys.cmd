@echo off

set VAR_WORKINGDIR=%CD%

REM Ensure we can locate YOSYS, and initialize the cad tools package.
where /q yosys.exe
if ERRORLEVEL 1 (
	if not exist "%OSS_CAD_SUITE_PATH%\bin\yosys.exe" (
		echo Could not locate yosys.exe. Please ensure you have downloaded oss-cad-suite from
		echo https://github.com/YosysHQ/oss-cad-suite-build/releases/latest and set the
		echo OSS_CAD_SUITE_PATH environment variable to the installation directory.
		exit /b 1
	)
	call "%OSS_CAD_SUITE_PATH%\environment.bat"
)

REM Restore our current working directory
cd /d "%VAR_WORKINGDIR%"

set VAR_ROOT=%~dp0
set VAR_NAME=%~1
shift

yosys --version

REM An option to reverse the order of EDIF busses became available on
REM Jun 20, 2023, and is included Yosys 0.30+21 onwards
set VAR_LSBIDX=-lsbidx

set VAR_SCRIPTPATH=%TEMP%\Yosys%RANDOM%.txt
echo Writing script file to %VAR_SCRIPTPATH%
(
echo read_liberty -lib %VAR_ROOT%cells.lib
echo read_verilog %VAR_NAME%.v
echo stat
echo tribuf
echo stat
echo synth -flatten -noabc -auto-top
echo stat
echo techmap -map %VAR_ROOT%techmap.v -D skip_DFFE_XX_
echo stat
echo simplemap
echo stat
echo dfflibmap -liberty %VAR_ROOT%cells.lib
echo stat
echo abc -liberty %VAR_ROOT%cells.lib
echo stat
echo #hilomap -hicell VCC X -locell GND X
echo #stat
echo iopadmap -bits -inpad INBUF Q:A -outpad BUF A:Q -toutpad TRI ENA:A:Q -tinoutpad bibuf EN:Q:A:PAD
echo stat
echo clean
echo stat
echo hierarchy
echo stat
echo splitnets -format _
echo rename -wire -suffix _reg t:*DFF*
echo rename -wire -suffix _comb
echo #write_edif -attrprop %VAR_NAME%.edif
echo delete t:\$scopeinfo
echo write_edif %VAR_LSBIDX% %VAR_NAME%.edif
) >"%VAR_SCRIPTPATH%"

yosys<"%VAR_SCRIPTPATH%"
del /F /Q "%VAR_SCRIPTPATH%"
