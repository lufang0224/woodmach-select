@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0sync-equipment-languages.ps1" -Slug %1
