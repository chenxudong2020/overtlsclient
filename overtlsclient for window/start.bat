cd /d %~dp0
start /b startovertls.bat
cd sing-box-1.8.7-windows-amd64
sing-box run -c config.json
