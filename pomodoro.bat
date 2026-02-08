@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

:: Simple Pomodoro Timer for Windows
:: Usage: pomodoro.bat [work_minutes] [break_minutes]

set "WORK_MINUTES=%~1"
if "!WORK_MINUTES!"=="" set "WORK_MINUTES=25"

set "BREAK_MINUTES=%~2"
if "!BREAK_MINUTES!"=="" set "BREAK_MINUTES=5"

set /a WORK_SECONDS=WORK_MINUTES * 60
set /a BREAK_SECONDS=BREAK_MINUTES * 60

:: ANSI color codes
set "RED=^[[31m"
set "GREEN=^[[32m"
set "YELLOW=^[[33m"
set "BLUE=^[[34m"
set "CYAN=^[[36m"
set "BOLD=^[[1m"
set "NC=^[[0m"

echo.
echo %CYAN%==================================%NC%
echo %BOLD%       POMODORO TIMER%NC%
echo %CYAN%==================================%NC%
echo %GREEN%Work:%NC% %WORK_MINUTES% min %BLUE%|%NC% %YELLOW%Break:%NC% %BREAK_MINUTES% min
echo %CYAN%==================================%NC%
echo Press %RED%Ctrl+C%NC% to stop
echo.

set "session=1"

:main_loop
    echo %BOLD%--- Session #%session% ---%NC%
    echo.
    
    :: Work session
    call :countdown %WORK_SECONDS% "  Work  " %GREEN%
    call :play_sound
    echo %GREEN%  Work session complete!%NC% Take a break.
    echo.
    
    :: Break session
    call :countdown %BREAK_SECONDS% "  Break " %YELLOW%
    call :play_sound
    echo %YELLOW%  Break over!%NC% Ready to work?
    echo.
    
    set /a session=session + 1
    goto main_loop

:countdown
    set "duration=%~1"
    set "label=%~2"
    set "color=%~3"
    set "remaining=%duration%"
    set "elapsed=0"
    
    :countdown_loop
    if !remaining! leq 0 goto countdown_done
    
    set /a percent=(elapsed * 100) / duration
    call :format_time !remaining!
    call :progress_bar !elapsed! !duration!
    
    <nul set /p "=%color%%BOLD%%label%%NC% !progress_bar_result! %CYAN%!formatted_time!%NC% %YELLOW%(%percent%%%)%NC%"
    
    timeout /t 1 /nobreak >nul
    set /a remaining=remaining - 1
    set /a elapsed=elapsed + 1
    goto countdown_loop
    
    :countdown_done
    call :progress_bar %duration% %duration%
    echo %color%%BOLD%%label%%NC% !progress_bar_result! %CYAN%00:00%NC% %YELLOW%(100%%)%NC%
    echo.
    exit /b

:format_time
    set "seconds=%~1"
    set /a mins=seconds / 60
    set /a secs=seconds %% 60
    
    if !mins! lss 10 (
        set "formatted_mins=0!mins!"
    ) else (
        set "formatted_mins=!mins!"
    )
    
    if !secs! lss 10 (
        set "formatted_secs=0!secs!"
    ) else (
        set "formatted_secs=!secs!"
    )
    
    set "formatted_time=!formatted_mins!:!formatted_secs!"
    exit /b

:progress_bar
    set "current=%~1"
    set "total=%~2"
    set "width=20"
    set /a filled=(current * width) / total
    set /a empty=width - filled
    
    set "bar=["
    for /l %%i in (1,1,!filled!) do set "bar=!bar!="
    for /l %%i in (1,1,!empty!) do set "bar=!bar! "
    set "bar=!bar!]"
    
    set "progress_bar_result=!bar!"
    exit /b

:play_sound
    powershell -c "[console]::beep(800, 500)" 2>nul
    exit /b
