@echo OFF

color 2

set "SCRIPT_PATH"=%~dp0" 

:a 
set /p input="Input name file (without .py): "

if not exist "%input%.py" (
	echo File not exist
	pause	
	goto :a
)

echo Find virtual env...
if not exist "%SCRIPT_PATH%\.env\Scripts\activate.bat" (
	echo Virtual env not found, installing...
	python -m venv .env
) else (
echo Found virtual env <- Skip
) 

cd .env\scripts

echo Activate virtual env...
start /b activate.bat

echo Return to root folder...
cd /d "%~dp0"

echo Install pyinstaller...
if not exist "%SCRIPT_PATH%\.env\Lib\site-packagesLib\site-packages\PyInstaller" pip install pyinstaller --target .env\Lib\site-packages -qqq <nul

echo Convert to .exe...
pyinstaller --onefile --clean --log-level ERROR "%input%.py"

if exist ".\dist\%input%.exe" (echo SUCEFULL COMPILE!) else (echo BUILD ERROR)
exit /B 0