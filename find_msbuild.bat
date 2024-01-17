@echo off
setlocal enabledelayedexpansion
for /f "delims=" %%i in ('"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -prerelease -products * -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\MSBuild.exe') do (
	SET MSBUILD_PATH=%%i
)
echo !MSBUILD_PATH!