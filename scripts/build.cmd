:: Prerequisites (see INSTALLpc.txt on vim repo for more info)
:: For Visual Studio C++ 2017 x86 build

@echo off

echo ==========================================================================
echo ** Building VIM/GVIM
echo ** 32 bit
echo ==========================================================================

where /q git || ECHO Git must be installed. && EXIT /B

IF ["%VCINSTALLDIR%"] == [] (
  echo "Cannot find VC install dir. Make sure you ran this in the visual studio command prompt"
  exit /b 1
)

set CWD=%cd%
set SRC_DIR=%TMP%
set SRC=%SRC_DIR%\vim
set DST=%LOCALAPPDATA%\vim\current
set RUNTIME=%LOCALAPPDATA%\vim\runtime
set BACKUP=%LOCALAPPDATA%\vim\prior

git clone https://github.com/vim/vim "%SRC%"

IF NOT EXIST "%SRC%"  (
  echo "Cannot find vim source code. Maybe there was a problem with 'git clone'?"
  echo %errorlevel%
  exit /b 1
)

call "%VCINSTALLDIR%\Auxiliary\Build\vcvars32.bat"

set GUI=no
set NETBEANS=no
set FEATURES=HUGE
set CPUNR=i686
set WINVER=0x501
set OLE=no
set OPTIMIZE=SPEED
set CSCOPE=yes
set DYNAMIC_RUBY=
set RUBY=
set RUBY_VER=
set RUBY_API_VER_LONG=

if exist "%RUNTIME%" (
  rmdir /S /Q "%RUNTIME%"
)

if exist "%BACKUP%" (
  rmdir /S /Q "%BACKUP%"
)

if exist "%DST%" (
  move /Y "%DST%" "%BACKUP%"
)

cd "%SRC%\src\"

for /l %%x in (1, 1, 2) do (
  if %%x==2 set GUI=yes

  nmake -f Make_mvc.mak clean
  nmake -f Make_mvc.mak

  xcopy "%SRC%\runtime" "%DST%" /D /E /H /I /Y %*
  xcopy "%SRC%\src\xxd\xxd.exe" "%DST%\*" /D /Y %*
  xcopy "%SRC%\src\GvimExt\gvimext.dll" "%DST%\*" /D /Y %*
  xcopy "%SRC%\src\*.exe" "%DST%\*" /D /Y %*
)

mklink /D "%RUNTIME%" "%DST%"

cd %CWD%

rmdir /S /Q "%SRC%"

echo ==========================================================================
echo ** vim installed in %DST%
echo ** vim runtime in %RUNTIME%
echo ** prior vim moved to %BACKUP%
echo ==========================================================================
