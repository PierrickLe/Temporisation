EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L arduino_nano_every:Arduino_Nano_Every A
U 1 1 5FC07F51
P 6400 7250
F 0 "A" H 6400 8317 50  0001 C CNN
F 1 "Arduino_Nano_Every" H 6400 8225 50  0000 C CNN
F 2 "Module:Arduino_Nano" H 6400 7250 50  0001 C CIN
F 3 "https://www.arduino.cc/en/uploads/Main/ArduinoNanoManual23.pdf" H 6400 7250 50  0001 C CNN
	1    6400 7250
	-1   0    0    1   
$EndComp
$Comp
L Analog_Switch:ADG417BR U?
U 1 1 5FC16EA6
P 3200 8250
F 0 "U?" V 3246 8380 50  0001 L CNN
F 1 "btn INFO" V 3155 8380 50  0000 L BNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 3200 8150 50  0001 C CNN
F 3 "https://www.analog.com/media/en/technical-documentation/data-sheets/ADG417.pdf" H 3200 8250 50  0001 C CNN
	1    3200 8250
	0    -1   -1   0   
$EndComp
Text Notes 6950 2350 0    63   ~ 13
Vers chauffage filaments Ecc88 et Ecc99
Text Notes 12250 10350 0    118  ~ 24
Temporisation Amplificateur casques 
Text Notes 12350 10900 0    51   ~ 0
Temporisation Amplificateur Casques\n
Text Notes 15450 11050 0    63   ~ 0
V1
Text Notes 13200 11050 0    71   ~ 0
27/12/2020
$Comp
L Valve:ECC88 U?
U 3 1 5FC3E893
P 6700 2750
F 0 "U?" H 6928 2713 50  0001 L CNN
F 1 "ECC88" H 6928 2667 50  0000 L CNN
F 2 "Valve:Valve_Noval_P" H 6970 2350 50  0001 C CNN
F 3 "http://www.r-type.org/pdfs/ecc88.pdf" H 6700 2750 50  0001 C CNN
	3    6700 2750
	1    0    0    -1  
$EndComp
$Comp
L Valve:ECC88 U?
U 3 1 5FC3F319
P 7400 2750
F 0 "U?" H 7628 2713 50  0001 L CNN
F 1 "ECC99" H 7628 2667 50  0000 L CNN
F 2 "Valve:Valve_Noval_P" H 7670 2350 50  0001 C CNN
F 3 "http://www.r-type.org/pdfs/ecc88.pdf" H 7400 2750 50  0001 C CNN
	3    7400 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 3500 7500 3200
Wire Wire Line
	7300 3700 7300 3200
Wire Wire Line
	7300 3700 6600 3700
Wire Wire Line
	6600 3700 6600 3200
Wire Wire Line
	7500 3500 6800 3500
Wire Wire Line
	6800 3500 6800 3200
$Comp
L alim_6.3v2a:Alim_6.3V2A U?
U 1 1 5FCAC4A3
P 8900 3500
F 0 "U?" H 9230 3439 50  0001 L CNN
F 1 "Alim_6.3V2A" V 9230 3348 50  0000 L TNN
F 2 "" H 8900 3500 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/cd4543b.pdf" H 8900 3500 50  0001 C CNN
	1    8900 3500
	0    1    1    0   
$EndComp
Wire Wire Line
	8300 3600 7750 3600
Wire Wire Line
	7750 3600 7750 3500
Wire Wire Line
	7750 3500 7500 3500
Connection ~ 7500 3500
Wire Wire Line
	8300 3700 7300 3700
Connection ~ 7300 3700
Wire Wire Line
	8300 3500 8000 3500
Wire Wire Line
	8000 3500 8000 3950
$Comp
L Device:R R?
U 1 1 5FD0C1BD
P 6600 5250
F 0 "R?" H 6670 5296 50  0001 L CNN
F 1 "100K" H 6670 5250 50  0000 L CNN
F 2 "" V 6530 5250 50  0001 C CNN
F 3 "~" H 6600 5250 50  0001 C CNN
	1    6600 5250
	-1   0    0    -1  
$EndComp
Text GLabel 13450 3800 0    50   Input ~ 0
6v12V?
$Comp
L Sensor_Temperature:TMP20AIDCK U?
U 1 1 5FC53841
P 2300 7350
F 0 "U?" H 1971 7396 50  0001 R CNN
F 1 "TMP36" H 1970 7350 50  0000 R CNN
F 2 "Package_TO_SOT_SMD:SOT-353_SC-70-5" H 2300 6950 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/tmp20.pdf" H 2300 7350 50  0001 C CNN
	1    2300 7350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FD91FE0
