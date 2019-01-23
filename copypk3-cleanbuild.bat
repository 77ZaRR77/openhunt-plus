rem call %cd%\build\win32-qvm\compile.bat
rename %cd%\build\win32-qvm\openhunt.pk3 huntpak1.pk3
xcopy/Y %cd%\build\win32-qvm\huntpak1.pk3 %cd%\
del %cd%\build\win32-qvm\huntpak1.pk3
rd /s/q %cd%\build\win32-qvm\vm

pause