"---------------------------------------------------
" Stromasys CHARON configuration and log files vimrc
" Products: Charon-AXP, Charon-VAX, Charon-PDP,
"           Charon-SSP
"---------------------------------------------------
" Version 10, 04-Apr-2018

if exists("b:current_syntax")
  finish
endif

if has("gui_running")
  setglobal lines=32 columns=160
endif

syntax off

"====================
" Configuration file
"====================

"--- Comment
syntax match cfgcomm	"^#.*$"
highlight cfgcomm	term=none	ctermfg=grey					guifg=#A0A0A0

"--- Information
syntax match cfginfo	"^#INFO:.*$"
highlight cfginfo	term=none	ctermfg=white	ctermbg=blue	guifg=white	guibg=#3AAADC

"--- Load
syntax match cfgload	"^load.*$"
highlight cfgload	term=none	ctermfg=blue					guifg=#0062AB

"--- Model and configuration
syntax match cfgmod	"^set.*session.*hw_model.*$"
syntax match cfgcon "^set.*session.*configuration_name.*$"
highlight cfgmod	term=none	ctermfg=green					guifg=#3EA650
highlight link cfgcon cfgmod

"--- Lun / container
syntax match lun	"\[.*\]"
highlight lun		term=bold	ctermfg=blue                                    guifg=#0062AB

"====================
" Log file
"====================

"--- HW configuration details
syntax match logcfgdet	"^.*:0:0000009[789]:.*$"
syntax match sspdet	"^....-..-.. ..:..:.. INFO  System  .*$"
highlight logcfgdet	term=none	ctermfg=blue			guifg=#0062ab
highlight link	sspdet	logcfgdet

"--- session is loading built-in configuration
syntax match logloadcfg	"^.*:0:000003A5:.*$"
highlight logloadcfg	term=none	ctermfg=black	ctermbg=green	guifg=Black	guibg=#3ea650

"--- Start request received & started
syntax match logstartrq	"^.*:0:0000032[BC]:.*$"
highlight logstartrq	term=none	ctermfg=black   ctermbg=green   guifg=Black     guibg=#3ea650

"--- Stopped & Stop request received & CPU Halted
syntax match logstop	"^.*:0:0000032[DE]:.*$"
syntax match logcpuhalt	"^.* CPU.* Halted .*$"
syntax match sspstop	"^.* terminated. Goodbye!"
highlight logstop	term=none	ctermfg=red			guifg=#ff2020
highlight link logcpuhalt	logstop
highlight link sspstop		logstop

"--- Product version & license number
syntax match logprdlic1	"^.*:0:00000350:.*$"
syntax match logprdlic2	"^.*:0:00000408:.*$"
highlight logprdlic1	term=none	ctermfg=white	ctermbg=blue	guifg=White	guibg=#0062ab
highlight link logprdlic2 logprdlic1

"--- session: Detected removal of the license
syntax match loglicrem1	"^.*:0:00000351:.*$"
syntax match loglicrem2	"^.*:0:0000002A:.*$"
highlight loglicrem1	term=none	ctermfg=white	ctermbg=magenta	guifg=White	guibg=#8b008b
highlight link loglicrem2 loglicrem1

"--- License detected and online
syntax match loglicfnd	"^.*:0:0000039D:.*$"
syntax match ssplicfnd	"^....-..-.. ..:..:.. INFO  License  Found.*$"
syntax match ssplicbak  "^....-..-.. ..:..:.. INFO  License  License check succeeds.*$"
highlight loglicfnd	term=none	ctermfg=white	ctermbg=green	guifg=White	guibg=#3ea650
highlight link	ssplicfnd	loglicfnd
highlight link	ssplicbak	loglicfnd

"--- License has changed
syntax match loglicchg	"^.*:0:0000040B:.*$"
highlight loglicchg	term=none	ctermfg=White ctermbg=Darkgrey	guifg=White	guibg=Darkgrey

"--- Looking for license / ll_sentine
syntax match logsentin	"^.*:0:000003..:ll_sentine.*$"
highlight logsentin	term=none	ctermfg=grey			guifg=grey

"--- License Manager (V4.9 and +)
syntax match loglicman 	"^.*:0:0000024D:licenseman.*$"
highlight loglicman	term=none	ctermfg=blue			guifg=#3aaadc

"--- Warning messages
syntax match logwarn	"^.*:WARN :1:.*$"
syntax match sspwarn	"^....-..-.. ..:..:.. WARN  .*$"
highlight logwarn	term=none	ctermfg=black 	ctermbg=cyan	guifg=Black	guibg=Cyan
highlight link		sspwarn		logwarn

"--- Error messages
syntax match logerror	"^.*:ERROR:2:.*$"
syntax match ssperror	"^....-..-.. ..:..:.. ERROR .*$"
highlight logerror	term=none	ctermfg=black 	ctermbg=red	guifg=Black	guibg=#f70808
highlight link		ssperror	logerror

"--- Fatal messages
syntax match logfatal	"^.*:FATAL:3:.*$"
syntax match sspfatal	"^....-..-.. ..:..:.. FATAL .*$"
highlight logfatal	term=none	ctermfg=red 	ctermbg=darkgrey	guifg=#f70808	guibg=Black
highlight link		sspfatal	logfatal

"--- Starting with V4.9: configuration file in log
syntax match logcfglv1	"^ \. .*$"
highlight logcfglv1	term=none	ctermfg=white ctermbg=darkgrey	guifg=white guibg=Darkgrey
syntax match logcfglv2	"^ \. \. .*$"
highlight logcfglv2	term=none	ctermfg=darkmagenta	guifg=darkmagenta
