@echo off

IF [%1] == [] (
    echo "Visual studio year must be provided (e.g. 2019)"
    exit /b %errorlevel%
)

IF [%2] == [] (
    echo "Visual studio edition must be provided (e.g. Community)"
    exit /b %errorlevel%
)

"%comspec%" /k ""%programfiles(x86)%\Microsoft Visual Studio\%1\%2\Common7\Tools\VsDevCmd.bat" && "%cd%\build.cmd" && vim "%cd%\dummy.cs" +PackUpdate +OmniSharpInstall +:q"
