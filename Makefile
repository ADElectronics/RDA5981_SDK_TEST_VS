include userset.mk

.PHONY: clean all
clean:
	@$(MAKE) -f $(SDK_PATH)/sdkbuild.mk clean
	
all:
	@$(MAKE) -f $(SDK_PATH)/sdkbuild.mk all
	
rebuild:
	@$(MAKE) -f $(SDK_PATH)/sdkbuild.mk rebuild