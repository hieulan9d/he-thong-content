@echo off
chcp 65001 >nul
set LOG="%~dp0agent-reach-install-log.txt"
set PYTHONIOENCODING=utf-8
set PYTHONUTF8=1
echo === Cai Agent Reach === > %LOG%
where py >nul 2>&1 && (set PY=py -3) || (set PY=python)
%PY% --version >> %LOG% 2>&1
if not exist "%USERPROFILE%\.agent-reach-venv\Scripts\python.exe" %PY% -m venv "%USERPROFILE%\.agent-reach-venv" >> %LOG% 2>&1
set VPY="%USERPROFILE%\.agent-reach-venv\Scripts\python.exe"
set AR="%USERPROFILE%\.agent-reach-venv\Scripts\agent-reach.exe"
echo [1/5] Cai goi Python...
%VPY% -m pip install --upgrade pip >> %LOG% 2>&1
%VPY% -m pip install "%~dp0Agent-Reach" >> %LOG% 2>&1
echo [2/5] Cai cong cu nen (yt-dlp, gh, mcporter...)...
echo. >> %LOG% & echo === install --system === >> %LOG%
%AR% install --env=auto --system >> %LOG% 2>&1
echo [3/5] Cai kenh Facebook, Instagram...
echo. >> %LOG% & echo === channels facebook,instagram === >> %LOG%
%AR% install --env=auto --system --channels=facebook,instagram >> %LOG% 2>&1
echo [4/5] Gan skill cho agent...
echo. >> %LOG% & echo === skill === >> %LOG%
%AR% skill --install >> %LOG% 2>&1
echo [5/5] Kiem tra...
echo. >> %LOG% & echo === doctor === >> %LOG%
%AR% doctor >> %LOG% 2>&1
echo. >> %LOG% & echo === XONG === >> %LOG%
type %LOG%
echo.
echo XONG. Co the dong cua so nay.
pause