P 9350 6450
F 0 "R?" V 9557 6450 50  0001 C CNN
F 1 "220" V 9465 6450 50  0000 C CNN
F 2 "" V 9280 6450 50  0001 C CNN
F 3 "~" H 9350 6450 50  0001 C CNN
	1    9350 6450
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9200 6450 8950 6450
$Comp
L power:GND #PWR?
U 1 1 5FDA0381
P 8550 8000
F 0 "#PWR?" H 8550 7750 50  0001 C CNN
F 1 "GND" H 8555 7827 50  0000 C CNN
F 2 "" H 8550 8000 50  0001 C CNN
F 3 "" H 8550 8000 50  0001 C CNN
	1    8550 8000
	-1   0    0    -1  
$EndComp
$Comp
L Relay:DIPxx-1Axx-11x K?
U 1 1 5FC3C5C3
P 9900 5500
F 0 "K?" H 10230 5546 50  0001 L CNN
F 1 "Relais 6.3V" H 9470 5500 50  0000 R CNN
F 2 "Relay_THT:Relay_StandexMeder_DIP_LowProfile" H 10250 5450 50  0001 L CNN
F 3 "https://standexelectronics.com/wp-content/uploads/datasheet_reed_relay_DIP.pdf" H 9900 5500 50  0001 C CNN
	1    9900 5500
	-1   0    0    -1  
$EndComp
$Comp
L Relay:DIPxx-1Axx-11x K?
U 1 1 5FF1C0CB
P 13650 5500
F 0 "K?" H 13980 5546 50  0001 L CNN
F 1 "Rt Ventilateur" H 13220 5500 50  0000 R CNN
F 2 "Relay_THT:Relay_StandexMeder_DIP_LowProfile" H 14000 5450 50  0001 L CNN
F 3 "https://standexelectronics.com/wp-content/uploads/datasheet_reed_relay_DIP.pdf" H 13650 5500 50  0001 C CNN
	1    13650 5500
	-1   0    0    -1  
$EndComp
$Comp
L Relay:DIPxx-1Axx-11x K?
U 1 1 5FF1C0D7
P 12400 5500
F 0 "K?" H 12730 5546 50  0001 L CNN
F 1 "Rt Z casque" H 11970 5500 50  0000 R CNN
F 2 "Relay_THT:Relay_StandexMeder_DIP_LowProfile" H 12750 5450 50  0001 L CNN
F 3 "https://standexelectronics.com/wp-content/uploads/datasheet_reed_relay_DIP.pdf" H 12400 5500 50  0001 C CNN
	1    12400 5500
	-1   0    0    -1  
$EndComp
$Comp
L Analog_Switch:ADG417BR U?
U 1 1 5FF46E6D
P 3800 8250
F 0 "U?" V 3846 8380 50  0001 L CNN
F 1 "Btn CASQUE" V 3755 8380 50  0000 R CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 3800 8150 50  0001 C CNN
F 3 "https://www.analog.com/media/en/technical-documentation/data-sheets/ADG417.pdf" H 3800 8250 50  0001 C CNN
	1    3800 8250
	0    -1   -1   0   
$EndComp
$Comp
L Analog_Switch:ADG417BR U?
U 1 1 5FF4B232
P 4400 8250
F 0 "U?" V 4446 8380 50  0001 L CNN
F 1 "Btn ON OFF" V 4355 8380 50  0000 R BNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 4400 8150 50  0001 C CNN
F 3 "https://www.analog.com/media/en/technical-documentation/data-sheets/ADG417.pdf" H 4400 8250 50  0001 C CNN
	1    4400 8250
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5FF4F801
P 3800 9200
F 0 "#PWR?" H 3800 8950 50  0001 C CNN
F 1 "GND" H 3805 9027 50  0000 C CNN
F 2 "" H 3800 9200 50  0001 C CNN
F 3 "" H 3800 9200 50  0001 C CNN
	1    3800 9200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FF53985
