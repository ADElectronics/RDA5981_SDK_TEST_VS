
#==========================================================================================
# Output
#==========================================================================================

INSTRUCTION_MODE = thumb

TARGET = firmware
TARGET_EXT = elf

OUT_DIR = Debug
OBJ_DIR = $(OUT_DIR)/obj/
BIN_DIR = $(OUT_DIR)/bin/

#==========================================================================================
# TARGET
#==========================================================================================

TARGET_VENDOR = TARGET_RDA
TARGET_FAMILY = TARGET_UNO_91H
CPU = cortex-m4

#==========================================================================================
# Compilation tools
#==========================================================================================

TOOLCHAIN = arm-none-eabi-

CC = $(TOOLCHAIN)gcc
CXX = $(TOOLCHAIN)g++
AS = $(TOOLCHAIN)gcc -x assembler-with-cpp
LD = $(TOOLCHAIN)gcc
OBJCP = $(TOOLCHAIN)objcopy
AR = $(TOOLCHAIN)ar

GDB = $(TOOLCHAIN)gdb
SIZE = $(TOOLCHAIN)size
OBJCOPY = $(TOOLCHAIN)objcopy
OBJDUMP = $(TOOLCHAIN)objdump

RM = rm -rf

#==========================================================================================
# Make bunary tools
#==========================================================================================

EXE = .exe
PICK = $(TOOLS_PATH)pick$(EXE)
PADDING = $(TOOLS_PATH)padding$(EXE)
CHCKSUM = $(TOOLS_PATH)checksum$(EXE)

