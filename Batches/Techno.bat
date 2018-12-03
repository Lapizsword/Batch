@echo off
title Animation Box - Dos Techno Virus
setlocal enabledelayedexpansion
set L= 
set M= 
set C=0
FOR /L %%A IN (1,1,4000) DO (
	if "!C!" == "1" set C=0
	if "!C!" == "2" (
		set L= 
		set C=1
	)
	if "!C!" == "3" (
		set L= 
		set C=2
	)
	if "!C!" == "4" (
		set L= 
		set C=3
	)
	if "!C!" == "0" if "!L!" == "N" (
		set L=O
		set C=4
	)
	if "!C!" == "0" if "!L!" == "H" (
		set L=N
		set C=1
	)
	if "!C!" == "0" if "!L!" == "C" (
		set L=H
		set C=1
	)
	if "!C!" == "0" if "!L!" == "E" (
		set L=C
		set C=1
	)
	if "!C!" == "0" if "!L!" == "T" (
		set L=E
		set C=1
	)
	if "!C!" == "0" if "!L!" == " " (
		set L=T
		set C=1
	)
	if "!Cursor!" == "ß" (set Cursor=Ü) ELSE (set Cursor=ß)
	set M=!M:~0,-1!!L!!Cursor!
	echo !M!
	ping localhost -n 1 >nul
	cls
)
exit