P 3200 8700
F 0 "R?" H 3270 8746 50  0001 L CNN
F 1 "10K" H 3270 8700 50  0000 L CNN
F 2 "" V 3130 8700 50  0001 C CNN
F 3 "~" H 3200 8700 50  0001 C CNN
	1    3200 8700
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FF579C7
P 3800 8700
F 0 "R?" H 3870 8746 50  0001 L CNN
F 1 "10K" H 3870 8700 50  0000 L CNN
F 2 "" V 3730 8700 50  0001 C CNN
F 3 "~" H 3800 8700 50  0001 C CNN
	1    3800 8700
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5FF5B986
P 4400 8700
F 0 "R?" H 4470 8746 50  0001 L CNN
F 1 "10K" H 4470 8700 50  0000 L CNN
F 2 "" V 4330 8700 50  0001 C CNN
F 3 "~" H 4400 8700 50  0001 C CNN
	1    4400 8700
	1    0    0    -1  
$EndComp
Wire Wire Line
	3800 9200 3800 9000
Wire Wire Line
	3200 8850 3200 9000
Wire Wire Line
	3200 9000 3800 9000
Connection ~ 3800 9000
Wire Wire Line
	3800 9000 3800 8850
Wire Wire Line
	3800 9000 4400 9000
Wire Wire Line
	4400 9000 4400 8850
$Comp
L power:GND #PWR?
U 1 1 5FF7B6D3
P 5150 6650
F 0 "#PWR?" H 5150 6400 50  0001 C CNN
F 1 "GND" H 5155 6477 50  0000 R BNN
F 2 "" H 5150 6650 50  0001 C CNN
F 3 "" H 5150 6650 50  0001 C CNN
	1    5150 6650
	-1   0    0    -1  
$EndComp
Wire Wire Line
	8950 6850 8950 7900
Wire Wire Line
	8950 7900 8550 7900
Wire Wire Line
	8550 8050 8550 8000
Connection ~ 8550 7900
Wire Wire Line
	8550 8000 8550 7900
Wire Wire Line
	8250 6550 8550 6550
Connection ~ 8550 7850
Wire Wire Line
	8550 6550 8550 7850
Wire Wire Line
	8550 7850 8550 7900
$Comp
L Display_Character:WC1602A DS?
U 1 1 5FC864F2
P 8550 7050
F 0 "DS?" H 8550 8031 50  0001 C CNN
F 1 "Lcd 2*16" H 8550 7939 50  0000 C CNN
F 2 "Display:WC1602A" H 8550 6150 50  0001 C CIN
F 3 "http://www.wincomlcd.com/pdf/WC1602A-SFYLYHTC06.pdf" H 9250 7050 50  0001 C CNN
	1    8550 7050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5900 6650 5150 6650
Wire Wire Line
	6900 6950 8150 6950
Wire Wire Line
	6900 7050 8150 7050
Wire Wire Line
	6900 7150 8150 7150
Wire Wire Line
	6900 7250 8150 7250
Wire Wire Line
	8550 6250 5800 6250
Wire Wire Line
	5800 6250 5800 6850
Wire Wire Line
	5800 6850 5900 6850
Wire Wire Line
	6900 7350 7400 7350
Wire Wire Line
	7400 7350 7400 6650
Wire Wire Line
	7400 6650 8150 6650
Wire Wire Line
	8150 6450 7500 6450
Wire Wire Line
	7500 6450 7500 7450
Wire Wire Line
	7500 7450 6900 7450
Connection ~ 8550 8000
Wire Wire Line
	8550 6250 9500 6250
Wire Wire Line
	9500 6250 9500 6450
Connection ~ 8550 6250
Wire Wire Line
	8950 6750 9500 6750
Wire Wire Line
	9500 6750 9500 6450
Connection ~ 9500 6450
Wire Wire Line
	10100 5800 10100 8350
$Comp
L Relay:DIPxx-1Axx-11x K?
U 1 1 5FC3DD97
P 11150 5500
F 0 "K?" H 11480 5546 50  0001 L CNN
F 1 "Rt  HT" H 10720 5500 50  0000 R CNN
F 2 "Relay_THT:Relay_StandexMeder_DIP_LowProfile" H 11500 5450 50  0001 L CNN
F 3 "https://standexelectronics.com/wp-content/uploads/datasheet_reed_relay_DIP.pdf" H 11150 5500 50  0001 C CNN
	1    11150 5500
	-1   0    0    -1  
$EndComp
Wire Wire Line
	11350 5800 11350 8500
Wire Wire Line
	7400 8500 7400 7750
Wire Wire Line
	7250 8650 7250 7850
Wire Wire Line
	7250 7850 6900 7850
Wire Wire Line
	12200 5750 12200 5800
