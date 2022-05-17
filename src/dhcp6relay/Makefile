RM := rm -rf
DHCP6RELAY_TARGET := dhcp6relay
DHCP6RELAY_TEST_TARGET := dhcp6relay-test
CP := cp
MKDIR := mkdir
CC := g++
MV := mv
FIND := find
LIBS := -levent -lhiredis -lswsscommon -pthread -lboost_thread -lboost_system
LIBS_TEST := -lgtest_main -lgtest -pthread -lstdc++fs
CFLAGS  = -g -Wall -std=c++17 -fPIC -I $(PWD)/../sonic-swss-common/common
GCOV_FLAGS := -fprofile-use -fprofile-arcs -ftest-coverage -fprofile-generate
PWD := $(shell pwd)
GCOVR := gcovr
MAKE := make
MAKE_PID := $(shell echo $$PPID)
JOB_FLAG := $(filter -j%, $(subst -j ,-j,$(shell ps T | grep "^\s*$(MAKE_PID).*$(MAKE)")))
JOBS := $(subst -j,,$(JOB_FLAG))

test-targets: CPP_FLAGS = -O0 -Wall -fmessage-length=0 -fPIC $(GCOV_FLAGS)

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS) $(OBJS)
endif
endif

-include src/subdir.mk
-include test/subdir.mk
	
all:  test-targets

sonic-dhcp6relay: $(OBJS) $(OBJS_DHCP6RELAY)
	@echo 'Building target: $@'
	@echo 'Invoking: G++ Linker'
	$(CC) -fprofile-arcs -ftest-coverage $(LDFLAGS) -o $(DHCP6RELAY_TARGET) $(OBJS) $(LIBS) $(OBJS_DHCP6RELAY)
	@echo 'Finished building target: $@'
	@echo ' '

# test Target
test-targets: $(OBJS_DHCP6RELAY_TEST)
	@echo 'Building target: $@'
	@echo 'Invoking: C++ Linker'
	$(CC) -lgcov --coverage -o "$(DHCP6RELAY_TEST_TARGET)" $(CPP_FLAGS) $(OBJS_DHCP6RELAY_TEST) $(LIBS) $(LIBS_TEST)
	@echo 'Executing test target: $@'
	./$(DHCP6RELAY_TEST_TARGET)
	$(GCOVR) -r ./ --html --html-details -o $(DHCP6RELAY_TEST_TARGET)-result.html
	$(GCOVR) -r ./ --xml-pretty -o $(DHCP6RELAY_TEST_TARGET)-result.xml
	@echo 'Finished building target: $@'
	@echo ' '

test: clean-targets
	$(MAKE) -j $(JOBS) test-targets

install:
	$(MKDIR) -p $(DESTDIR)/usr/sbin
	$(MV) $(DHCP6RELAY_TARGET) $(DESTDIR)/usr/sbin

deinstall:
	$(RM) $(DESTDIR)/usr/sbin/$(DHCP6RELAY_TARGET)
	$(RM) -rf $(DESTDIR)/usr/sbin

clean:
	-$(RM) $(EXECUTABLES) $(C_DEPS) $(OBJS) $(OBJS_DHCP6RELAY) $(DHCP6RELAY_TARGET) $(DHCP6RELAY_TEST_TARGET) $(OBJS_DHCP6RELAY_TEST) *.html *.xml
	$(FIND) . -name *.gcda -exec rm -f {} \;
	$(FIND) . -name *.gcno -exec rm -f {} \;
	$(FIND) . -name *.gcov -exec rm -f {} \;
	-@echo ' '

.PHONY: all clean dependents
