include userset.mk
include $(SDK_PATH)/sdkset.mk

#==========================================================================================
# Compiler options
#==========================================================================================

COMPILER_OPTIONS  = -g2 -Os -Wall -fno-strict-aliasing -nostartfiles
COMPILER_OPTIONS += -fno-common -fno-builtin -fmessage-length=0 -ffunction-sections -fdata-sections -fomit-frame-pointer -fsigned-char
COMPILER_OPTIONS += -mcpu=$(CPU) -MMD $(CC_SYMBOLS) -m$(INSTRUCTION_MODE)
COMPILER_OPTIONS += -mfloat-abi=softfp -mfpu=fpv4-sp-d16

# если требуется Float в printf
COMPILER_OPTIONS += -u _printf_float -u _scanf_float
 
#==========================================================================================
# Flags
#==========================================================================================

DEPEND_OPTIONS = -MF $(OBJ_DIR)$(@F:.o=.d)

C_FLAGS = $(COMPILER_OPTIONS) $(DEPEND_OPTIONS) $(INC_DIRS_F) -std=gnu99 -c
CXX_FLAGS = $(COMPILER_OPTIONS) $(DEPEND_OPTIONS) $(INC_DIRS_F) -Wvla -std=gnu++98 -c
AS_FLAGS = $(COMPILER_OPTIONS) $(INC_DIRS_F) -c
LIB_FLAGS = $(addprefix -L,$(LIB_DIRS)) $(addprefix -l,$(LIBS))

#==========================================================================================
# Linker options
#==========================================================================================

LD_OPTIONS = -mcpu=$(CPU) -m$(INSTRUCTION_MODE) -T $(LD_FILE) $(INC_DIRS_F)
LD_OPTIONS += -specs=nano.specs -mfloat-abi=softfp -mfpu=fpv4-sp-d16 -g2 -Os
LD_OPTIONS += -u _printf_float -u _scanf_float
LD_OPTIONS += -Wl,-Map=$(OBJ_DIR)$(TARGET).map,--gc-sections
LD_OPTIONS += -Wl,--start-group $(CPP_OBJS) $(C_OBJS) $(S_OBJS) $(LIB_FLAGS) -Wl,--end-group
LD_OPTIONS += -Wl,--gc-sections -Wl,--wrap,main -Wl,--wrap,_malloc_r -Wl,--wrap,_free_r -Wl,--wrap,_realloc_r -Wl,--wrap,_calloc_r

#==========================================================================================
# Files list
#==========================================================================================

C_OBJS := $(patsubst %.c,$(OBJ_DIR)%.o,$(notdir $(C_SRCS)))
CPP_OBJS := $(patsubst %.cpp,$(OBJ_DIR)%.o,$(notdir $(CPP_SRCS)))
S_OBJS := $(patsubst %.S,$(OBJ_DIR)%.o,$(notdir $(S_SRCS)))
VPATH := $(SRC_DIRS)

#==========================================================================================
# Compile, Link
#==========================================================================================
	
rebuild: clean all
all: prerequirement application build_info

.PHONY: build_info
build_info:
	@echo "==========================================================="
	@echo "Build Info"
	@echo "==========================================================="
	arm-none-eabi-size --totals $(BIN_DIR)$(TARGET).$(TARGET_EXT)
	arm-none-eabi-objcopy -O srec $(BIN_DIR)$(TARGET).$(TARGET_EXT) $(BIN_DIR)$(TARGET).s19
	arm-none-eabi-objcopy -O binary -v $(BIN_DIR)$(TARGET).$(TARGET_EXT) $(BIN_DIR)$(TARGET).bin
	arm-none-eabi-objdump -D $(BIN_DIR)$(TARGET).$(TARGET_EXT) > $(BIN_DIR)$(TARGET).lst
	arm-none-eabi-nm $(BIN_DIR)$(TARGET).$(TARGET_EXT) > $(BIN_DIR)$(TARGET)-symbol-table.txt	
	
.PHONY: application 
application: $(C_OBJS) $(CPP_OBJS) $(S_OBJS)
	@echo "==========================================================="
	@echo "Link ($(TARGET))"
#	@echo "==========================================================="
	$(LD) $(LD_OPTIONS) -o $(BIN_DIR)$(TARGET).$(TARGET_EXT)

.PHONY:	prerequirement
#.NOTPARALLEL: prerequirement
prerequirement:
	@echo "==========================================================="
	@echo "Compile ($(TARGET))"
#	@echo "==========================================================="
	@mkdir -p $(OBJ_DIR) $(BIN_DIR)
	@$(file > $(OUT_DIR)/src_c_list.lst,$(C_SRCS))
	@$(file > $(OUT_DIR)/src_cpp_list.lst,$(CPP_SRCS))
	@$(file > $(OUT_DIR)/src_s_list.lst,$(S_SRCS))
	@$(file > $(OUT_DIR)/obj_c_list.lst,$(C_OBJS))
	@$(file > $(OUT_DIR)/obj_cpp_list.lst,$(CPP_OBJS))
	@$(file > $(OUT_DIR)/obj_s_list.lst,$(S_OBJS))
#$(BIN_DIR)$(TARGET).$(TARGET_EXT): $(LD_FILE) $(C_OBJS) $(CPP_OBJS) $(S_OBJS)

#==========================================================================================
# Rules
#==========================================================================================

$(OBJ_DIR)%.o : %.c
	@echo $<
	$(CC) $(C_FLAGS) $< -o $@
	
$(OBJ_DIR)%.o : %.cpp
	@echo $<
	$(CXX) $(CXX_FLAGS) $< -o $@

$(OBJ_DIR)%.o : %.s
	@echo $<
	$(AS) $(AS_FLAGS) $< -o $@

#==========================================================================================
# Other
#==========================================================================================
	
#.PHONY: clean
clean:
	$(RM) $(TARGET).$(TARGET_EXT) $(TARGET).bin $(TARGET).map $(OBJ_DIR)*.* $(OBJ_DIR) $(BIN_DIR)*.* $(BIN_DIR) $(OUT_DIR)*.*
	