Wire Wire Line
	12600 5800 12600 8650
Wire Wire Line
	13850 5800 13850 8750
Wire Wire Line
	7150 8750 7150 7950
Wire Wire Line
	7150 7950 6900 7950
Wire Wire Line
	6900 7750 7400 7750
Wire Wire Line
	6900 7650 7500 7650
Wire Wire Line
	7500 7650 7500 8350
Wire Wire Line
	5900 7650 4400 7650
Wire Wire Line
	4400 7650 4400 7950
Wire Wire Line
	3800 7950 3800 7550
Wire Wire Line
	3800 7550 5900 7550
Wire Wire Line
	5900 7450 3200 7450
Wire Wire Line
	3200 7450 3200 7950
Wire Wire Line
	5900 7350 2700 7350
$Comp
L power:GND #PWR?
U 1 1 5FFB072D
P 2300 7700
F 0 "#PWR?" H 2300 7450 50  0001 C CNN
F 1 "GND" H 2305 7527 50  0000 C CNN
F 2 "" H 2300 7700 50  0001 C CNN
F 3 "" H 2300 7700 50  0001 C CNN
	1    2300 7700
	1    0    0    -1  
$EndComp
Wire Wire Line
	2300 6850 2300 7050
Connection ~ 5800 6850
Wire Wire Line
	13450 3800 13450 3900
$Comp
L Motor:Fan M?
U 1 1 5FD3BE06
P 13450 4200
F 0 "M?" H 13608 4296 50  0000 L CNN
F 1 "Fan" H 13608 4205 50  0000 L CNN
F 2 "" H 13450 4210 50  0001 C CNN
F 3 "~" H 13450 4210 50  0001 C CNN
	1    13450 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	13450 4400 13450 5200
Wire Wire Line
	7500 8350 10100 8350
Wire Wire Line
	7400 8500 11350 8500
Wire Wire Line
	7250 8650 12600 8650
Wire Wire Line
	7150 8750 13850 8750
Text GLabel 9700 5950 0    50   Input ~ 0
220V
Wire Wire Line
	9700 5750 9700 5800
Text GLabel 10950 5950 0    50   Input ~ 0
220V
Wire Wire Line
	10950 5750 10950 5800
Connection ~ 9700 5800
Wire Wire Line
	9700 5800 9700 5950
$Comp
L power:GND #PWR?
U 1 1 6001CDCC
P 13850 5200
F 0 "#PWR?" H 13850 4950 50  0001 C CNN
F 1 "GND" H 13855 5027 50  0000 C CNN
F 2 "" H 13850 5200 50  0001 C CNN
F 3 "" H 13850 5200 50  0001 C CNN
	1    13850 5200
	-1   0    0    1   
$EndComp
Wire Wire Line
	13850 5150 13850 5200
Connection ~ 13850 5200
$Comp
L power:GND #PWR?
U 1 1 60024DBD
P 12600 5200
F 0 "#PWR?" H 12600 4950 50  0001 C CNN
F 1 "GND" H 12605 5027 50  0000 C CNN
F 2 "" H 12600 5200 50  0001 C CNN
F 3 "" H 12600 5200 50  0001 C CNN
	1    12600 5200
	-1   0    0    1   
$EndComp
Wire Wire Line
	12600 5150 12600 5200
$Comp
L power:GND #PWR?
U 1 1 6002845F
P 11350 5200
F 0 "#PWR?" H 11350 4950 50  0001 C CNN
F 1 "GND" H 11355 5027 50  0000 C CNN
F 2 "" H 11350 5200 50  0001 C CNN
F 3 "" H 11350 5200 50  0001 C CNN
	1    11350 5200
	-1   0    0    1   
$EndComp
Wire Wire Line
	11350 5150 11350 5200
$Comp
L power:GND #PWR?
U 1 1 6002FBDD
P 10100 5200
F 0 "#PWR?" H 10100 4950 50  0001 C CNN
F 1 "GND" H 10105 5027 50  0000 C CNN
F 2 "" H 10100 5200 50  0001 C CNN
F 3 "" H 10100 5200 50  0001 C CNN
	1    10100 5200
	-1   0    0    1   
$EndComp
Wire Wire Line
	10100 5150 10100 5200
Text GLabel 12200 4300 0    50   Input ~ 0
Z_Casque
Wire Wire Line
	12200 4300 12200 5200
Connection ~ 12200 5200
Wire Wire Line
	12200 5200 12200 5300
