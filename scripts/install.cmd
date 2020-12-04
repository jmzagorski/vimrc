"%comspec%" /k ""%programfiles(x86)%\Microsoft Visual Studio\2019\Enterprise\Common7\Tools\VsDevCmd.bat" && "%cd%\build.cmd" && vim "%cd%\dummy.cs" +PackUpdate +OmniSharpInstall +:q"
