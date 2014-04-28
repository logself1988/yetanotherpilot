#Generated by VisualGDB project wizard. 
#Note: VisualGDB will automatically update this file when you add new sources to the project.
#All other changes you make in this file will be preserved.
#Visit http://visualgdb.com/makefiles for more details

#VisualGDB: AutoSourceFiles		#<--- remove this line to disable auto-updating of SOURCEFILES and EXTERNAL_LIBS

TARGETNAME := pilot.elf
#TARGETTYPE can be APP, STATIC or SHARED
TARGETTYPE := APP

to_lowercase = $(subst A,a,$(subst B,b,$(subst C,c,$(subst D,d,$(subst E,e,$(subst F,f,$(subst G,g,$(subst H,h,$(subst I,i,$(subst J,j,$(subst K,k,$(subst L,l,$(subst M,m,$(subst N,n,$(subst O,o,$(subst P,p,$(subst Q,q,$(subst R,r,$(subst S,s,$(subst T,t,$(subst U,u,$(subst V,v,$(subst W,w,$(subst X,x,$(subst Y,y,$(subst Z,z,$1))))))))))))))))))))))))))

CONFIG ?= DEBUG

CONFIGURATION_FLAGS_FILE := $(call to_lowercase,$(CONFIG)).mak

include $(CONFIGURATION_FLAGS_FILE)
include $(ADDITIONAL_MAKE_FILES)

ifeq ($(BINARYDIR),)
error:
	$(error Invalid configuration, please check your inputs)
endif

SOURCEFILES := pilot.cpp stm32f10x_it.c $(BSP_ROOT)/STM32F1xxxx/CMSIS/CM3/CoreSupport/core_cm3.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/misc.c $(BSP_ROOT)/STM32F1xxxx/Startup/startup_stm32f10x_xl.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_adc.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_bkp.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_can.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_cec.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_crc.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_dac.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_dbgmcu.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_dma.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_exti.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_flash.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_fsmc.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_gpio.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_i2c.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_iwdg.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_pwr.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_rcc.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_rtc.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_sdio.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_spi.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_tim.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_usart.c $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_wwdg.c $(BSP_ROOT)/STM32F1xxxx/CMSIS/CM3/DeviceSupport/ST/STM32F10x/system_stm32f10x.c common/adc.c common/ads1115.c common/config.c common/eeprom.c common/gps.c common/I2C.c common/i2c_sw.c common/MMC_SD.c common/NRF24L01.c common/PPM.c common/printf.c common/timer.c common/vector.c fat/diskio.c fat/ff.c fat/sdcard.c sensors/BMP085.c sensors/HMC5883.c sensors/mag_offset.cpp sensors/MPU6050.c sensors/MS5611.c osd/MAX7456.c nmea/context.c nmea/generate.c nmea/generator.c nmea/gmath.c nmea/info.c nmea/parse.c nmea/parser.c nmea/sentence.c nmea/time.c nmea/tok.c
EXTERNAL_LIBS := 
EXTERNAL_LIBS_COPIED := $(foreach lib, $(EXTERNAL_LIBS),$(BINARYDIR)/$(notdir $(lib)))

CFLAGS += $(COMMONFLAGS)
CXXFLAGS += $(COMMONFLAGS)
ASFLAGS += $(COMMONFLAGS)
LDFLAGS += $(COMMONFLAGS)

CFLAGS += $(addprefix -I,$(INCLUDE_DIRS))
CXXFLAGS += $(addprefix -I,$(INCLUDE_DIRS))

CFLAGS += $(addprefix -D,$(PREPROCESSOR_MACROS))
CXXFLAGS += $(addprefix -D,$(PREPROCESSOR_MACROS))
ASFLAGS += $(addprefix -D,$(PREPROCESSOR_MACROS))

CXXFLAGS += $(addprefix -framework ,$(MACOS_FRAMEWORKS))
CFLAGS += $(addprefix -framework ,$(MACOS_FRAMEWORKS))
LDFLAGS += $(addprefix -framework ,$(MACOS_FRAMEWORKS))

LDFLAGS += $(addprefix -L,$(LIBRARY_DIRS))

LIBRARY_LDFLAGS = $(addprefix -l,$(LIBRARY_NAMES))

