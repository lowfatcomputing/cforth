create mfpr-table
   0 sleepi +pull-dn af,   \ GPIO_00 - Memsize0 (TP201 on B) (start with them pulled down for A and B revs)
   0 sleepi +pull-dn af,   \ GPIO_01 - Memsize1 (TP199 on B)
   no-update,        \ GPIO_02 - Not connected (TP54)
   no-update,        \ GPIO_03 - Not connected (TP53)
   0 sleep1 af,      \ GPIO_04 - COMPASS_SCL (bitbang) (CL2), CAM_SCL (CL3)
   0 sleep1 af,      \ GPIO_05 - COMPASS_SDA (bitbang) (CL2), CAM_SDA (CL3)
   0 sleepi af,      \ GPIO_06 - G_SENSOR_INT
   0 sleepi af,      \ GPIO_07 - AUDIO_IRQ#
   0 sleep0 af,      \ GPIO_08 - AUDIO_RESET#
   0 sleepi af,      \ GPIO_09 - COMPASS_INT
   0 sleep0 af,      \ GPIO_10 - LED_STORAGE
   0 sleep0 af,      \ GPIO_11 - VID2
   no-update, \ GPIO_12 - Not connected (TP52)
   no-update, \ GPIO_13 - Not connected (TP116)
   no-update, \ GPIO_14 - Not connected (TP64)
   no-update, \ GPIO_15 - Not connected (TP55)
   0 sleepi af,      \ GPIO_16 - KEY_IN_1
   0 sleepi af,      \ GPIO_17 - KEY_IN_2
   0 sleepi af,      \ GPIO_18 - KEY_IN_3
   0 sleepi af,      \ GPIO_19 - KEY_IN_4
   0 sleepi af,      \ GPIO_20 - KEY_IN_5
   no-update, \ GPIO_21 - Not connected (TP63)
   no-update, \ GPIO_22 - Not connected (TP118)
   no-update, \ GPIO_23 - Not connected (TP61)
   1 sleep1 af,      \ GPIO_24 - I2S_SYSCLK   (Codec) \ wastes 40 mW if S0
   1 sleep1 af,      \ GPIO_25 - I2S_BITCLK   (Codec) \ wastes 2 mW if S0
   1 sleep0 af,      \ GPIO_26 - I2S_SYNC     (Codec)
   1 sleep1 af,      \ GPIO_27 - I2S_DATA_OUT (Codec) \ wastes 3 mW if S0
   1 sleepi af,      \ GPIO_28 - I2S_DATA_IN  (Codec) \ wastes 13 mW if S1
   1 sleep- af,      \ GPIO_29 - UART1_RXD  (debug board)
   1 sleep- af,      \ GPIO_30 - UART1_TXD  (debug board)
   0 sleepi af,      \ GPIO_31 - SD_CD# AKA SD2_CD# (via GPIO)
   no-update,        \ GPIO_32 - Not connected (TP58)
   0 sleep0 af,      \ GPIO_33 - LCDVCC_EN (CL3)
   0 sleep0 af,      \ GPIO_34 - EN_WLAN_PWR
   0 sleep0 af,      \ GPIO_35 - Not connected (TP129)
   no-update,        \ GPIO_36 - Not connected (TP115)
   1 sleepi af,      \ GPIO_37 - SDDA_D3
   1 sleepi af,      \ GPIO_38 - SDDA_D2
   1 sleepi af,      \ GPIO_39 - SDDA_D1
   1 sleepi af,      \ GPIO_40 - SDDA_D0
   1 sleep0 af,      \ GPIO_41 - SDDA_CMD
   1 sleep0 af,      \ GPIO_42 - SDDA_CLK
   3 sleepi +pull-up-alt         af,   \ GPIO_43 - SPI_MISO  (SSP1) (OFW Boot FLASH)
   3 sleep0 +pull-up-alt +medium af,   \ GPIO_44 - SPI_MOSI
   3 sleep1 +pull-up-alt +medium af,   \ GPIO_45 - SPI_CLK
   3 sleep1 +pull-up-alt +medium af,   \ GPIO_46 - SPI_FRM
   3 sleep1 +pull-up af, \ GPIO_47 - G_SENSOR_SDL (TWSI6)
   3 sleep1 +pull-up af, \ GPIO_48 - G_SENSOR_SDA
   no-update, \ GPIO_49 - Not connected (TP62)
   no-update, \ GPIO_50 - Not connected (TP114)
   no-update, \ GPIO_51 - Not connected (TP59)
   no-update, \ GPIO_52 - Not connected (TP113)
   no-update, \ GPIO_53 - Not connected if nopop R124 to use TWSI6 for RTC
   no-update, \ GPIO_54 - Not connected if nopop R125 to use TWSI6 for RTC
   no-update, \ GPIO_55 - Not connected (TP51)
   no-update, \ GPIO_56 - Not connected (TP60)
   0 sleep0 af,      \ GPIO_57 - WLAN_PD#
   0 sleep0 af,      \ GPIO_58 - WLAN_RESET#

   1 sleep0 af,      \ GPIO_59 - PIXDATA7 \ Each wastes ~15 mW if S1
   1 sleep0 af,      \ GPIO_60 - PIXDATA6
   1 sleep0 af,      \ GPIO_61 - PIXDATA5
   1 sleep0 af,      \ GPIO_62 - PIXDATA4
   1 sleep0 af,      \ GPIO_63 - PIXDATA3
   1 sleep0 af,      \ GPIO_64 - PIXDATA2
   1 sleep0 af,      \ GPIO_65 - PIXDATA1
   1 sleep0 af,      \ GPIO_66 - PIXDATA0
   1 sleepi af,      \ GPIO_67 - CAM_HSYNC  \ Wastes 40 mW if S1
   1 sleepi af,      \ GPIO_68 - CAM_VSYNC  \ Wastes 40 mW if S1
   1 sleep0 af,      \ GPIO_69 - PIXMCLK
   1 sleep0 af,      \ GPIO_70 - PIXCLK     \ Wastes 40 mW if S1

   0 sleepi af,      \ GPIO_71 - SOC_KBD_CLK  \ Was EC_SCL (TWSI3) w6 S0
   0 sleep- af,      \ GPIO_72 - SOC_KBD_DAT  \ Was EC_SDA         w6 S0
   0 sleep0 af,      \ GPIO_73 - SEC_TRG      \ Was CAM_RST on A3

   1 sleep0 af,      \ GPIO_74 - GFVSYNC 
   1 sleep0 af,      \ GPIO_75 - GFHSYNC
   1 sleep0 af,      \ GPIO_76 - GFDOTCLK
   1 sleep0 af,      \ GPIO_77 - GF_LDE
   1 sleep0 af,      \ GPIO_78 - GFRDATA0
   1 sleep0 af,      \ GPIO_79 - GFRDATA1
   1 sleep0 af,      \ GPIO_80 - GFRDATA2
   1 sleep0 af,      \ GPIO_81 - GFRDATA3
   1 sleep0 af,      \ GPIO_82 - GFRDATA4
   1 sleep0 af,      \ GPIO_83 - GFRDATA5
   1 sleep0 af,      \ GPIO_84 - GFGDATA0
   1 sleep0 af,      \ GPIO_85 - GFGDATA1
   1 sleep0 af,      \ GPIO_86 - GFGDATA2
   1 sleep0 af,      \ GPIO_87 - GFGDATA3
   1 sleep0 af,      \ GPIO_88 - GFGDATA4
   1 sleep0 af,      \ GPIO_89 - GFGDATA5
   1 sleep0 af,      \ GPIO_90 - GFBDATA0
   1 sleep0 af,      \ GPIO_91 - GFBDATA1
   1 sleep0 af,      \ GPIO_92 - GFBDATA2
   1 sleep0 af,      \ GPIO_93 - GFBDATA3
   1 sleep0 af,      \ GPIO_94 - GFBDATA4
   1 sleep0 af,      \ GPIO_95 - GFBDATA5

   no-update, \ GPIO_96  - Not connected (TP112)
   0 sleep1 af,      \ GPIO_97  - RTC_SCK (bitbang) if R100 populated
   0 sleep1 af,      \ GPIO_98  - RTC_SDA (bitbang) if R106 populated
   0 sleepi af,      \ GPIO_99  - TOUCH_SCR_INT w80 S1
   0 sleepi af,      \ GPIO_100 - DCONSTAT0 w40 S1
   0 sleepi af,      \ GPIO_101 - DCONSTAT1 w40 S1
   no-update, \ GPIO_102 - (USIM_CLK) - Not connected (TP48)
   no-update, \ GPIO_103 - (USIM_IO) - Not connected (TP50)

   0 sleepi af,      \ GPIO_104 - ND_IO[7]
   0 sleepi af,      \ GPIO_105 - ND_IO[6]
   0 sleepi af,      \ GPIO_106 - ND_IO[5]
   1 sleep- af,      \ GPIO_107 - (ND_IO[4]) - SOC_TPD_DAT

   1 sleep1 af,      \ GPIO_108 - CAM_SDL - Use as GPIO, bitbang w5 S0 (CL2), CHG_SDA (CL3)
   1 sleep1 af,      \ GPIO_109 - CAM_SDA - Use as GPIO, bitbang w5 S0 (CL2), CHG_SCL (CL3)

   1 sleep0 af,      \ GPIO_110 - (ND_IO[13]) - Not connected (TP43)
   1 sleep0 af,      \ GPIO_111 - (ND_IO[8])  - Not connected (TP108)
   0 sleepi af,      \ GPIO_112 - ND_RDY[0]
   3 sleep1 +fast af,      \ GPIO_113 - (SM_RDY)  - MSD_CMD aka SD1_CMD (externally pulled up) (CL2), N/C (CL3)
   1 sleep- af,      \ GPIO_114 - G_CLK_OUT - Not connected (TP93)

   4 sleep- af,      \ GPIO_115 - UART3_TXD (J4)
   4 sleep- af,      \ GPIO_116 - UART3_RXD (J4)
   3 sleep- af,      \ GPIO_117 - UART4_RXD - Not connected on A1 (TP117)
   3 sleep- af,      \ GPIO_118 - UART4_TXD - Not connected on A1 (TP56)
   3 sleep0 af,      \ GPIO_119 - SDI_CLK  (SSP3) w70 S1
   3 sleep1 af,      \ GPIO_120 - SDI_CS#  w70 S0
   3 sleep0 af,      \ GPIO_121 - SDI_MOSI w80 S1
   3 sleepi af,      \ GPIO_122 - SDI_MISO

   1 sleep- af,      \ GPIO_123 - SLEEP_IND

   0 sleepi af,          \ GPIO_124 - DCONIRQ (CL2), USB_OTG_OC# (CL3)
   0 sleep1 +pull-up af, \ GPIO_125 - EC_SPI_ACK

   3 sleep0 +fast af, \ GPIO_126 - MSD_DATA2 AKA SD1_DATA2
   3 sleep0 +fast af, \ GPIO_127 - MSD_DATA0 AKA SD1_DATA0
   0 sleepi af,       \ GPIO_128 - EB_MODE#
   0 sleepi af,       \ GPIO_129 - LID_SW#
   3 sleep0 +fast af, \ GPIO_130 - MSD_DATA3 AKA SD1_DATA3
   1 sleep0 +fast af, \ GPIO_131 - SD_DATA3 AKA SD2_DATA3
   1 sleep0 +fast af, \ GPIO_132 - SD_DATA2 AKA SD2_DATA2
   1 sleep0 +fast af, \ GPIO_133 - SD_DATA1 AKA SD2_DATA1
   1 sleep0 +fast af, \ GPIO_134 - SD_DATA0 AKA SD2_DATA0
   3 sleep0 +fast af, \ GPIO_135 - MSD_DATA1 AKA SD1_DATA1
   1 sleep1 +fast af,      \ GPIO_136 - SD_CMD AKA SD2_CMD - CMD is pulled up externally
   no-update,         \ GPIO_137 - Not connected (TP111)
   3 sleep0 +fast af, \ GPIO_138 - MSD_CLK AKA SD1_CLK
   1 sleep0 +fast af, \ GPIO_139 - SD_CLK AKA SD2_CLK
   no-update,         \ GPIO_140 - Not connected if R130 is nopop
   1 sleepi af,       \ GPIO_141 - SD_WP# AKA SD2_WP#

   no-update, \ GPIO_142 - (USIM_RSTn) - Not connected (TP49)
   0 sleep1 af,      \ GPIO_143 - ND_CS0#
   1 sleep1 af,      \ GPIO_144 - (ND_CS1#) - CAM_PWRDN (not connected until C1) (not connected on CL3)
   no-update, \ GPIO_145 - Not connected
   1 sleep- af,      \ GPIO_146 - HUB_RESET# (CL2), ULPI_HUB_RESET# (CL3)

   0 sleep0 af,      \ GPIO_147 - ND_WE_N - Not connected (TP122)
   1 sleep- af,      \ GPIO_148 - ND_RE_N - SOC_EN_KBD_PWR# (CL2) (N/C on CL3)
   1 sleep0 af,       \ GPIO_149 - eMMC_RST#
   1 sleep0 af,       \ GPIO_150 - EN_CAM_PWR - Must be 0 in sleep state for camera off
   2 sleep0 +fast af, \ GPIO_151 - eMMC_CLK
   1 sleep0 af,       \ GPIO_152 - (SM_BELn) - Not connected (TP40)
   1 sleep0 af,       \ GPIO_153 - (SM_BEHn) - Not connected (TP105)
   1 sleepi af,       \ GPIO_154 - (SM_INT) - EC_IRQ#
   1 sleep0 +pull-dn af, \ GPIO_155 - (EXT_DMA_REQ0) - EC_SPI_CMD
   no-update,         \ GPIO_156 - PRI_TDI (JTAG)
   no-update,         \ GPIO_157 - PRI_TDS (JTAG)
   no-update,         \ GPIO_158 - PRI_TDK (JTAG)
   no-update,         \ GPIO_159 - PRI_TDO (JTAG)
   1 sleepi af,       \ GPIO_160 - (ND_RDY[1]) - SOC_TPD_CLK (CL2) (N/C on CL3)
   1 sleep0 af,       \ GPIO_161 - ND_IO[12] - Not connected (TP 44)
   1 sleep1 af,       \ GPIO_162 - (ND_IO[11]) - DCON_SCL
   1 sleep1 +pull-up af,    \ GPIO_163 - (ND_IO[10]) - DCON_SDA
   1 sleep0 af,       \ GPIO_164 - (ND_IO[9]) - Not connected (TP106)
   0 sleep0 af,       \ GPIO_165 - ND_IO[3]
   0 sleep0 af,       \ GPIO_166 - ND_IO[2]
   0 sleep0 af,       \ GPIO_167 - ND_IO[1]
   0 sleep0 af,       \ GPIO_168 - ND_IO[0]
here mfpr-table - /w - constant #mfprs
