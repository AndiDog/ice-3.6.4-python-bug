CXX=c++
CXXFLAGS=-std=c++11 -I/usr/local/include -I. -fPIC -pthread
LDFLAGS=-shared -L/usr/local/lib -lIce -lIceBox -lIceUtil


all:
	@echo "Building..."
	@slice2cpp Demo.ice
	@$(CXX) $(CXXFLAGS) $(LDFLAGS) Demo.cpp DemoServiceI.cpp -o libDemoService.so

run: kill all
	@echo "Running now..."
	@env LD_LIBRARY_PATH=".:$LD_LIBRARY_PATH" icebox --Ice.Config=config.icebox

runclient:
	@./client.py

kill:
	@echo "Kill all iceboxes"
	@-killall icebox

clean: kill
	@echo "Remove all generated files"
	@rm -f Demo.h Demo.cpp libDemoService.so *.core