Text GLabel 10900 4300 0    50   Input ~ 0
Carte_Ez80
Wire Wire Line
	10950 5200 10950 4300
Wire Wire Line
	10950 4300 10900 4300
Text GLabel 8200 3400 0    50   Input ~ 0
220V
Wire Wire Line
	8300 3400 8200 3400
$Comp
L alim_6.3v2a:Alim_6.3V2A U?
U 1 1 60082AB1
P 2500 5300
F 0 "U?" H 2830 5239 50  0001 L CNN
F 1 "Alim_6.3V2A" V 2830 5148 50  0000 L TNN
F 2 "" H 2500 5300 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/cd4543b.pdf" H 2500 5300 50  0001 C CNN
	1    2500 5300
	0    -1   1    0   
$EndComp
Wire Wire Line
	3100 5400 3650 5400
Text GLabel 3200 5200 2    50   Input ~ 0
220V
Text GLabel 4400 5100 2    50   Input ~ 0
220V
Wire Wire Line
	3100 5200 3200 5200
Wire Wire Line
	8300 3300 8200 3300
Wire Wire Line
	8300 3300 8300 2950
Wire Wire Line
	8300 2950 9700 2950
Wire Wire Line
	9700 2950 9700 5200
Wire Wire Line
	9700 5200 9700 5300
Connection ~ 9700 5200
$Comp
L power:GND #PWR?
U 1 1 600AFCB7
P 8000 4000
F 0 "#PWR?" H 8000 3750 50  0001 C CNN
F 1 "GND" H 8005 3827 50  0000 R BNN
F 2 "" H 8000 4000 50  0001 C CNN
F 3 "" H 8000 4000 50  0001 C CNN
	1    8000 4000
	-1   0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 600B8617
P 7150 5800
F 0 "R?" H 7220 5846 50  0001 L CNN
F 1 "10K" H 7220 5800 50  0000 L CNN
F 2 "" V 7080 5800 50  0001 C CNN
F 3 "~" H 7150 5800 50  0001 C CNN
	1    7150 5800
	-1   0    0    -1  
$EndComp
Wire Wire Line
	6600 3700 6600 5100
Connection ~ 6600 3700
Wire Wire Line
	7150 5950 7150 6850
Wire Wire Line
	7150 6850 6900 6850
Wire Wire Line
	7150 5650 7150 5500
Wire Wire Line
	7150 5500 6600 5500
Wire Wire Line
	6600 5500 6600 5400
Wire Wire Line
	6600 5500 4600 5500
Wire Wire Line
	4600 5500 4600 7150
Wire Wire Line
	4600 7150 5900 7150
Connection ~ 6600 5500
Wire Wire Line
	5150 6650 3650 6650
Wire Wire Line
	3650 6650 3650 5400
Connection ~ 5150 6650
Text Notes 6750 5300 0    59   ~ 12
Ctrl tension 6.3V\n
Wire Wire Line
	2300 6850 5800 6850
Wire Wire Line
	5900 6550 3850 6550
Wire Wire Line
	3850 6550 3850 5500
Wire Wire Line
	3850 5500 3100 5500
$Comp
L Analog_Switch:DG308AxY U?
U 1 1 6011F135
P 4100 5100
F 0 "U?" H 4100 5367 50  0001 C CNN
F 1 "On Off" H 4100 5275 50  0000 C CNN
F 2 "Package_SO:SOIC-16_3.9x9.9mm_P1.27mm" H 4100 5000 50  0001 C CNN
F 3 "http://pdf.datasheetcatalog.com/datasheets/70/494502_DS.pdf" H 4100 5100 50  0001 C CNN
	1    4100 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	3100 5100 3800 5100
$Comp
L power:GND #PWR?
U 1 1 60142567
P 4100 5550
F 0 "#PWR?" H 4100 5300 50  0001 C CNN
F 1 "GND" H 4105 5377 50  0000 R BNN
F 2 "" H 4100 5550 50  0001 C CNN
F 3 "" H 4100 5550 50  0001 C CNN
	1    4100 5550
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3950 5300 3950 5450
Wire Wire Line
	3950 5450 4100 5450
Wire Wire Line
	4100 5450 4100 5550
Wire Wire Line
	3100 5300 3950 5300
Connection ~ 10100 5200
Connection ~ 10950 5800
Wire Wire Line
	10950 5800 10950 5950
Connection ~ 11350 5200
Connection ~ 12600 5200
$EndSCHEMATC
