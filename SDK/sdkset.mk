include project.mk
include userset.mk
include $(SDK_PATH)/paths.mk

#==========================================================================================
# FLAGS
#==========================================================================================

# базовые 
CC_SYMBOLS = -DTOOLCHAIN_GCC_ARM -DTOOLCHAIN_GCC -DNDEBUG -DTARGET_UNO_91H -D__CORTEX_M4F -D__MPU_PRESENT -D__FPU_PRESENT
CC_SYMBOLS += -DRDA_PARTITION_INDEX=0 
#CC_SYMBOLS += -DRDA_ICACHE_DISABLE

# возможности SoC
CC_SYMBOLS += -DDEVICE_PORTIN -DDEVICE_PORTOUT -DDEVICE_PORTINOUT -DDEVICE_INTERRUPTIN -DDEVICE_SERIAL -DDEVICE_STDIO_MESSAGES
CC_SYMBOLS += -DDEVICE_PWMOUT -DDEVICE_SPI -DDEVICE_LOWPOWERTIMER -DDEVICE_I2C -DDEVICE_ANALOGIN -DDEVICE_FLASH -DDEVICE_SLEEP -DDEVICE_RTC

# настройка UART
CC_SYMBOLS += -DMBED_CONF_CORE_STDIO_BAUD_RATE=921600 
#CC_SYMBOLS += -DMBED_CONF_CORE_STDIO_CONVERT_NEWLINES

#==========================================================================================
# Librarys
#==========================================================================================

LIBS = stdc++ supc++ m gcc c nosys hal
LIB_DIRS = $(SDK_PATH)/hal/targets/hal/TARGET_RDA/TARGET_UNO_91H/TOOLCHAIN_GCC_ARM

#==========================================================================================
# LD
#==========================================================================================

LD_FILE = $(SDK_PATH)/hal/targets/cmsis/$(TARGET_VENDOR)/$(TARGET_FAMILY)/TOOLCHAIN_GCC_ARM/TARGET_UNO_81A/RDA5981A.ld

#==========================================================================================
# Include folder list
#==========================================================================================

INC_DIRS += $(SDK_PATH)/hal/hal
INC_DIRS += $(SDK_PATH)/hal/api
INC_DIRS += $(SDK_PATH)/hal/common
INC_DIRS += $(SDK_PATH)/hal/hal/storage_abstraction
INC_DIRS += $(SDK_PATH)/hal/targets/hal/TARGET_RDA/TARGET_UNO_91H
INC_DIRS += $(SDK_PATH)/hal/targets/cmsis/$(TARGET_VENDOR)/$(TARGET_FAMILY)
INC_DIRS += $(SDK_PATH)/hal/targets/hal/$(TARGET_VENDOR)/$(TARGET_FAMILY)/TOOLCHAIN_GCC_ARM
INC_DIRS += $(SDK_PATH)/hal/targets/cmsis/$(TARGET_VENDOR)/$(TARGET_FAMILY)/TOOLCHAIN_GCC_ARM
INC_DIRS += $(SDK_PATH)/hal/targets/cmsis

INC_DIRS += $(SDK_PATH)/rtos/rtos
INC_DIRS += $(SDK_PATH)/rtos/rtx/TARGET_CORTEX_M
INC_DIRS += $(SDK_PATH)/rtos/rtx/TARGET_CORTEX_M/TARGET_RTOS_M4_M7/TOOLCHAIN_GCC

#==========================================================================================
# Sources folders list
#==========================================================================================

SRC_DIRS += $(SDK_PATH)/hal/common
SRC_DIRS += $(SDK_PATH)/hal/targets/hal/$(TARGET_VENDOR)/$(TARGET_FAMILY)

SRC_DIRS += $(SDK_PATH)/hal/targets/cmsis/$(TARGET_VENDOR)/$(TARGET_FAMILY)
SRC_DIRS += $(SDK_PATH)/hal/targets/cmsis/$(TARGET_VENDOR)/$(TARGET_FAMILY)/TOOLCHAIN_GCC_ARM
SRC_DIRS += $(SDK_PATH)/hal/targets/cmsis/$(TARGET_VENDOR)/$(TARGET_FAMILY)/TOOLCHAIN_GCC_ARM/TARGET_UNO_81A

SRC_DIRS += $(SDK_PATH)/rtos/rtos
SRC_DIRS += $(SDK_PATH)/rtos/rtx/TARGET_CORTEX_M
SRC_DIRS += $(SDK_PATH)/rtos/rtx/TARGET_CORTEX_M/TARGET_RTOS_M4_M7/TOOLCHAIN_GCC

#==========================================================================================
# Auto include all sources
#==========================================================================================

C_SRCS += $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.c))
CPP_SRCS += $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.cpp))
S_SRCS += $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.S))

INC_DIRS_F = -I. $(patsubst %, -I%, $(INC_DIRS))
