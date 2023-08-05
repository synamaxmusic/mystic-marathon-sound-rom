;
;      _/      _/  _/      _/    _/_/_/  _/_/_/_/_/  _/_/_/    _/_/_/   
;     _/_/  _/_/    _/  _/    _/            _/        _/    _/          
;    _/  _/  _/      _/        _/_/        _/        _/    _/           
;   _/      _/      _/            _/      _/        _/    _/            
;  _/      _/      _/      _/_/_/        _/      _/_/_/    _/_/_/       
;
;
;      _/      _/    _/_/    _/_/_/      _/_/    _/_/_/_/_/  _/    _/    _/_/    _/      _/      
;     _/_/  _/_/  _/    _/  _/    _/  _/    _/      _/      _/    _/  _/    _/  _/_/    _/       
;    _/  _/  _/  _/_/_/_/  _/_/_/    _/_/_/_/      _/      _/_/_/_/  _/    _/  _/  _/  _/       
;   _/      _/  _/    _/  _/    _/  _/    _/      _/      _/    _/  _/    _/  _/    _/_/           
;  _/      _/  _/    _/  _/    _/  _/    _/      _/      _/    _/    _/_/    _/      _/       
;
;                                                                     
;  MYSTIC MARATHON SOUND ROM (Disassembly started by SynaMax - 08/04/2023)
;  
;  Dedicated to Ken "KAG" Graham (October 29, 1956 – December 31, 2021)
;
;  Thanks to AT Gonzalez for getting me interested in this game, it's
;  a weird yet endearing entry in the history of Williams Electronics
;  arcade titles.
;
;;---------------------------------------------------------------------
;
;  This sound ROM disassembly is possible because it uses similar
;  routines found in earlier Williams games.  This might be the last
;  game from Williams to use the Walsh Function Sound Machine.
;
;  Mystic Marathon has the largest amount of different GWAVE "presets",
;  with 24 different sounds found in SVTAB.  Inferno only has 12!
;
;;---------------------------------------------------------------------
;
*PROGRAMMERS: EUGENE P. JARVIS, SAM DICKER,RANDY PFEIFFER,JOHN KOTLARIK
*		PAUL G. DUSSAULT,CARY W. KOLKER,TIM  MURPHY
*			AND A CAST OF THOUSANDS......
*
*
;; MYSTIC MARATHON PROGRAMMERS: KRISTINA DONOFRIO, KEN GRAHAM
;;
;;
F000: FF 						;CHECKSUM BYTE
F001: 0F 	   sei				;SET INTERRUPT MASK
F002: 8E 00 FF lds  #$00FF		;INITIALIZE STACK POINTER
F005: CE 20 00 ldx  #$2000		;INDEX TO PIA
F008: 6F 01    clr  (x+$01)		;ACCESS DDRA
F00A: 6F 03    clr  (x+$03)		;ACCESS DDRB
F00C: 86 FF    lda  #$FF		;PA0-PA7
F00E: A7 02    sta  (x+$02)		;;(found in Inferno)
F010: 6F 00    clr  (x+$00)
F012: 86 37    lda  #$37		;CB2 LOW, IRQ ALLOWED
F014: A7 01    sta  (x+$01)		;;(found in Inferno)
F016: 86 3C    lda  #$3C		;CA2 SET INIT HIGH, NO IRQS
F018: A7 03    sta  (x+$03)		;PROGRAM B CONTROL REG
F01A: CE 00 FF ldx  #$00FF		;;(RAMCLR from Sinistar)
;;RAMCLR
F01D: 6F 00    clr  (x+$00)		;;(wipe out the RAM)
F01F: 09       dex  
F020: 26 FB    bne  $F01D		;;(are we done yet?)
F022: 7A 00 81 dec  $0081
F025: 7A 00 80 dec  $0080
F028: 7A 00 80 dec  $0080
F02B: 0E       cli  			;CLEAR INTERRUPTS
F02C: 20 09    bra  $F037		;WAIT FOR INTERRUPT
*
* INTERRUPT PROCESSING
*
F02E: 8E 00 FF lds  #$00FF
F031: B6 20 00 lda  $2000
F034: 0E       cli  
F035: 8D 20    bsr  $F057
F037: 20 FE    bra  $F037		;;(wait for interrupt again)
F039: 0F       sei  
F03A: 8E 00 FF lds  #$00FF
F03D: 4F       clra 
F03E: CE FF FF ldx  #$FFFF
F041: 5F       clrb 
F042: E9 00    adcb (x+$00)
F044: 09       dex  
F045: 8C F0 00 cmpx #$F000
F048: 26 F8    bne  $F042
F04A: E1 00    cmpb (x+$00)
F04C: 27 01    beq  $F04F
F04E: 3E       wai  
F04F: 4C       inca 
F050: 36       psha 
F051: BD F0 57 jsr  $F057
F054: 32       pula 
F055: 20 E7    bra  $F03E
;;
F057: 81 01    cmpa #$01
F059: 25 2B    bcs  $F086
F05B: 22 03    bhi  $F060
F05D: 7E F1 5D jmp  $F15D
;;GWAVE PLAYSFX
F060: 81 19    cmpa #$19
F062: 22 08    bhi  $F06C
F064: 80 02    suba #$02
F066: BD F1 7B jsr  $F17B
F069: 7E F1 E1 jmp  $F1E1
;;
F06C: 81 2F    cmpa #$2F
F06E: 22 05    bhi  $F075
F070: 80 1A    suba #$1A
F072: 7E E3 91 jmp  $E391
F075: 81 52    cmpa #$52
F077: 22 0D    bhi  $F086
F079: 80 30    suba #$30
F07B: CE F0 87 ldx  #$F087
F07E: 48       asla 
F07F: BD E1 6D jsr  $E16D
F082: EE 00    ldx  (x+$00)
F084: 6E 00    jmp  (x+$00)
F086: 39       rts  
F087: F5 92 F5 bitb $92F5
F08A: 9D F6    jsr  $F6
F08C: 37       pshb 
F08D: F6 F9 F5 ldb  $F9F5
F090: B0 F5 B4 suba $F5B4
F093: F5 B8 F7 bitb $B8F7
F096: 01       nop  
F097: F7 09 F7 stb  $09F7
F09A: 88 E3    eora #$E3
F09C: 2C F8    bge  $F096
F09E: 05       illegal
F09F: F8 17 E2 eorb $17E2
F0A2: F7 F8 E9 stb  $F8E9
F0A5: E1 7C    cmpb (x+$7C)
F0A7: F8 AA F8 eorb $AAF8
F0AA: AE F8    lds  (x+$F8)
F0AC: B2 F8 B6 sbca $F8B6
F0AF: FF 4E FF stx  $4EFF
F0B2: 52       illegal
F0B3: FF 56 FF stx  $56FF
F0B6: 77 FF 9A asr  $FF9A
F0B9: FF BB E1 stx  $BBE1
F0BC: 94 E1    anda $E1
F0BE: B8 E1 E2 eora $E1E2
F0C1: E1 F1    cmpb (x+$F1)
F0C3: E2 0A    sbcb (x+$0A)
F0C5: E2 43    sbcb (x+$43)
F0C7: E2 62    sbcb (x+$62)
F0C9: E2 B3    sbcb (x+$B3)
F0CB: E0 CD    subb (x+$CD)
F0CD: 20 4D    bra  $F11C
F0CF: 59       rolb 
F0D0: 53       comb 
F0D1: 54       lsrb 
F0D2: 49       rola 
F0D3: 43       coma 
F0D4: 20 4D    bra  $F123
F0D6: 41       illegal
F0D7: 52       illegal
F0D8: 41       illegal
F0D9: 54       lsrb 
F0DA: 48       asla 
F0DB: 4F       clra 
F0DC: 4E       illegal
F0DD: 20 2D    bra  $F10C
F0DF: 20 43    bra  $F124
F0E1: 4F       clra 
F0E2: 50       negb 
F0E3: 59       rolb 
F0E4: 52       illegal
F0E5: 49       rola 
F0E6: 47       asra 
F0E7: 48       asla 
F0E8: 54       lsrb 
F0E9: 20 28    bra  $F113
F0EB: 43       coma 
F0EC: 29 20    bvs  $F10E
F0EE: 31       ins  
F0EF: 39       rts  
F0F0: 38       illegal
F0F1: 33       pulb 
F0F2: 20 57    bra  $F14B
F0F4: 49       rola 
F0F5: 4C       inca 
F0F6: 4C       inca 
F0F7: 49       rola 
F0F8: 41       illegal
F0F9: 4D       tsta 
F0FA: 53       comb 
F0FB: 20 45    bra  $F142
F0FD: 4C       inca 
F0FE: 45       illegal
F0FF: 43       coma 
F100: 54       lsrb 
F101: 52       illegal
F102: 4F       clra 
F103: 4E       illegal
F104: 49       rola 
F105: 43       coma 
F106: 53       comb 
F107: 20 49    bra  $F152
F109: 4E       illegal
F10A: 43       coma 
F10B: 2E 20    bgt  $F12D
F10D: 41       illegal
F10E: 4C       inca 
F10F: 4C       inca 
F110: 20 52    bra  $F164
F112: 49       rola 
F113: 47       asra 
F114: 48       asla 
F115: 54       lsrb 
F116: 53       comb 
F117: 20 52    bra  $F16B
F119: 45       illegal
F11A: 53       comb 
F11B: 45       illegal
F11C: 52       illegal
F11D: 56       rorb 
F11E: 45       illegal
F11F: 44       lsra 
F120: 20 20    bra  $F142
F122: 4D       tsta 
F123: 59       rolb 
F124: 53       comb 
F125: 54       lsrb 
F126: 49       rola 
F127: 43       coma 
F128: 20 4D    bra  $F177
F12A: 41       illegal
F12B: 52       illegal
F12C: 41       illegal
F12D: 54       lsrb 
F12E: 48       asla 
F12F: 4F       clra 
F130: 4E       illegal
F131: 20 2D    bra  $F160
F133: 20 43    bra  $F178
F135: 52       illegal
F136: 45       illegal
F137: 41       illegal
F138: 54       lsrb 
F139: 45       illegal
F13A: 44       lsra 
F13B: 20 42    bra  $F17F
F13D: 59       rolb 
F13E: 3A       illegal
F13F: 20 4B    bra  $F18C
F141: 52       illegal
F142: 49       rola 
F143: 53       comb 
F144: 54       lsrb 
F145: 49       rola 
F146: 4E       illegal
F147: 41       illegal
F148: 20 56    bra  $F1A0
F14A: 2E 20    bgt  $F16C
F14C: 52       illegal
F14D: 55       illegal
F14E: 4B       illegal
F14F: 55       illegal
F150: 49       rola 
F151: 5A       decb 
F152: 41       illegal
F153: 20 44    bra  $F199
F155: 4F       clra 
F156: 4E       illegal
F157: 4F       clra 
F158: 46       rora 
F159: 52       illegal
F15A: 49       rola 
F15B: 4F       clra 
F15C: 20 CE    bra  $F12C
F15E: F1 73 A6 cmpb $73A6
F161: 00       illegal
F162: 26 01    bne  $F165
F164: 39       rts  
F165: 81 01    cmpa #$01
F167: 27 07    beq  $F170
F169: DF 82    stx  $82
F16B: BD F0 57 jsr  $F057
F16E: DE 82    ldx  $82
F170: 08       inx  
F171: 20 ED    bra  $F160
F173: 03       illegal
F174: 06       tap  
F175: 0A       clv  
F176: 04       illegal
F177: 0E       cli  
F178: 05       illegal
F179: 09       dex  
F17A: 00       illegal
;;GWLD
F17B: 16       tab  
F17C: 58       aslb 
F17D: 1B       aba  
F17E: 1B       aba  
F17F: 1B       aba  
F180: CE F3 F8 ldx  #$F3F8		;SOUND VECTOR TABLE
F183: BD E1 6D jsr  $E16D
F186: A6 00    lda  (x+$00)
F188: 16       tab  
F189: 84 0F    anda #$0F
F18B: 97 92    sta  $92			;GET CYCLE COUNT
F18D: 54       lsrb 
F18E: 54       lsrb 
F18F: 54       lsrb 
F190: 54       lsrb 
F191: D7 91    stb  $91			;GET #ECHOS
F193: A6 01    lda  (x+$01)
F195: 16       tab  
F196: 54       lsrb 
F197: 54       lsrb 
F198: 54       lsrb 
F199: 54       lsrb 
F19A: D7 93    stb  $93
F19C: 84 0F    anda #$0F		;WAVE #
F19E: 97 87    sta  $87			;SAVE
F1A0: DF 8A    stx  $8A			;SAVE INDEX
F1A2: CE F2 C0 ldx  #$F2C0		;CALC WAVEFORM ADDR
;;GWLD2
F1A5: 7A 00 87 dec  $0087
F1A8: 2B 08    bmi  $F1B2
F1AA: A6 00    lda  (x+$00)
F1AC: 4C       inca 
F1AD: BD E1 6D jsr  $E16D
F1B0: 20 F3    bra  $F1A5
;;GWLD3
F1B2: DF 96    stx  $96
F1B4: BD F2 6B jsr  $F26B
F1B7: DE 8A    ldx  $8A
F1B9: A6 02    lda  (x+$02)
F1BB: 97 98    sta  $98
F1BD: BD F2 7D jsr  $F27D
F1C0: DE 8A    ldx  $8A
F1C2: A6 03    lda  (x+$03)
F1C4: 97 94    sta  $94
F1C6: A6 04    lda  (x+$04)
F1C8: 97 95    sta  $95
F1CA: A6 05    lda  (x+$05)
F1CC: 16       tab  
F1CD: A6 06    lda  (x+$06)
F1CF: CE F4 A0 ldx  #$F4A0
F1D2: BD E1 6D jsr  $E16D
F1D5: 17       tba  
F1D6: DF 99    stx  $99
F1D8: 7F 00 A1 clr  $00A1
F1DB: BD E1 6D jsr  $E16D
F1DE: DF 9B    stx  $9B
F1E0: 39       rts  
F1E1: 96 91    lda  $91
F1E3: 97 A0    sta  $A0
F1E5: DE 99    ldx  $99
F1E7: DF 8C    stx  $8C
F1E9: DE 8C    ldx  $8C
F1EB: A6 00    lda  (x+$00)
F1ED: 9B A1    adda $A1
F1EF: 97 9F    sta  $9F
F1F1: 9C 9B    cmpx $9B
F1F3: 27 26    beq  $F21B
F1F5: D6 92    ldb  $92
F1F7: 08       inx  
F1F8: DF 8C    stx  $8C
F1FA: CE 00 A2 ldx  #$00A2
F1FD: 96 9F    lda  $9F
F1FF: 4A       deca 
F200: 26 FD    bne  $F1FF
F202: A6 00    lda  (x+$00)
F204: B7 20 02 sta  $2002
F207: 08       inx  
F208: 9C 9D    cmpx $9D
F20A: 26 F1    bne  $F1FD
F20C: 5A       decb 
F20D: 27 DA    beq  $F1E9
F20F: 08       inx  
F210: 09       dex  
F211: 08       inx  
F212: 09       dex  
F213: 08       inx  
F214: 09       dex  
F215: 08       inx  
F216: 09       dex  
F217: 01       nop  
F218: 01       nop  
F219: 20 DF    bra  $F1FA
F21B: 96 93    lda  $93
F21D: 8D 5E    bsr  $F27D
F21F: 7A 00 A0 dec  $00A0
F222: 26 C1    bne  $F1E5
F224: 96 94    lda  $94
F226: 27 42    beq  $F26A
F228: 7A 00 95 dec  $0095
F22B: 27 3D    beq  $F26A
F22D: 9B A1    adda $A1
F22F: 97 A1    sta  $A1
F231: DE 99    ldx  $99
F233: 5F       clrb 
F234: 96 A1    lda  $A1
F236: 7D 00 94 tst  $0094
F239: 2B 06    bmi  $F241
F23B: AB 00    adda (x+$00)
F23D: 25 08    bcs  $F247
F23F: 20 0B    bra  $F24C
F241: AB 00    adda (x+$00)
F243: 27 02    beq  $F247
F245: 25 05    bcs  $F24C
F247: 5D       tstb 
F248: 27 08    beq  $F252
F24A: 20 0F    bra  $F25B
F24C: 5D       tstb 
F24D: 26 03    bne  $F252
F24F: DF 99    stx  $99
F251: 5C       incb 
F252: 08       inx  
F253: 9C 9B    cmpx $9B
F255: 26 DD    bne  $F234
F257: 5D       tstb 
F258: 26 01    bne  $F25B
F25A: 39       rts  
F25B: DF 9B    stx  $9B
F25D: 96 93    lda  $93
F25F: 27 06    beq  $F267
F261: 8D 08    bsr  $F26B
F263: 96 98    lda  $98
F265: 8D 16    bsr  $F27D
F267: 7E F1 E1 jmp  $F1E1
F26A: 39       rts  
;;WVTRAN
F26B: CE 00 A2 ldx  #$00A2
F26E: DF 8E    stx  $8E
F270: DE 96    ldx  $96
F272: E6 00    ldb  (x+$00)
F274: 08       inx  
F275: BD F2 AC jsr  $F2AC
F278: DE 8E    ldx  $8E
F27A: DF 9D    stx  $9D
F27C: 39       rts  
;;WVDECA
F27D: 4D       tsta 
F27E: 27 2B    beq  $F2AB
F280: DE 96    ldx  $96
F282: DF 8C    stx  $8C
F284: CE 00 A2 ldx  #$00A2
F287: 97 88    sta  $88
F289: DF 8E    stx  $8E
F28B: DE 8C    ldx  $8C
F28D: D6 88    ldb  $88
F28F: D7 87    stb  $87
F291: E6 01    ldb  (x+$01)
F293: 54       lsrb 
F294: 54       lsrb 
F295: 54       lsrb 
F296: 54       lsrb 
F297: 08       inx  
F298: DF 8C    stx  $8C
F29A: DE 8E    ldx  $8E
F29C: A6 00    lda  (x+$00)
F29E: 10       sba  
F29F: 7A 00 87 dec  $0087
F2A2: 26 FA    bne  $F29E
F2A4: A7 00    sta  (x+$00)
F2A6: 08       inx  
F2A7: 9C 9D    cmpx $9D
F2A9: 26 DE    bne  $F289
F2AB: 39       rts  
F2AC: 36       psha 
F2AD: A6 00    lda  (x+$00)
F2AF: DF 8C    stx  $8C
F2B1: DE 8E    ldx  $8E
F2B3: A7 00    sta  (x+$00)
F2B5: 08       inx  
F2B6: DF 8E    stx  $8E
F2B8: DE 8C    ldx  $8C
F2BA: 08       inx  
F2BB: 5A       decb 
F2BC: 26 EF    bne  $F2AD
F2BE: 32       pula 
F2BF: 39       rts  
;;
;;GWVTAB
;;
;;GS2
F2C0: 08       inx  
F2C1: 7F D9 FF clr  $D9FF
F2C4: D9 7F    adcb $7F
F2C6: 24 00    bcc  $F2C8
F2C8: 24 
;;GSSQ2
F2C9: 08    bcc  $F2D2
F2CA: 00       illegal
F2CB: 40       nega 
F2CC: 80 00    suba #$00
F2CE: FF 00 80 stx  $0080
F2D1: 40       nega 
;;GS1
F2D2: 10       sba  
F2D3: 7F B0 D9 clr  $B0D9
F2D6: F5 FF F5 bitb $FFF5
F2D9: D9 B0    adcb $B0
F2DB: 7F 4E 24 clr  $4E24
F2DE: 09       dex  
F2DF: 00       illegal
F2E0: 09       dex  
F2E1: 24 4E    bcc  $F331
;;
F2E3: 10       sba  
F2E4: 7F C5 EC clr  $C5EC
F2E7: E7 BF    stb  (x+$BF)
F2E9: 8D 6D    bsr  $F358
F2EB: 6A 7F    dec  (x+$7F)
F2ED: 94 92    anda $92
F2EF: 71       illegal
F2F0: 40       nega 
F2F1: 17       tba  
F2F2: 12       illegal
F2F3: 39       rts  
;;GSQ22
F2F4: 10       sba  
F2F5: FF FF FF stx  $FFFF
F2F8: FF 00 00 stx  $0000
F2FB: 00       illegal
F2FC: 00       illegal
F2FD: FF FF FF stx  $FFFF
F300: FF 00 00 stx  $0000
F303: 00       illegal
F304: 00       illegal
;;GS72
F305: 48       asla 
F306: 8A 95    ora  #$95
F308: A0 AB    suba (x+$AB)
F30A: B5 BF C8 bita $BFC8
F30D: D1 DA    cmpb $DA
F30F: E1 E8    cmpb (x+$E8)
F311: EE F3    ldx  (x+$F3)
F313: F7 FB FD stb  $FBFD
F316: FE FF FE ldx  $FFFE
F319: FD       illegal
F31A: FB F7 F3 addb $F7F3
F31D: EE E8    ldx  (x+$E8)
F31F: E1 DA    cmpb (x+$DA)
F321: D1 C8    cmpb $C8
F323: BF B5 AB sts  $B5AB
F326: A0 95    suba (x+$95)
F328: 8A 7F    ora  #$7F
F32A: 75       illegal
F32B: 6A 5F    dec  (x+$5F)
F32D: 54       lsrb 
F32E: 4A       deca 
F32F: 40       nega 
F330: 37       pshb 
F331: 2E 25    bgt  $F358
F333: 1E       illegal
F334: 17       tba  
F335: 11       cba  
F336: 0C       clc  
F337: 08       inx  
F338: 04       illegal
F339: 02       illegal
F33A: 01       nop  
F33B: 00       illegal
F33C: 01       nop  
F33D: 02       illegal
F33E: 04       illegal
F33F: 08       inx  
F340: 0C       clc  
F341: 11       cba  
F342: 17       tba  
F343: 1E       illegal
F344: 25 2E    bcs  $F374
F346: 37       pshb 
F347: 40       nega 
F348: 4A       deca 
F349: 54       lsrb 
F34A: 5F       clrb 
F34B: 6A 75    dec  (x+$75)
F34D: 7F 
;;
F34E: 10 59 clr  $1059
F350: 7B       illegal
F351: 98 AC    eora $AC
F353: B3       illegal
F354: AC 98    cmpx (x+$98)
F356: 7B       illegal
F357: 59       rolb 
F358: 37       pshb 
F359: 19       daa  
F35A: 06       tap  
F35B: 00       illegal
F35C: 06       tap  
F35D: 19       daa  
F35E: 37       pshb 
;;
F35F: 08       inx  
F360: FF FF FF stx  $FFFF
F363: FF 00 00 stx  $0000
F366: 00       illegal
F367: 00       illegal
;;
F368: 10       sba  
F369: 76 FF B8 ror  $FFB8
F36C: D0 9D    subb $9D
F36E: E6 6A    ldb  (x+$6A)
F370: 82 76    sbca #$76
F372: EA 81    orb  (x+$81)
F374: 86 4E    lda  #$4E
F376: 9C 32    cmpx $32
F378: 63 
;;
F379: 10    com  (x+$10)
F37A: 00       illegal
F37B: F4 00 E8 andb $00E8
F37E: 00       illegal
F37F: DC       illegal
F380: 00       illegal
F381: E2 00    sbcb (x+$00)
F383: DC       illegal
F384: 00       illegal
F385: E8 00    eorb (x+$00)
F387: F4 00 00 andb $0000
;;GS28
F38A: 1C       illegal
F38B: 80 40    suba #$40
F38D: 29 1B    bvs  $F3AA
F38F: 10       sba  
F390: 09       dex  
F391: 06       tap  
F392: 04       illegal
F393: 07       tpa  
F394: 0C       clc  
F395: 12       illegal
F396: 1E       illegal
F397: 30       tsx  
F398: 49       rola 
F399: A4 C9    anda (x+$C9)
F39B: DF EB    stx  $EB
F39D: F6 FB FF ldb  $FBFF
F3A0: FF FB F5 stx  $FBF5
F3A3: EA DD    orb  (x+$DD)
F3A5: C7 9B    stb  #$9B
F3A7: 0C       clc  
F3A8: 00       illegal
F3A9: 50       negb 
F3AA: 60 B0    neg  (x+$B0)
F3AC: 20 20    bra  $F3CE
F3AE: F0 90 80 subb $9080
F3B1: C0 50    subb #$50
F3B3: 70 10 3C neg  $103C
F3B6: 10       sba  
F3B7: 17       tba  
F3B8: 3F       swi  
F3B9: 70 92 95 neg  $9295
F3BC: 7F 7C 7E clr  $7C7E
F3BF: 8A BE    ora  #$BE
F3C1: E7 EF    stb  (x+$EF)
F3C3: C5 7F    bitb #$7F
F3C5: 08       inx  
F3C6: 00       illegal
F3C7: 20 40    bra  $F409
F3C9: 60 80    neg  (x+$80)
F3CB: A0 C0    suba (x+$C0)
F3CD: E0 08    subb (x+$08)
F3CF: FF DF BF stx  $DFBF
F3D2: 9F 7F    sts  $7F
F3D4: 5F       clrb 
F3D5: 3F       swi  
F3D6: 1F       illegal
F3D7: 20 4C    bra  $F425
F3D9: 45       illegal
F3DA: 41       illegal
F3DB: 41       illegal
F3DC: 43       coma 
F3DD: 47       asra 
F3DE: 77 87 90 asr  $8790
F3E1: 97 A1    sta  $A1
F3E3: A7 AE    sta  (x+$AE)
F3E5: B5 B8 BC bita $B8BC
F3E8: BE BF C1 lds  $BFC1
F3EB: C2 C2    sbcb #$C2
F3ED: C2 C1    sbcb #$C1
F3EF: BF BE BB sts  $BEBB
F3F2: B6 B1 AC lda  $B1AC
F3F5: A4 9E    anda (x+$9E)
F3F7: 93      
;;SVTAB
F3F8: 73 2A 00 00 00 04 08     
F3FF: 14 0A 00 00 00 04 00     
F406: 14 0A 00 00 00 04 04  
F40D: 14 02 09 00 00 09 0C     
F414: 11 02 00 00 00 28 15   
F41B: 1F 0B 09 00 00 0F 3D   
F422: 18 00 05 02 01 20 4C   
F429: 11 02 00 00 00 18 6C 
F430: 15 02 05 00 00 16 84
F437: 81 02 00 00 00 04 9A
F43E: 11 12 00 00 00 63 00   
F445: 11 15 00 00 00 63 00   
F44C: 11 10 00 00 00 63 00   
F453: 11 11 00 00 00 63 00   
F45A: 16 02 00 00 00 7C 3D
F461: 14 02 09 FF 05 09 0C    
F468: F1 19 01 00 00 20 43  
F46F: 52 36 00 00 00 10 BB
F476: A3 19 05 01 01 10 CB
F47D: 16 82 03 0E 01 0E DB
F484: 63 26 06 00 00 10 CB
F48B: 23 15 00 02 07 03 E9
F492: 82 19 09 01 01 20 43    
F499: 82 15 00 03 01 20 43    
;;GFRTAB
F4A0: 20 18    bra  $F4BA
F4A2: 20 01    bra  $F4A5
F4A4: 01       nop  
F4A5: 30       tsx  
F4A6: 28 30    bvc  $F4D8
F4A8: 08       inx  
F4A9: 10       sba  
F4AA: 20 30    bra  $F4DC
F4AC: 20 10    bra  $F4BE
F4AE: 0C       clc  
F4AF: 0A       clv  
F4B0: 08       inx  
F4B1: 07       tpa  
F4B2: 06       tap  
F4B3: 05       illegal
F4B4: 04       illegal
F4B5: 60 45    neg  (x+$45)
F4B7: 28 21    bvc  $F4DA
F4B9: 5D       tstb 
F4BA: 42       illegal
F4BB: 25 1E    bcs  $F4DB
F4BD: 58       aslb 
F4BE: 3D       illegal
F4BF: 20 19    bra  $F4DA
F4C1: 60 38    neg  (x+$38)
F4C3: 28 14    bvc  $F4D9
F4C5: 4C       inca 
F4C6: 31       ins  
F4C7: 14       illegal
F4C8: 0D       sec  
F4C9: 40       nega 
F4CA: 25 08    bcs  $F4D4
F4CC: 01       nop  
F4CD: 4C       inca 
F4CE: 31       ins  
F4CF: 14       illegal
F4D0: 0D       sec  
F4D1: 40       nega 
F4D2: 25 08    bcs  $F4DC
F4D4: 01       nop  
F4D5: 4C       inca 
F4D6: 31       ins  
F4D7: 14       illegal
F4D8: 0D       sec  
F4D9: 40       nega 
F4DA: 25 08    bcs  $F4E4
F4DC: 01       nop  
F4DD: 0A       clv  
F4DE: 09       dex  
F4DF: 08       inx  
F4E0: 07       tpa  
F4E1: 06       tap  
F4E2: 05       illegal
F4E3: 06       tap  
F4E4: 07       tpa  
F4E5: 08       inx  
F4E6: 09       dex  
F4E7: 0A       clv  
F4E8: 0A       clv  
F4E9: 0A       clv  
F4EA: 0A       clv  
F4EB: 0A       clv  
F4EC: 20 1F    bra  $F50D
F4EE: 1E       illegal
F4EF: 1D       illegal
F4F0: 1C       illegal
F4F1: 1B       aba  
F4F2: 1A       illegal
F4F3: 19       daa  
F4F4: 18       illegal
F4F5: 17       tba  
F4F6: 16       tab  
F4F7: 15       illegal
F4F8: 14       illegal
F4F9: 13       illegal
F4FA: 12       illegal
F4FB: 11       cba  
F4FC: 10       sba  
F4FD: 0F       sei  
F4FE: 0E       cli  
F4FF: 0D       sec  
F500: 0C       clc  
F501: 0B       sev  
F502: 0A       clv  
F503: 09       dex  
F504: 08       inx  
F505: 07       tpa  
F506: 06       tap  
F507: 05       illegal
F508: 05       illegal
F509: 05       illegal
F50A: 05       illegal
F50B: 05       illegal
F50C: 60 45    neg  (x+$45)
F50E: 28 21    bvc  $F531
F510: 58       aslb 
F511: 3D       illegal
F512: 20 19    bra  $F52D
F514: 4C       inca 
F515: 31       ins  
F516: 14       illegal
F517: 0D       sec  
F518: 40       nega 
F519: 25 08    bcs  $F523
F51B: 01       nop  
F51C: 34       des  
F51D: 1C       illegal
F51E: 08       inx  
F51F: 01       nop  
F520: 28 15    bvc  $F537
F522: 08       inx  
F523: 01       nop  
F524: 1E       illegal
F525: 02       illegal
F526: 1B       aba  
F527: 04       illegal
F528: 23 07    bls  $F531
F52A: 1D       illegal
F52B: 01       nop  
F52C: 22 03    bhi  $F531
F52E: 19       daa  
F52F: 09       dex  
F530: 1F       illegal
F531: 06       tap  
F532: 1A       illegal
F533: 05       illegal
F534: 1C       illegal
F535: 0B       sev  
F536: 21 08    brn  $F540
F538: 20 0A    bra  $F544
F53A: 60 45    neg  (x+$45)
F53C: 28 21    bvc  $F55F
F53E: 07       tpa  
F53F: 08       inx  
F540: 09       dex  
F541: 0A       clv  
F542: 0C       clc  
F543: 08       inx  
F544: 01       nop  
F545: 40       nega 
F546: 02       illegal
F547: 42       illegal
F548: 03       illegal
F549: 43       coma 
F54A: 04       illegal
F54B: 44       lsra 
F54C: 05       illegal
F54D: 45       illegal
F54E: 06       tap  
F54F: 46       rora 
F550: 07       tpa  
F551: 47       asra 
F552: 08       inx  
F553: 48       asla 
F554: 09       dex  
F555: 49       rola 
F556: 0A       clv  
F557: 4A       deca 
F558: 0B       sev  
F559: 4B       illegal
F55A: 00       illegal
F55B: 01       nop  
F55C: 01       nop  
F55D: 02       illegal
F55E: 02       illegal
F55F: 04       illegal
F560: 04       illegal
F561: 08       inx  
F562: 08       inx  
F563: 10       sba  
F564: 20 28    bra  $F58E
F566: 30       tsx  
F567: 38       illegal
F568: 40       nega 
F569: 48       asla 
F56A: 50       negb 
F56B: 14       illegal
F56C: 18       illegal
F56D: 20 30    bra  $F59F
F56F: 40       nega 
F570: 50       negb 
F571: 40       nega 
F572: 30       tsx  
F573: 20 10    bra  $F585
F575: 0C       clc  
F576: 0A       clv  
F577: 08       inx  
F578: 07       tpa  
F579: 06       tap  
F57A: 05       illegal
F57B: 0C       clc  
F57C: 08       inx  
F57D: 80 10    suba #$10
F57F: 78 18 70 asl  $1870
F582: 20 60    bra  $F5E4
F584: 28 58    bvc  $F5DE
F586: 30       tsx  
F587: 50       negb 
F588: 40       nega 
F589: 10       sba  
F58A: 08       inx  
F58B: 01       nop  
F58C: 01       nop  
F58D: 01       nop  
F58E: 01       nop  
F58F: FF 03 E8 stx  $03E8
F592: CE F5 8C ldx  #$F58C
F595: 20 09    bra  $F5A0
F597: 01       nop  
F598: 01       nop  
F599: 01       nop  
F59A: 40       nega 
F59B: 10       sba  
F59C: 00       illegal
F59D: CE F5 97 ldx  #$F597
F5A0: A6 00    lda  (x+$00)
F5A2: 97 96    sta  $96
F5A4: A6 01    lda  (x+$01)
F5A6: 97 97    sta  $97
F5A8: A6 02    lda  (x+$02)
F5AA: E6 03    ldb  (x+$03)
F5AC: EE 04    ldx  (x+$04)
F5AE: 20 0F    bra  $F5BF
F5B0: C6 02    ldb  #$02
F5B2: 20 06    bra  $F5BA
F5B4: C6 03    ldb  #$03
F5B6: 20 02    bra  $F5BA
F5B8: C6 04    ldb  #$04
F5BA: 4F       clra 
F5BB: 97 97    sta  $97
F5BD: 97 96    sta  $96
F5BF: 97 95    sta  $95
F5C1: D7 90    stb  $90
F5C3: DF 93    stx  $93
F5C5: 7F 00 92 clr  $0092
F5C8: DE 93    ldx  $93
F5CA: B6 20 02 lda  $2002
F5CD: 16       tab  
F5CE: 54       lsrb 
F5CF: 54       lsrb 
F5D0: 54       lsrb 
F5D1: D8 81    eorb $81
F5D3: 54       lsrb 
F5D4: 76 00 80 ror  $0080
F5D7: 76 00 81 ror  $0081
F5DA: D6 90    ldb  $90
F5DC: 7D 00 96 tst  $0096
F5DF: 27 04    beq  $F5E5
F5E1: D4 80    andb $80
F5E3: DB 97    addb $97
F5E5: D7 91    stb  $91
F5E7: D6 92    ldb  $92
F5E9: 91 81    cmpa $81
F5EB: 22 12    bhi  $F5FF
F5ED: 09       dex  
F5EE: 27 26    beq  $F616
F5F0: B7 20 02 sta  $2002
F5F3: DB 92    addb $92
F5F5: 99 91    adca $91
F5F7: 25 16    bcs  $F60F
F5F9: 91 81    cmpa $81
F5FB: 23 F0    bls  $F5ED
F5FD: 20 10    bra  $F60F
F5FF: 09       dex  
F600: 27 14    beq  $F616
F602: B7 20 02 sta  $2002
F605: D0 92    subb $92
F607: 92 91    sbca $91
F609: 25 04    bcs  $F60F
F60B: 91 81    cmpa $81
F60D: 22 F0    bhi  $F5FF
F60F: 96 81    lda  $81
F611: B7 20 02 sta  $2002
F614: 20 B7    bra  $F5CD
F616: D6 95    ldb  $95
F618: 27 B3    beq  $F5CD
F61A: 96 90    lda  $90
F61C: D6 92    ldb  $92
F61E: 44       lsra 
F61F: 56       rorb 
F620: 44       lsra 
F621: 56       rorb 
F622: 44       lsra 
F623: 56       rorb 
F624: 43       coma 
F625: 50       negb 
F626: 82 FF    sbca #$FF
F628: DB 92    addb $92
F62A: 99 90    adca $90
F62C: D7 92    stb  $92
F62E: 97 90    sta  $90
F630: 26 96    bne  $F5C8
F632: C1 07    cmpb #$07
F634: 26 92    bne  $F5C8
F636: 39       rts  
F637: 7F 20 02 clr  $2002
F63A: CE 10 00 ldx  #$1000
F63D: 09       dex  
F63E: 26 FD    bne  $F63D
F640: 39       rts  
F641: CE F6 F5 ldx  #$F6F5
F644: DF 84    stx  $84
F646: CE 00 90 ldx  #$0090
F649: DF 8E    stx  $8E
F64B: C6 AF    ldb  #$AF
F64D: D7 89    stb  $89
F64F: 39       rts  
F650: DF 8C    stx  $8C
F652: CE F6 F5 ldx  #$F6F5
F655: DF 84    stx  $84
F657: 86 80    lda  #$80
F659: D6 93    ldb  $93
F65B: 2A 09    bpl  $F666
F65D: D6 81    ldb  $81
F65F: 54       lsrb 
F660: 54       lsrb 
F661: 54       lsrb 
F662: 5C       incb 
F663: 5A       decb 
F664: 26 FD    bne  $F663
F666: 7A 00 98 dec  $0098
F669: 27 4C    beq  $F6B7
F66B: 7A 00 99 dec  $0099
F66E: 27 4C    beq  $F6BC
F670: 7A 00 9A dec  $009A
F673: 27 4C    beq  $F6C1
F675: 7A 00 9B dec  $009B
F678: 26 DF    bne  $F659
F67A: D6 93    ldb  $93
F67C: 27 DB    beq  $F659
F67E: C4 7F    andb #$7F
F680: D7 9B    stb  $9B
F682: D6 81    ldb  $81
F684: 58       aslb 
F685: DB 81    addb $81
F687: CB 0B    addb #$0B
F689: D7 81    stb  $81
F68B: 7A 00 AB dec  $00AB
F68E: 26 0E    bne  $F69E
F690: D6 9F    ldb  $9F
F692: D7 AB    stb  $AB
F694: DE 84    ldx  $84
F696: 09       dex  
F697: 8C F6 EE cmpx #$F6EE
F69A: 27 4E    beq  $F6EA
F69C: DF 84    stx  $84
F69E: D6 81    ldb  $81
F6A0: 2B 06    bmi  $F6A8
F6A2: D4 97    andb $97
F6A4: C4 7F    andb #$7F
F6A6: 20 05    bra  $F6AD
F6A8: D4 97    andb $97
F6AA: C4 7F    andb #$7F
F6AC: 50       negb 
F6AD: 36       psha 
F6AE: 1B       aba  
F6AF: 16       tab  
F6B0: 32       pula 
F6B1: DE 84    ldx  $84
F6B3: AD 00    jsr  (x+$00)
F6B5: 20 A2    bra  $F659
F6B7: CE 00 90 ldx  #$0090
F6BA: 20 08    bra  $F6C4
F6BC: CE 00 91 ldx  #$0091
F6BF: 20 03    bra  $F6C4
F6C1: CE 00 92 ldx  #$0092
F6C4: 6D 18    tst  (x+$18)
F6C6: 27 12    beq  $F6DA
F6C8: 6A 18    dec  (x+$18)
F6CA: 26 0E    bne  $F6DA
F6CC: E6 0C    ldb  (x+$0C)
F6CE: E7 18    stb  (x+$18)
F6D0: E6 00    ldb  (x+$00)
F6D2: EB 10    addb (x+$10)
F6D4: E1 14    cmpb (x+$14)
F6D6: 27 12    beq  $F6EA
F6D8: E7 00    stb  (x+$00)
F6DA: E6 00    ldb  (x+$00)
F6DC: E7 08    stb  (x+$08)
F6DE: AB 04    adda (x+$04)
F6E0: 60 04    neg  (x+$04)
F6E2: 16       tab  
F6E3: DE 84    ldx  $84
F6E5: AD 00    jsr  (x+$00)
F6E7: 7E F6 59 jmp  $F659
F6EA: DE 8C    ldx  $8C
F6EC: 39       rts  
F6ED: 54       lsrb 
F6EE: 54       lsrb 
F6EF: 54       lsrb 
F6F0: 54       lsrb 
F6F1: 54       lsrb 
F6F2: 54       lsrb 
F6F3: 54       lsrb 
F6F4: 54       lsrb 
F6F5: F7 20 02 stb  $2002
F6F8: 39       rts  
F6F9: BD F6 41 jsr  $F641
F6FC: CE F7 6C ldx  #$F76C
F6FF: 20 0E    bra  $F70F
F701: BD F6 41 jsr  $F641
F704: CE F7 50 ldx  #$F750
F707: 20 06    bra  $F70F
F709: BD F6 41 jsr  $F641
F70C: CE F7 34 ldx  #$F734
F70F: C6 1C    ldb  #$1C
F711: BD F2 AC jsr  $F2AC
F714: 7E F6 50 jmp  $F650
F717: 39       rts  
F718: FF FF FF stx  $FFFF
F71B: 90 FF    suba $FF
F71D: FF FF FF stx  $FFFF
F720: FF FF FF stx  $FFFF
F723: 90 FF    suba $FF
F725: FF FF FF stx  $FFFF
F728: FF FF FF stx  $FFFF
F72B: FF 00 00 stx  $0000
F72E: 00       illegal
F72F: 00       illegal
F730: 00       illegal
F731: 00       illegal
F732: 00       illegal
F733: 00       illegal
F734: 30       tsx  
F735: 00       illegal
F736: 00       illegal
F737: 00       illegal
F738: 7F 00 00 clr  $0000
F73B: 00       illegal
F73C: 30       tsx  
F73D: 00       illegal
F73E: 00       illegal
F73F: 00       illegal
F740: 01       nop  
F741: 00       illegal
F742: 00       illegal
F743: 00       illegal
F744: 7F 00 00 clr  $0000
F747: 00       illegal
F748: 02       illegal
F749: 00       illegal
F74A: 00       illegal
F74B: 00       illegal
F74C: 01       nop  
F74D: 00       illegal
F74E: 00       illegal
F74F: 00       illegal
F750: 04       illegal
F751: 00       illegal
F752: 00       illegal
F753: 04       illegal
F754: 7F 00 00 clr  $0000
F757: 7F 04 00 clr  $0400
F75A: 00       illegal
F75B: 04       illegal
F75C: FF 00 00 stx  $0000
F75F: A0 00    suba (x+$00)
F761: 00       illegal
F762: 00       illegal
F763: 00       illegal
F764: 00       illegal
F765: 00       illegal
F766: 00       illegal
F767: 00       illegal
F768: FF 00 00 stx  $0000
F76B: A0 02    suba (x+$02)
F76D: 80 00    suba #$00
F76F: 30       tsx  
F770: 0A       clv  
F771: 7F 00 7F clr  $007F
F774: 02       illegal
F775: 80 00    suba #$00
F777: 30       tsx  
F778: C0 80    subb #$80
F77A: 00       illegal
F77B: 20 01    bra  $F77E
F77D: 10       sba  
F77E: 00       illegal
F77F: 15       illegal
F780: C0 10    subb #$10
F782: 00       illegal
F783: 00       illegal
F784: C0 80    subb #$80
F786: 00       illegal
F787: 00       illegal
F788: BD F6 41 jsr  $F641
F78B: 86 80    lda  #$80
F78D: 97 9A    sta  $9A
F78F: 86 F7    lda  #$F7
F791: 97 98    sta  $98
F793: 86 80    lda  #$80
F795: 97 87    sta  $87
F797: 86 12    lda  #$12
F799: 4A       deca 
F79A: 26 FD    bne  $F799
F79C: 96 97    lda  $97
F79E: 9B 9A    adda $9A
F7A0: 97 97    sta  $97
F7A2: 44       lsra 
F7A3: 44       lsra 
F7A4: 44       lsra 
F7A5: 8B BF    adda #$BF
F7A7: 97 99    sta  $99
F7A9: DE 98    ldx  $98
F7AB: A6 00    lda  (x+$00)
F7AD: B7 20 02 sta  $2002
F7B0: 7A 00 87 dec  $0087
F7B3: 26 E2    bne  $F797
F7B5: 7A 00 9A dec  $009A
F7B8: 96 9A    lda  $9A
F7BA: 81 20    cmpa #$20
F7BC: 26 D5    bne  $F793
F7BE: 39       rts  
F7BF: 80 8C    suba #$8C
F7C1: 98 A5    eora $A5
F7C3: B0 BC C6 suba $BCC6
F7C6: D0 DA    subb $DA
F7C8: E2 EA    sbcb (x+$EA)
F7CA: F0 F5 FA subb $F5FA
F7CD: FD       illegal
F7CE: FE FF FE ldx  $FFFE
F7D1: FD       illegal
F7D2: FA F5 F0 orb  $F5F0
F7D5: EA E2    orb  (x+$E2)
F7D7: DA D0    orb  $D0
F7D9: C6 BC    ldb  #$BC
F7DB: B0 A5 98 suba $A598
F7DE: 8C 80 73 cmpx #$8073
F7E1: 67 5A    asr  (x+$5A)
F7E3: 4F       clra 
F7E4: 43       coma 
F7E5: 39       rts  
F7E6: 2F 25    ble  $F80D
F7E8: 1D       illegal
F7E9: 15       illegal
F7EA: 0F       sei  
F7EB: 0A       clv  
F7EC: 05       illegal
F7ED: 02       illegal
F7EE: 01       nop  
F7EF: 00       illegal
F7F0: 01       nop  
F7F1: 02       illegal
F7F2: 05       illegal
F7F3: 0A       clv  
F7F4: 0F       sei  
F7F5: 15       illegal
F7F6: 1D       illegal
F7F7: 25 2F    bcs  $F828
F7F9: 39       rts  
F7FA: 43       coma 
F7FB: 4F       clra 
F7FC: 5A       decb 
F7FD: 67 73    asr  (x+$73)
F7FF: FE 04 02 ldx  $0402
F802: 04       illegal
F803: FF 00 BD stx  $00BD
F806: F6 41 CE ldb  $41CE
F809: F7 FF BD stb  $FFBD
F80C: F8 36 7E eorb $367E
F80F: F8 4F 50 eorb $4F50
F812: FF 00 00 stx  $0000
F815: 60 80    neg  (x+$80)
F817: BD F6 41 jsr  $F641
F81A: C6 30    ldb  #$30
F81C: CE F8 11 ldx  #$F811
F81F: 8D 15    bsr  $F836
F821: 96 81    lda  $81
F823: 48       asla 
F824: 9B 81    adda $81
F826: 8B 0B    adda #$0B
F828: 97 81    sta  $81
F82A: 44       lsra 
F82B: 44       lsra 
F82C: 8B 0C    adda #$0C
F82E: 97 91    sta  $91
F830: 8D 1D    bsr  $F84F
F832: 5A       decb 
F833: 26 EC    bne  $F821
F835: 39       rts  
F836: A6 00    lda  (x+$00)
F838: 97 91    sta  $91
F83A: A6 01    lda  (x+$01)
F83C: 97 92    sta  $92
F83E: A6 02    lda  (x+$02)
F840: 97 93    sta  $93
F842: A6 03    lda  (x+$03)
F844: 97 94    sta  $94
F846: A6 04    lda  (x+$04)
F848: 97 95    sta  $95
F84A: A6 05    lda  (x+$05)
F84C: 97 96    sta  $96
F84E: 39       rts  
F84F: 96 89    lda  $89
F851: 37       pshb 
F852: D6 95    ldb  $95
F854: D7 97    stb  $97
F856: D6 92    ldb  $92
F858: D7 98    stb  $98
F85A: 43       coma 
F85B: D6 91    ldb  $91
F85D: B7 20 02 sta  $2002
F860: 5A       decb 
F861: 26 FD    bne  $F860
F863: 43       coma 
F864: D6 91    ldb  $91
F866: 20 00    bra  $F868
F868: 08       inx  
F869: 09       dex  
F86A: 08       inx  
F86B: 09       dex  
F86C: B7 20 02 sta  $2002
F86F: 5A       decb 
F870: 26 FD    bne  $F86F
F872: 7A 00 98 dec  $0098
F875: 27 16    beq  $F88D
F877: 7A 00 97 dec  $0097
F87A: 26 DE    bne  $F85A
F87C: 43       coma 
F87D: D6 95    ldb  $95
F87F: B7 20 02 sta  $2002
F882: D7 97    stb  $97
F884: D6 91    ldb  $91
F886: 9B 96    adda $96
F888: 2B 1E    bmi  $F8A8
F88A: 01       nop  
F88B: 20 15    bra  $F8A2
F88D: 08       inx  
F88E: 09       dex  
F88F: 01       nop  
F890: 43       coma 
F891: D6 92    ldb  $92
F893: B7 20 02 sta  $2002
F896: D7 98    stb  $98
F898: D6 91    ldb  $91
F89A: D0 93    subb $93
F89C: D1 94    cmpb $94
F89E: D1 94    cmpb $94
F8A0: 27 06    beq  $F8A8
F8A2: D7 91    stb  $91
F8A4: C0 05    subb #$05
F8A6: 20 B8    bra  $F860
F8A8: 33       pulb 
F8A9: 39       rts  
F8AA: 86 00    lda  #$00
F8AC: 20 29    bra  $F8D7
F8AE: 86 01    lda  #$01
F8B0: 20 25    bra  $F8D7
F8B2: 86 02    lda  #$02
F8B4: 20 21    bra  $F8D7
F8B6: 86 03    lda  #$03
F8B8: 8D 1D    bsr  $F8D7
F8BA: 86 04    lda  #$04
F8BC: 20 19    bra  $F8D7
F8BE: 0D       sec  
F8BF: 40       nega 
F8C0: F0 FF 12 subb $FF12
F8C3: 08       inx  
F8C4: A8 18    eora (x+$18)
F8C6: 01       nop  
F8C7: 08       inx  
F8C8: 04       illegal
F8C9: A8 18    eora (x+$18)
F8CB: 01       nop  
F8CC: 10       sba  
F8CD: 04       illegal
F8CE: 20 F8    bra  $F8C8
F8D0: FF 20 10 stx  $2010
F8D3: F0 10 01 subb $1001
F8D6: 01       nop  
F8D7: CE D9 39 ldx  #$D939
F8DA: DF 80    stx  $80
F8DC: 16       tab  
F8DD: 48       asla 
F8DE: 48       asla 
F8DF: 1B       aba  
F8E0: CE F8 BE ldx  #$F8BE
F8E3: BD E1 6D jsr  $E16D
F8E6: 7E F9 50 jmp  $F950
F8E9: CE F9 08 ldx  #$F908
F8EC: DF A1    stx  $A1
F8EE: BD FA 32 jsr  $FA32
F8F1: CE A5 00 ldx  #$A500
F8F4: DF 80    stx  $80
F8F6: CE F9 31 ldx  #$F931
F8F9: BD F9 3B jsr  $F93B
F8FC: BD F9 D6 jsr  $F9D6
F8FF: CE F9 36 ldx  #$F936
F902: BD F9 3B jsr  $F93B
F905: 7E F9 E3 jmp  $F9E3
F908: 90 10    suba $10
F90A: 02       illegal
F90B: 14       illegal
F90C: 40       nega 
F90D: B4 40 FF anda $40FF
F910: 14       illegal
F911: 30       tsx  
F912: D0 32    subb $32
F914: 02       illegal
F915: 10       sba  
F916: 60 EE    neg  (x+$EE)
F918: 20 02    bra  $F91C
F91A: 08       inx  
F91B: 54       lsrb 
F91C: E9 54    adcb (x+$54)
F91E: FF 20 28 stx  $2028
F921: C0 30    subb #$30
F923: 02       illegal
F924: 14       illegal
F925: 58       aslb 
F926: AC 20    cmpx (x+$20)
F928: 02       illegal
F929: 08       inx  
F92A: 58       aslb 
F92B: A6 58    lda  (x+$58)
F92D: FF 18 22 stx  $1822
F930: 00       illegal
F931: 30       tsx  
F932: 10       sba  
F933: FC       illegal
F934: 00       illegal
F935: 01       nop  
F936: 30       tsx  
F937: FC       illegal
F938: 01       nop  
F939: 00       illegal
F93A: 01       nop  
F93B: A6 00    lda  (x+$00)
F93D: 97 A8    sta  $A8
F93F: A6 01    lda  (x+$01)
F941: 97 91    sta  $91
F943: A6 02    lda  (x+$02)
F945: 97 90    sta  $90
F947: A6 03    lda  (x+$03)
F949: 97 95    sta  $95
F94B: A6 04    lda  (x+$04)
F94D: 97 AD    sta  $AD
F94F: 39       rts  
F950: 8D E9    bsr  $F93B
F952: 8D 30    bsr  $F984
F954: 8D 58    bsr  $F9AE
F956: 96 AC    lda  $AC
F958: 91 AD    cmpa $AD
F95A: 26 F8    bne  $F954
F95C: 59       rolb 
F95D: F7 20 02 stb  $2002
F960: 8D 2D    bsr  $F98F
F962: 8D 38    bsr  $F99C
F964: 8D 5C    bsr  $F9C2
F966: 7D 00 91 tst  $0091
F969: 27 E4    beq  $F94F
F96B: 7D 00 92 tst  $0092
F96E: 26 E4    bne  $F954
F970: 7D 00 95 tst  $0095
F973: 27 DF    beq  $F954
F975: 2B 05    bmi  $F97C
F977: 7C 00 AD inc  $00AD
F97A: 20 D8    bra  $F954
F97C: 7A 00 AD dec  $00AD
F97F: 7A 00 AC dec  $00AC
F982: 20 D0    bra  $F954
F984: 7F 00 92 clr  $0092
F987: 96 AD    lda  $AD
F989: 97 AC    sta  $AC
F98B: 7F 00 AB clr  $00AB
F98E: 39       rts  
F98F: 96 81    lda  $81
F991: 44       lsra 
F992: 44       lsra 
F993: 44       lsra 
F994: 98 81    eora $81
F996: 97 A6    sta  $A6
F998: 08       inx  
F999: 84 07    anda #$07
F99B: 39       rts  
F99C: 96 A6    lda  $A6
F99E: 44       lsra 
F99F: 76 00 80 ror  $0080
F9A2: 76 00 81 ror  $0081
F9A5: 86 00    lda  #$00
F9A7: 24 02    bcc  $F9AB
F9A9: 96 91    lda  $91
F9AB: 97 AB    sta  $AB
F9AD: 39       rts  
F9AE: 96 AD    lda  $AD
F9B0: 7A 00 AC dec  $00AC
F9B3: 27 04    beq  $F9B9
F9B5: 08       inx  
F9B6: 09       dex  
F9B7: 20 08    bra  $F9C1
F9B9: 97 AC    sta  $AC
F9BB: D6 AB    ldb  $AB
F9BD: 54       lsrb 
F9BE: 7C 00 92 inc  $0092
F9C1: 39       rts  
F9C2: 96 A8    lda  $A8
F9C4: 91 92    cmpa $92
F9C6: 27 04    beq  $F9CC
F9C8: 08       inx  
F9C9: 09       dex  
F9CA: 20 09    bra  $F9D5
F9CC: 7F 00 92 clr  $0092
F9CF: 96 91    lda  $91
F9D1: 90 90    suba $90
F9D3: 97 91    sta  $91
F9D5: 39       rts  
F9D6: 7F 00 9F clr  $009F
F9D9: 7F 00 A9 clr  $00A9
F9DC: 86 0E    lda  #$0E
F9DE: 97 A0    sta  $A0
F9E0: 7F 00 A5 clr  $00A5
F9E3: 8D 9F    bsr  $F984
F9E5: 8D A8    bsr  $F98F
F9E7: BD FA 6C jsr  $FA6C
F9EA: 8D B0    bsr  $F99C
F9EC: BD FA 6C jsr  $FA6C
F9EF: 8D BD    bsr  $F9AE
F9F1: 8D 79    bsr  $FA6C
F9F3: 8D CD    bsr  $F9C2
F9F5: 8D 75    bsr  $FA6C
F9F7: 8D 0A    bsr  $FA03
F9F9: 8D 71    bsr  $FA6C
F9FB: 8D 1D    bsr  $FA1A
F9FD: 8D 6D    bsr  $FA6C
F9FF: 8D 52    bsr  $FA53
FA01: 20 E2    bra  $F9E5
FA03: 96 A4    lda  $A4
FA05: 7A 00 A0 dec  $00A0
FA08: 27 07    beq  $FA11
FA0A: B6 00 91 lda  $0091
FA0D: 26 0A    bne  $FA19
FA0F: 20 68    bra  $FA79
FA11: 97 A0    sta  $A0
FA13: 96 9F    lda  $9F
FA15: 9B A9    adda $A9
FA17: 97 9F    sta  $9F
FA19: 39       rts  
FA1A: 96 9F    lda  $9F
FA1C: 91 A7    cmpa $A7
FA1E: 27 07    beq  $FA27
FA20: 08       inx  
FA21: 96 91    lda  $91
FA23: 26 2A    bne  $FA4F
FA25: 20 29    bra  $FA50
FA27: 7F 00 9F clr  $009F
FA2A: 7F 00 A9 clr  $00A9
FA2D: 7F 00 A5 clr  $00A5
FA30: DE A1    ldx  $A1
FA32: A6 00    lda  (x+$00)
FA34: 97 9E    sta  $9E
FA36: 27 17    beq  $FA4F
FA38: A6 01    lda  (x+$01)
FA3A: 97 A3    sta  $A3
FA3C: A6 02    lda  (x+$02)
FA3E: 97 AA    sta  $AA
FA40: A6 03    lda  (x+$03)
FA42: 97 A4    sta  $A4
FA44: A6 04    lda  (x+$04)
FA46: 97 A7    sta  $A7
FA48: 86 05    lda  #$05
FA4A: BD E1 6D jsr  $E16D
FA4D: DF A1    stx  $A1
FA4F: 39       rts  
FA50: 32       pula 
FA51: 32       pula 
FA52: 39       rts  
FA53: 96 9E    lda  $9E
FA55: 27 06    beq  $FA5D
FA57: 91 91    cmpa $91
FA59: 26 04    bne  $FA5F
FA5B: 20 03    bra  $FA60
FA5D: 08       inx  
FA5E: 09       dex  
FA5F: 39       rts  
FA60: 7F 00 9E clr  $009E
FA63: 96 A3    lda  $A3
FA65: 97 9F    sta  $9F
FA67: 96 AA    lda  $AA
FA69: 97 A9    sta  $A9
FA6B: 39       rts  
;;
FA6C: 96 A5    lda  $A5
FA6E: 9B 9F    adda $9F
FA70: 97 A5    sta  $A5
FA72: 2A 01    bpl  $FA75
FA74: 43       coma 
FA75: 1B       aba  
FA76: B7 20 02 sta  $2002
FA79: 39       rts  
;; WALSH FUNCTION SOUND MACHINE
;;NTHRVC
FA7A: C0 0D    subb #$0D
FA7C: 37       pshb 
FA7D: BD 00 AC jsr  $00AC
FA80: 33       pulb 
;;NXTSMP
FA81: C1 14    cmpb #$14
FA83: 22 F5    bhi  $FA7A
FA85: 01       nop  
FA86: 96 A4    lda  $A4
FA88: 9B A1    adda $A1
FA8A: 97 A4    sta  $A4
FA8C: C9 F6    adcb #$F6
FA8E: 5A       decb 
FA8F: 2A FD    bpl  $FA8E
FA91: 96 A8    lda  $A8
FA93: 4C       inca 
FA94: 84 0F    anda #$0F
FA96: 8A 90    ora  #$90
FA98: 97 A8    sta  $A8
FA9A: DE A7    ldx  $A7
FA9C: E6 00    ldb  (x+$00)
FA9E: F7 20 02 stb  $2002
FAA1: 84 0F    anda #$0F
FAA3: 39       rts  
;;WSM
FAA4: 4F       clra 
FAA5: CE 00 90 ldx  #$0090
FAA8: C6 61    ldb  #$61
FAAA: A7 00    sta  (x+$00)
FAAC: 08       inx  
FAAD: 5A       decb 
FAAE: 26 FA    bne  $FAAA
FAB0: C6 DF    ldb  #$DF
FAB2: D7 A6    stb  $A6
FAB4: C6 B7    ldb  #$B7
FAB6: D7 B0    stb  $B0
FAB8: C6 7E    ldb  #$7E
FABA: D7 AC    stb  $AC
FABC: CE FC 8F ldx  #$FC8F
FABF: DF AD    stx  $AD
FAC1: D6 8C    ldb  $8C
FAC3: D7 A3    stb  $A3
FAC5: C0 03    subb #$03
FAC7: BD FA 81 jsr  $FA81
FACA: 08       inx  
FACB: D6 A3    ldb  $A3
FACD: C0 02    subb #$02
FACF: BD FA 7A jsr  $FA7A
FAD2: 26 F7    bne  $FACB
FAD4: D6 A0    ldb  $A0
FAD6: 96 A1    lda  $A1
FAD8: 9B 8D    adda $8D
FADA: D9 8C    adcb $8C
FADC: 97 8D    sta  $8D
FADE: D7 8C    stb  $8C
FAE0: DB A2    addb $A2
FAE2: 86 19    lda  #$19
FAE4: 11       cba  
FAE5: 24 01    bcc  $FAE8
FAE7: 81 16    cmpa #$16
FAE9: D7 A3    stb  $A3
FAEB: 01       nop  
FAEC: C0 09    subb #$09
FAEE: BD FA 81 jsr  $FA81
FAF1: 96 AF    lda  $AF
FAF3: 16       tab  
FAF4: 48       asla 
FAF5: C9 00    adcb #$00
FAF7: D7 AF    stb  $AF
FAF9: D6 A3    ldb  $A3
FAFB: C0 05    subb #$05
FAFD: 96 A5    lda  $A5
FAFF: 2A 06    bpl  $FB07
FB01: 7C 00 A5 inc  $00A5
FB04: 01       nop  
FB05: 20 BE    bra  $FAC5
FB07: 5A       decb 
FB08: BD FA 81 jsr  $FA81
FB0B: DE 8A    ldx  $8A
FB0D: A6 00    lda  (x+$00)
FB0F: 2A 12    bpl  $FB23
FB11: 81 80    cmpa #$80
FB13: 27 5F    beq  $FB74
FB15: 4C       inca 
FB16: 97 A5    sta  $A5
FB18: 08       inx  
FB19: FF 00 8A stx  $008A
FB1C: D6 A3    ldb  $A3
FB1E: C0 06    subb #$06
FB20: 7E FA C5 jmp  $FAC5
FB23: 08       inx  
FB24: E6 00    ldb  (x+$00)
FB26: 37       pshb 
FB27: 08       inx  
FB28: DF 8A    stx  $8A
FB2A: 97 A9    sta  $A9
FB2C: 84 70    anda #$70
FB2E: 44       lsra 
FB2F: 44       lsra 
FB30: 44       lsra 
FB31: 5F       clrb 
FB32: 8B 08    adda #$08
FB34: C9 FC    adcb #$FC
FB36: 97 AB    sta  $AB
FB38: D7 AA    stb  $AA
FB3A: D6 A3    ldb  $A3
FB3C: D6 A3    ldb  $A3
FB3E: C0 0D    subb #$0D
FB40: BD FA 81 jsr  $FA81
FB43: 5F       clrb 
FB44: DE AA    ldx  $AA
FB46: EE 00    ldx  (x+$00)
FB48: 6E 00    jmp  (x+$00)
FB4A: 96 A9    lda  $A9
FB4C: 47       asra 
FB4D: C2 00    sbcb #$00
FB4F: D4 8C    andb $8C
FB51: 32       pula 
FB52: 10       sba  
FB53: 9B 8C    adda $8C
FB55: 97 8C    sta  $8C
FB57: 08       inx  
FB58: D6 A3    ldb  $A3
FB5A: C0 0A    subb #$0A
FB5C: 7E FA C7 jmp  $FAC7
FB5F: 96 A9    lda  $A9
FB61: 47       asra 
FB62: C2 00    sbcb #$00
FB64: D4 A2    andb $A2
FB66: 32       pula 
FB67: 10       sba  
FB68: 9B A2    adda $A2
FB6A: 97 A2    sta  $A2
FB6C: 20 EA    bra  $FB58
FB6E: 32       pula 
FB6F: DE 8A    ldx  $8A
FB71: 09       dex  
FB72: 6E 00    jmp  (x+$00)
FB74: 96 A6    lda  $A6
FB76: 81 DF    cmpa #$DF
FB78: 2B 01    bmi  $FB7B
FB7A: 39       rts  
FB7B: D6 A3    ldb  $A3
FB7D: C0 07    subb #$07
FB7F: BD FA 81 jsr  $FA81
FB82: DE A5    ldx  $A5
FB84: 6A 02    dec  (x+$02)
FB86: 2B 12    bmi  $FB9A
FB88: EE 00    ldx  (x+$00)
FB8A: A6 00    lda  (x+$00)
FB8C: 36       psha 
FB8D: 08       inx  
FB8E: DF 8A    stx  $8A
FB90: F6 00 A3 ldb  $00A3
FB93: C0 09    subb #$09
FB95: BD FA 81 jsr  $FA81
FB98: 20 55    bra  $FBEF
FB9A: EE 00    ldx  (x+$00)
FB9C: 08       inx  
FB9D: DF 8A    stx  $8A
FB9F: 96 A6    lda  $A6
FBA1: 8B 03    adda #$03
FBA3: 97 A6    sta  $A6
FBA5: D6 A3    ldb  $A3
FBA7: C0 07    subb #$07
FBA9: 01       nop  
FBAA: 7E FA C5 jmp  $FAC5
FBAD: 08       inx  
FBAE: 20 04    bra  $FBB4
FBB0: D7 A0    stb  $A0
FBB2: D7 A1    stb  $A1
FBB4: D6 A9    ldb  $A9
FBB6: C4 0F    andb #$0F
FBB8: CB F8    addb #$F8
FBBA: C8 F8    eorb #$F8
FBBC: 32       pula 
FBBD: 9B A1    adda $A1
FBBF: D9 A0    adcb $A0
FBC1: 97 A1    sta  $A1
FBC3: D7 A0    stb  $A0
FBC5: F6 00 A3 ldb  $00A3
FBC8: C0 09    subb #$09
FBCA: 7E FA C5 jmp  $FAC5
FBCD: 96 A6    lda  $A6
FBCF: 80 03    suba #$03
FBD1: 97 A6    sta  $A6
FBD3: DE A5    ldx  $A5
FBD5: 96 8B    lda  $8B
FBD7: D6 8A    ldb  $8A
FBD9: 8B FF    adda #$FF
FBDB: C9 FF    adcb #$FF
FBDD: E7 00    stb  (x+$00)
FBDF: A7 01    sta  (x+$01)
FBE1: D6 A9    ldb  $A9
FBE3: C4 0F    andb #$0F
FBE5: E7 02    stb  (x+$02)
FBE7: D6 A3    ldb  $A3
FBE9: C0 0C    subb #$0C
FBEB: BD FA 81 jsr  $FA81
FBEE: 08       inx  
FBEF: 08       inx  
FBF0: 08       inx  
FBF1: 5F       clrb 
FBF2: 01       nop  
FBF3: 32       pula 
FBF4: 47       asra 
FBF5: 49       rola 
FBF6: C2 00    sbcb #$00
FBF8: 9B 8B    adda $8B
FBFA: D9 8A    adcb $8A
FBFC: 97 8B    sta  $8B
FBFE: F7 00 8A stb  $008A
FC01: D6 A3    ldb  $A3
FC03: C0 07    subb #$07
FC05: 7E FA C5 jmp  $FAC5
FC08: FB 4A FB addb $4AFB
FC0B: 5F       clrb 
FC0C: FB B0 FB addb $B0FB
FC0F: AD FB    jsr  (x+$FB)
FC11: 4A       deca 
FC12: FB 6E FB addb $6EFB
FC15: CD       illegal
FC16: FB F3 FD addb $F3FD
FC19: 8C FE 15 cmpx #$FE15
FC1C: FC       illegal
FC1D: C4 FD    andb #$FD
FC1F: BD FC 3F jsr  $FC3F
FC22: FD       illegal
FC23: CE FC 6A ldx  #$FC6A
FC26: FD       illegal
FC27: 01       nop  
FC28: DE AF    ldx  $AF
FC2A: EE 03    ldx  (x+$03)
FC2C: 08       inx  
FC2D: DF 88    stx  $88
FC2F: BD FC FB jsr  $FCFB
FC32: 08       inx  
FC33: 39       rts  
FC34: EE 00    ldx  (x+$00)
FC36: DF 88    stx  $88
FC38: CE FD 01 ldx  #$FD01
FC3B: DF AD    stx  $AD
FC3D: 01       nop  
FC3E: 39       rts  
FC3F: 96 B0    lda  $B0
FC41: 81 B7    cmpa #$B7
FC43: 23 12    bls  $FC57
FC45: DE AF    ldx  $AF
FC47: 6A 02    dec  (x+$02)
FC49: 2A E9    bpl  $FC34
FC4B: 80 03    suba #$03
FC4D: 97 B0    sta  $B0
FC4F: CE FC 28 ldx  #$FC28
FC52: DF AD    stx  $AD
FC54: 6D 00    tst  (x+$00)
FC56: 39       rts  
FC57: CE FC 5F ldx  #$FC5F
FC5A: DF AD    stx  $AD
FC5C: 01       nop  
FC5D: 20 05    bra  $FC64
FC5F: 08       inx  
FC60: 08       inx  
FC61: 01       nop  
FC62: 8D 05    bsr  $FC69
FC64: 8D 03    bsr  $FC69
FC66: 6D 00    tst  (x+$00)
FC68: 01       nop  
FC69: 39       rts  
FC6A: DE AF    ldx  $AF
FC6C: 96 88    lda  $88
FC6E: A7 03    sta  (x+$03)
FC70: 96 89    lda  $89
FC72: A7 04    sta  (x+$04)
FC74: 96 B9    lda  $B9
FC76: 84 0F    anda #$0F
FC78: A7 05    sta  (x+$05)
FC7A: 08       inx  
FC7B: CE FC 81 ldx  #$FC81
FC7E: DF AD    stx  $AD
FC80: 39       rts  
FC81: 96 B0    lda  $B0
FC83: 8B 03    adda #$03
FC85: 97 B0    sta  $B0
FC87: CE FD 01 ldx  #$FD01
FC8A: DF AD    stx  $AD
FC8C: 01       nop  
FC8D: 20 D5    bra  $FC64
FC8F: 7D 00 AF tst  $00AF
FC92: 26 CE    bne  $FC62
FC94: DE 88    ldx  $88
FC96: A6 00    lda  (x+$00)
FC98: 08       inx  
FC99: DF 88    stx  $88
FC9B: 97 B9    sta  $B9
FC9D: 2A 05    bpl  $FCA4
FC9F: 97 AF    sta  $AF
FCA1: A6 00    lda  (x+$00)
FCA3: 39       rts  
FCA4: CE FC AB ldx  #$FCAB
FCA7: FF 00 AD stx  $00AD
FCAA: 39       rts  
FCAB: 5F       clrb 
FCAC: 96 B9    lda  $B9
FCAE: 84 70    anda #$70
FCB0: 44       lsra 
FCB1: 44       lsra 
FCB2: 44       lsra 
FCB3: 8B 18    adda #$18
FCB5: C9 FC    adcb #$FC
FCB7: D7 B7    stb  $B7
FCB9: 97 B8    sta  $B8
FCBB: DE B7    ldx  $B7
FCBD: EE 00    ldx  (x+$00)
FCBF: DF AD    stx  $AD
FCC1: DF AD    stx  $AD
FCC3: 39       rts  
FCC4: 96 B9    lda  $B9
FCC6: 84 0F    anda #$0F
FCC8: 4C       inca 
FCC9: 4C       inca 
FCCA: 97 AF    sta  $AF
FCCC: 20 1D    bra  $FCEB
FCCE: 7C 00 B2 inc  $00B2
FCD1: DE B1    ldx  $B1
FCD3: 8C 00 E8 cmpx #$00E8
FCD6: 27 13    beq  $FCEB
FCD8: A6 00    lda  (x+$00)
FCDA: CE FD 15 ldx  #$FD15
FCDD: 97 B5    sta  $B5
FCDF: 27 03    beq  $FCE4
FCE1: 7E FC E7 jmp  $FCE7
FCE4: CE FC CE ldx  #$FCCE
FCE7: DF AD    stx  $AD
FCE9: 08       inx  
FCEA: 39       rts  
FCEB: 86 DE    lda  #$DE
FCED: B7 00 B2 sta  $00B2
FCF0: CE FC CE ldx  #$FCCE
FCF3: 7A 00 AF dec  $00AF
FCF6: 27 03    beq  $FCFB
FCF8: 7E FC FE jmp  $FCFE
FCFB: CE FC 8F ldx  #$FC8F
FCFE: DF AD    stx  $AD
FD00: 39       rts  
FD01: DE 88    ldx  $88
FD03: 5F       clrb 
FD04: A6 00    lda  (x+$00)
FD06: 4C       inca 
FD07: 47       asra 
FD08: 49       rola 
FD09: C2 00    sbcb #$00
FD0B: 9B 89    adda $89
FD0D: D9 88    adcb $88
FD0F: 97 89    sta  $89
FD11: D7 88    stb  $88
FD13: 20 E6    bra  $FCFB
FD15: 96 B2    lda  $B2
FD17: 80 DF    suba #$DF
FD19: 48       asla 
FD1A: 5F       clrb 
FD1B: 9B 8F    adda $8F
FD1D: D9 8E    adcb $8E
FD1F: D7 B7    stb  $B7
FD21: 97 B8    sta  $B8
FD23: 86 80    lda  #$80
FD25: 97 B6    sta  $B6
FD27: CE FD 32 ldx  #$FD32
FD2A: DF AD    stx  $AD
FD2C: CE 00 90 ldx  #$0090
FD2F: DF B3    stx  $B3
FD31: 39       rts  
FD32: DE B7    ldx  $B7
FD34: EE 00    ldx  (x+$00)
FD36: DF B7    stx  $B7
FD38: CE FD 47 ldx  #$FD47
FD3B: DF AD    stx  $AD
FD3D: DE B1    ldx  $B1
FD3F: A6 09    lda  (x+$09)
FD41: 9B B5    adda $B5
FD43: A7 09    sta  (x+$09)
FD45: 08       inx  
FD46: 39       rts  
FD47: 96 B6    lda  $B6
FD49: 27 1D    beq  $FD68
FD4B: 74 00 B6 lsr  $00B6
FD4E: DE B3    ldx  $B3
FD50: E6 00    ldb  (x+$00)
FD52: 94 B7    anda $B7
FD54: 26 09    bne  $FD5F
FD56: FB 00 B5 addb $00B5
FD59: E7 00    stb  (x+$00)
FD5B: 7C 00 B4 inc  $00B4
FD5E: 39       rts  
FD5F: F0 00 B5 subb $00B5
FD62: E7 00    stb  (x+$00)
FD64: 7C 00 B4 inc  $00B4
FD67: 39       rts  
FD68: D6 B4    ldb  $B4
FD6A: C1 A0    cmpb #$A0
FD6C: 27 0B    beq  $FD79
FD6E: D6 B8    ldb  $B8
FD70: D7 B7    stb  $B7
FD72: C6 80    ldb  #$80
FD74: F7 00 B6 stb  $00B6
FD77: 20 0F    bra  $FD88
FD79: CE FC 8F ldx  #$FC8F
FD7C: D6 AF    ldb  $AF
FD7E: 26 03    bne  $FD83
FD80: 7E FD 86 jmp  $FD86
FD83: CE FC CE ldx  #$FCCE
FD86: DF AD    stx  $AD
FD88: 6D 00    tst  (x+$00)
FD8A: 08       inx  
FD8B: 39       rts  
FD8C: 96 B9    lda  $B9
FD8E: 84 07    anda #$07
FD90: 8B E0    adda #$E0
FD92: 97 B2    sta  $B2
FD94: DE 88    ldx  $88
FD96: A6 00    lda  (x+$00)
FD98: 08       inx  
FD99: DF 88    stx  $88
FD9B: 97 B5    sta  $B5
FD9D: CE FD A4 ldx  #$FDA4
FDA0: DF AD    stx  $AD
FDA2: 08       inx  
FDA3: 39       rts  
FDA4: DE B1    ldx  $B1
FDA6: 5F       clrb 
FDA7: 96 B9    lda  $B9
FDA9: 8B F8    adda #$F8
FDAB: C2 00    sbcb #$00
FDAD: E4 09    andb (x+$09)
FDAF: 50       negb 
FDB0: DB B5    addb $B5
FDB2: D7 B5    stb  $B5
FDB4: CE FD 15 ldx  #$FD15
FDB7: DF AD    stx  $AD
FDB9: 08       inx  
FDBA: 08       inx  
FDBB: 01       nop  
FDBC: 39       rts  
FDBD: D6 B9    ldb  $B9
FDBF: 54       lsrb 
FDC0: C4 07    andb #$07
FDC2: CA E0    orb  #$E0
FDC4: D7 B2    stb  $B2
FDC6: C6 FF    ldb  #$FF
FDC8: C9 00    adcb #$00
FDCA: C9 00    adcb #$00
FDCC: 20 E4    bra  $FDB2
FDCE: 96 B9    lda  $B9
FDD0: 47       asra 
FDD1: 25 13    bcs  $FDE6
FDD3: CE 00 00 ldx  #$0000
FDD6: DF E0    stx  $E0
FDD8: DF E2    stx  $E2
FDDA: DF E4    stx  $E4
FDDC: DF E6    stx  $E6
FDDE: 08       inx  
FDDF: CE FC 8F ldx  #$FC8F
FDE2: FF 00 AD stx  $00AD
FDE5: 39       rts  
FDE6: 85 02    bita #$02
FDE8: 26 0C    bne  $FDF6
FDEA: C6 DF    ldb  #$DF
FDEC: D7 B2    stb  $B2
FDEE: CE FD FB ldx  #$FDFB
FDF1: DF AD    stx  $AD
FDF3: 7E FC 66 jmp  $FC66
FDF6: FE 00 88 ldx  $0088
FDF9: 20 F6    bra  $FDF1
FDFB: 5F       clrb 
FDFC: 96 B9    lda  $B9
FDFE: 8B AE    adda #$AE
FE00: C2 00    sbcb #$00
FE02: D4 E8    andb $E8
FE04: DE 88    ldx  $88
FE06: A6 00    lda  (x+$00)
FE08: 08       inx  
FE09: DF 88    stx  $88
FE0B: 10       sba  
FE0C: 97 B5    sta  $B5
FE0E: CE FD 15 ldx  #$FD15
FE11: FF 00 AD stx  $00AD
FE14: 39       rts  
FE15: C6 E0    ldb  #$E0
FE17: D7 B2    stb  $B2
FE19: DE 88    ldx  $88
FE1B: E6 00    ldb  (x+$00)
FE1D: D7 B7    stb  $B7
FE1F: 08       inx  
FE20: DF 88    stx  $88
FE22: D6 B9    ldb  $B9
FE24: 54       lsrb 
FE25: 24 18    bcc  $FE3F
FE27: CE FE 59 ldx  #$FE59
FE2A: DF AD    stx  $AD
FE2C: 39       rts  
FE2D: 5F       clrb 
FE2E: 96 B8    lda  $B8
FE30: 47       asra 
FE31: C2 00    sbcb #$00
FE33: DE B1    ldx  $B1
FE35: E4 00    andb (x+$00)
FE37: 1B       aba  
FE38: A7 00    sta  (x+$00)
FE3A: 7C 00 B2 inc  $00B2
FE3D: A6 00    lda  (x+$00)
FE3F: CE FE 45 ldx  #$FE45
FE42: DF AD    stx  $AD
FE44: 39       rts  
FE45: 78 00 B7 asl  $00B7
FE48: 25 13    bcs  $FE5D
FE4A: 27 06    beq  $FE52
FE4C: 7C 00 B2 inc  $00B2
FE4F: 7E FC 64 jmp  $FC64
FE52: BD FC FB jsr  $FCFB
FE55: 6D 00    tst  (x+$00)
FE57: 01       nop  
FE58: 39       rts  
FE59: 7A 00 B2 dec  $00B2
FE5C: 08       inx  
FE5D: A6 00    lda  (x+$00)
FE5F: DE 88    ldx  $88
FE61: A6 00    lda  (x+$00)
FE63: 08       inx  
FE64: DF 88    stx  $88
FE66: 97 B8    sta  $B8
FE68: CE FE 2D ldx  #$FE2D
FE6B: DF AD    stx  $AD
FE6D: 39       rts  
;;ODDTBL
FE6E: 0000       illegal
FE70: 5555       illegal
FE72: 3333       pulb 
FE74: 25DA    bcs  $FE50
FE76: DA25    orb  $25
FE78: C731    stb  #$31
FE7A: 0000       illegal
FE7C: FFFF
FE7E: 01FE
;;WAVE PROGRAMS 
FE80: 53 00 ldx  $5300
FE82: 66 16    ror  (x+$16)
FE84: 66 1A    ror  (x+$1A)
FE86: 66 1E    ror  (x+$1E)
FE88: 66 21    ror  (x+$21)
FE8A: 66 24    ror  (x+$24)
FE8C: 08       inx  
FE8D: FF E2 66 stx  $E266
FE90: 1F       illegal
FE91: 66 18    ror  (x+$18)
FE93: 66 11    ror  (x+$11)
FE95: 66 09    ror  (x+$09)
FE97: 66 01    ror  (x+$01)
FE99: 40       nega 
FE9A: 08       inx  
FE9B: 5A       decb 
FE9C: 08       inx  
FE9D: 00       illegal
FE9E: FF 40 08 stx  $4008
FEA1: 96 08    lda  $08
FEA3: 00       illegal
FEA4: FF 40 08 stx  $4008
FEA7: C8 08    eorb #$08
FEA9: 00       illegal
FEAA: 40       nega 
FEAB: 08       inx  
FEAC: E6 08    ldb  (x+$08)
FEAE: 00       illegal
FEAF: 40       nega 
FEB0: 08       inx  
FEB1: FF 08 00 stx  $0800
FEB4: 40       nega 
;; Pitch Program
FEB5: 10       sba  
FEB6: 20 80    bra  $FE38
FEB8: CC       illegal
FEB9: CC       illegal
FEBA: 2F 80    ble  $FE3C
FEBC: E2 20    sbcb (x+$20)
FEBE: 80 EC    suba #$EC
FEC0: 2F 80    ble  $FE42
FEC2: E2 20    sbcb (x+$20)
FEC4: 80 EC    suba #$EC
FEC6: 2F 80    ble  $FE48
FEC8: E2 80    sbcb (x+$80)
FECA: 64 C4    lsr  (x+$C4)
FECC: 80 
;;
FECD: 53    suba #$53
FECE: 00       illegal
FECF: 08       inx  
FED0: 05       illegal
FED1: 0E       cli  
FED2: 00       illegal
FED3: 0D       sec  
FED4: 05       illegal
FED5: FD       illegal
FED6: 0D       sec  
FED7: 00       illegal
FED8: 0E       cli  
FED9: 05       illegal
FEDA: FD       illegal
FEDB: 70 
;;
FEDD: F4 28 
FEDE: 20 40    bra  $FF20
FEE0: CE 20 00 ldx  #$2000
FEE3: 80 10    suba #$10
FEE5: F9 02 02 adcb $0202
FEE8: 02       illegal
FEE9: 02       illegal
FEEA: 02       illegal
FEEB: 02       illegal
FEEC: 2F 50    ble  $FF3E
FEEE: 10       sba  
FEEF: 80 FE    suba #$FE
FEF1: 27 10    beq  $FF03
FEF3: 40       nega 
FEF4: FE 27 10 ldx  $2710
FEF7: A0 00    suba (x+$00)
FEF9: FE 27 10 ldx  $2710
FEFC: 50       negb 
FEFD: 00       illegal
FEFE: FE 27 10 ldx  $2710
FF01: 28 00    bvc  $FF03
FF03: FE 27 10 ldx  $2710
FF06: 11       cba  
FF07: 00       illegal
FF08: FE 27 10 ldx  $2710
FF0B: 08       inx  
FF0C: 00       illegal
FF0D: 27 10    beq  $FF1F
FF0F: 01       nop  
FF10: 00       illegal
FF11: 70 D1 3C neg  $D13C
FF14: 20 78    bra  $FF8E
FF16: 60 01    neg  (x+$01)
FF18: 80 00    suba #$00
FF1A: 01       nop  
FF1B: 00       illegal
FF1C: FF 00 FF stx  $00FF
FF1F: 00       illegal
FF20: 01       nop  
FF21: 80 53    suba #$53
FF23: 00       illegal
FF24: 0C       clc  
FF25: 1E       illegal
FF26: 0B       sev  
FF27: 00       illegal
FF28: 0A       clv  
FF29: 1E       illegal
FF2A: FE 0A 00 ldx  $0A00
FF2D: 0B       sev  
FF2E: 1E       illegal
FF2F: FE 70 F4 ldx  $70F4
FF32: 96 2F    lda  $2F
FF34: D0 D0    subb $D0
FF36: 20 00    bra  $FF38
FF38: EC       illegal
FF39: EC       illegal
FF3A: EC       illegal
FF3B: 70 FB 80 neg  $FB80
;;WALSHT
FF3E: FE 80 FE B5 
FF42: FE CD FE DD  
FF46: FE E4 FF 13       illegal
FF4A: FF 22 FF 32       pula 
FF4E: 86 00    lda  #$00
FF50: 20 6D    bra  $FFBF
FF52: 86 01    lda  #$01
FF54: 20 69    bra  $FFBF
FF56: C6 20    ldb  #$20
FF58: D7 86    stb  $86
FF5A: 86 01    lda  #$01
FF5C: 36       psha 
FF5D: 48       asla 
FF5E: 48       asla 
FF5F: 48       asla 
FF60: 48       asla 
FF61: 20 00    bra  $FF63
FF63: 4A       deca 
FF64: 26 FB    bne  $FF61
FF66: 86 02    lda  #$02
FF68: 8D 55    bsr  $FFBF
FF6A: 7C 00 86 inc  $0086
FF6D: 32       pula 
FF6E: 4C       inca 
FF6F: 81 1C    cmpa #$1C
FF71: 26 E9    bne  $FF5C
FF73: 7F 00 86 clr  $0086
FF76: 39       rts  
FF77: 86 01    lda  #$01
FF79: C6 20    ldb  #$20
FF7B: D7 86    stb  $86
FF7D: 36       psha 
FF7E: 48       asla 
FF7F: 48       asla 
FF80: 16       tab  
FF81: 5A       decb 
FF82: 26 FD    bne  $FF81
FF84: 4A       deca 
FF85: 26 F9    bne  $FF80
FF87: BD E1 5F jsr  $E15F
FF8A: 97 86    sta  $86
FF8C: 86 02    lda  #$02
FF8E: 8D 2F    bsr  $FFBF
FF90: 32       pula 
FF91: 4C       inca 
FF92: 81 0C    cmpa #$0C
FF94: 26 E7    bne  $FF7D
FF96: 7F 00 86 clr  $0086
FF99: 39       rts  
FF9A: C6 30    ldb  #$30
FF9C: D7 86    stb  $86
FF9E: 86 01    lda  #$01
FFA0: 36       psha 
FFA1: 48       asla 
FFA2: 48       asla 
FFA3: 48       asla 
FFA4: 48       asla 
FFA5: 20 00    bra  $FFA7
FFA7: 4A       deca 
FFA8: 26 FB    bne  $FFA5
FFAA: 86 02    lda  #$02
FFAC: 8D 11    bsr  $FFBF
FFAE: 7A 00 86 dec  $0086
FFB1: 32       pula 
FFB2: 4C       inca 
FFB3: 81 0C    cmpa #$0C
FFB5: 26 E9    bne  $FFA0
FFB7: 7F 00 86 clr  $0086
FFBA: 39       rts  
FFBB: 86 03    lda  #$03
FFBD: 20 00    bra  $FFBF
;;WALSH
FFBF: 5F       clrb 
FFC0: D7 8D    stb  $8D
FFC2: 48       asla 
FFC3: 48       asla 
FFC4: 8B 3E    adda #$3E
FFC6: C9 FF    adcb #$FF
FFC8: D7 8A    stb  $8A
FFCA: 97 8B    sta  $8B
FFCC: DE 8A    ldx  $8A
FFCE: EE 00    ldx  (x+$00)
FFD0: DF 88    stx  $88
FFD2: DE 8A    ldx  $8A
FFD4: EE 02    ldx  (x+$02)
FFD6: D6 86    ldb  $86			;;new
FFD8: 26 02    bne  $FFDC		;;new
FFDA: E6 00    ldb  (x+$00)
FFDC: D7 8C    stb  $8C
FFDE: 08       inx  
FFDF: DF 8A    stx  $8A
FFE1: CE FE 6E ldx  #$FE6E
FFE4: DF 8E    stx  $8E
FFE6: 7E FA A4 jmp  $FAA4
;;(padding)
FFE9: FF FF FF
FFEC: FF FF FF
FFEF: FF FF FF
FFF2: FF FF FF
FFF5: FF FF FF
;;VECTORS
FFF8: F02E						;;IRQ
FFFA: F001						;;SETUP
FFFC: F039						;;NMI
FFFE: F001						;;SETUP