ifeq ($(IS_LINUX_PROJECT),1)
	RPATH_PREFIX := -Wl,--rpath='$$ORIGIN/../
	LIBRARY_LDFLAGS += $(EXTERNAL_LIBS)
	LIBRARY_LDFLAGS += -Wl,--rpath='$$ORIGIN'
	LIBRARY_LDFLAGS += $(addsuffix ',$(addprefix $(RPATH_PREFIX),$(dir $(EXTERNAL_LIBS))))
	
	ifeq ($(TARGETTYPE),SHARED)
		LIBRARY_LDFLAGS += -Wl,-soname,$(TARGETNAME)
	endif
	
else
	LIBRARY_LDFLAGS += $(EXTERNAL_LIBS)
endif

LIBRARY_LDFLAGS += $(ADDITIONAL_LINKER_INPUTS)

all_make_files := Makefile $(CONFIGURATION_FLAGS_FILE) $(ADDITIONAL_MAKE_FILES)

ifeq ($(STARTUPFILES),)
	all_source_files := $(SOURCEFILES)
else
	all_source_files := $(STARTUPFILES) $(filter-out $(STARTUPFILES),$(SOURCEFILES))
endif

source_obj1 := $(all_source_files:.cpp=.o)
source_obj2 := $(source_obj1:.c=.o)
source_obj3 := $(source_obj2:.s=.o)
source_objs := $(source_obj3:.S=.o)

all_objs := $(addprefix $(BINARYDIR)/, $(notdir $(source_objs)))

ifeq ($(GENERATE_BIN_FILE),1)
all: $(BINARYDIR)/$(basename $(TARGETNAME)).bin

$(BINARYDIR)/$(basename $(TARGETNAME)).bin: $(BINARYDIR)/$(TARGETNAME)
	$(OBJCOPY) -O binary $< $@

else
all: $(BINARYDIR)/$(TARGETNAME)
endif

ifeq ($(TARGETTYPE),APP)
$(BINARYDIR)/$(TARGETNAME): $(all_objs) $(EXTERNAL_LIBS)
	$(LD) -o $@ $(LDFLAGS) $(START_GROUP) $(all_objs) $(LIBRARY_LDFLAGS) $(END_GROUP)
endif

ifeq ($(TARGETTYPE),SHARED)
$(BINARYDIR)/$(TARGETNAME): $(all_objs) $(EXTERNAL_LIBS)
	$(LD) -shared -o $@ $(LDFLAGS) $(START_GROUP) $(all_objs) $(LIBRARY_LDFLAGS) $(END_GROUP)
endif
	
ifeq ($(TARGETTYPE),STATIC)
$(BINARYDIR)/$(TARGETNAME): $(all_objs)
	$(AR) -r $@ $^
endif

-include $(all_objs:.o=.dep)

clean:
ifeq ($(USE_DEL_TO_CLEAN),1)
	del /S /Q $(BINARYDIR)
else
	rm -rf $(BINARYDIR)
endif

$(BINARYDIR):
	mkdir $(BINARYDIR)

#VisualGDB: FileSpecificTemplates		#<--- VisualGDB will use the following lines to define rules for source files in subdirectories
$(BINARYDIR)/%.o : %.cpp $(all_make_files) |$(BINARYDIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)

$(BINARYDIR)/%.o : %.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)

$(BINARYDIR)/%.o : %.S $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) $(ASFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)

$(BINARYDIR)/%.o : %.s $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) $(ASFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)

#VisualGDB: GeneratedRules				#<--- All lines below are auto-generated


$(BINARYDIR)/core_cm3.o : $(BSP_ROOT)/STM32F1xxxx/CMSIS/CM3/CoreSupport/core_cm3.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/misc.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/misc.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/startup_stm32f10x_xl.o : $(BSP_ROOT)/STM32F1xxxx/Startup/startup_stm32f10x_xl.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_adc.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_adc.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_bkp.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_bkp.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_can.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_can.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_cec.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_cec.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_crc.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_crc.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_dac.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_dac.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_dbgmcu.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_dbgmcu.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_dma.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_dma.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_exti.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_exti.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_flash.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_flash.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_fsmc.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_fsmc.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_gpio.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_gpio.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_i2c.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_i2c.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_iwdg.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_iwdg.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_pwr.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_pwr.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_rcc.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_rcc.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_rtc.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_rtc.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_sdio.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_sdio.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_spi.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_spi.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_tim.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_tim.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_usart.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_usart.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/stm32f10x_wwdg.o : $(BSP_ROOT)/STM32F1xxxx/STM32F10x_StdPeriph_Driver/src/stm32f10x_wwdg.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/system_stm32f10x.o : $(BSP_ROOT)/STM32F1xxxx/CMSIS/CM3/DeviceSupport/ST/STM32F10x/system_stm32f10x.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/adc.o : common/adc.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/ads1115.o : common/ads1115.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/config.o : common/config.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/eeprom.o : common/eeprom.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/gps.o : common/gps.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/I2C.o : common/I2C.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/i2c_sw.o : common/i2c_sw.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/MMC_SD.o : common/MMC_SD.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/NRF24L01.o : common/NRF24L01.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/PPM.o : common/PPM.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/printf.o : common/printf.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/timer.o : common/timer.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/vector.o : common/vector.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/diskio.o : fat/diskio.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/ff.o : fat/ff.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/sdcard.o : fat/sdcard.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/BMP085.o : sensors/BMP085.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/HMC5883.o : sensors/HMC5883.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/mag_offset.o : sensors/mag_offset.cpp $(all_make_files) |$(BINARYDIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/MPU6050.o : sensors/MPU6050.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/MS5611.o : sensors/MS5611.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/MAX7456.o : osd/MAX7456.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/context.o : nmea/context.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/generate.o : nmea/generate.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/generator.o : nmea/generator.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/gmath.o : nmea/gmath.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/info.o : nmea/info.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/parse.o : nmea/parse.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/parser.o : nmea/parser.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/sentence.o : nmea/sentence.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/time.o : nmea/time.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)


$(BINARYDIR)/tok.o : nmea/tok.c $(all_make_files) |$(BINARYDIR)
	$(CC) $(CFLAGS) -c $< -o $@ -MD -MF $(@:.o=.dep)
