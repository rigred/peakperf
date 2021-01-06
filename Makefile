CXX=gcc

SANITY_FLAGS=-Wall -Wextra -Werror -fstack-protector-all -pedantic -Wno-unused -Wfloat-equal -Wshadow -Wpointer-arith -Wformat=2
CXXFLAGS_GENERIC=-std=c99 -O2 $(SANITY_FLAGS)
CXXFLAGS_LINK=-lm -fopenmp
CXXFLAGS_SANDY_BRIDGE    = -DAVX_256_3_NOFMA -march=sandybridge    $(CXXFLAGS_GENERIC)
CXXFLAGS_IVY_BRIDGE      = -DAVX_256_3_NOFMA -march=ivybridge      $(CXXFLAGS_GENERIC)
CXXFLAGS_HASWELL         = -DAVX_256_10      -march=haswell        $(CXXFLAGS_GENERIC)
CXXFLAGS_SKYLAKE_256     = -DAVX_256_8       -march=skylake        $(CXXFLAGS_GENERIC)
CXXFLAGS_SKYLAKE_512     = -DAVX_512_8       -march=skylake-avx512 $(CXXFLAGS_GENERIC)
CXXFLAGS_BROADWELL       = -DAVX_256_8       -march=broadwell      $(CXXFLAGS_GENERIC)
CXXFLAGS_KABY_LAKE       = -DAVX_256_8       -march=skylake        $(CXXFLAGS_GENERIC)
CXXFLAGS_COFFEE_LAKE     = -DAVX_256_8       -march=skylake        $(CXXFLAGS_GENERIC)
CXXFLAGS_CANNON_LAKE_256 = -DAVX_256_10      -march=cannonlake     $(CXXFLAGS_GENERIC)
CXXFLAGS_CANNON_LAKE_512 = -DAVX_256_10      -march=cannonlake     $(CXXFLAGS_GENERIC)
CXXFLAGS_ICE_LAKE_256    = -DAVX_256_8       -march=icelake-client $(CXXFLAGS_GENERIC)
CXXFLAGS_ICE_LAKE_512    = -DAVX_256_10      -march=icelake-server $(CXXFLAGS_GENERIC)
CXXFLAGS_KNL             = -DAVX_512_12      -march=knl            $(CXXFLAGS_GENERIC)
CXXFLAGS_ZEN             = -DAVX_256_5       -march=znver1         $(CXXFLAGS_GENERIC)
CXXFLAGS_ZEN_PLUS        = -DAVX_256_5       -march=znver1         $(CXXFLAGS_GENERIC)

ARCH_DIR=Arch
CPUFETCH_DIR=cpufetch
MAIN=main.c getarg.c $(CPUFETCH_DIR)/cpu.c $(CPUFETCH_DIR)/cpuid.c $(CPUFETCH_DIR)/uarch.c $(ARCH_DIR)/Arch.c

SANDY_BRIDGE=$(ARCH_DIR)/sandy_bridge.c
SANDY_BRIDGE_HEADERS=$(ARCH_DIR)/sandy_bridge.h $(ARCH_DIR)/Arch.h

IVY_BRIDGE=$(ARCH_DIR)/ivy_bridge.c
IVY_BRIDGE_HEADERS=$(ARCH_DIR)/ivy_bridge.h $(ARCH_DIR)/Arch.h

HASWELL=$(ARCH_DIR)/haswell.c
HASWELL_HEADERS=$(ARCH_DIR)/haswell.h $(ARCH_DIR)/Arch.h

SKYLAKE_256=$(ARCH_DIR)/skylake_256.c
SKYLAKE_256_HEADERS=$(ARCH_DIR)/skylake_256.h $(ARCH_DIR)/Arch.h

SKYLAKE_512=$(ARCH_DIR)/skylake_512.c
SKYLAKE_512_HEADERS=$(ARCH_DIR)/skylake_512.h $(ARCH_DIR)/Arch.h

BROADWELL=$(ARCH_DIR)/broadwell.c
BROADWELL_HEADERS=$(ARCH_DIR)/broadwell.h $(ARCH_DIR)/Arch.h

KABY_LAKE=$(ARCH_DIR)/kaby_lake.c
KABY_LAKE_HEADERS=$(ARCH_DIR)/kaby_lake.h $(ARCH_DIR)/Arch.h

COFFEE_LAKE=$(ARCH_DIR)/coffee_lake.c
COFFEE_LAKE_HEADERS=$(ARCH_DIR)/coffee_lake.h $(ARCH_DIR)/Arch.h

CANNON_LAKE_256=$(ARCH_DIR)/cannon_lake_256.c
CANNON_LAKE_256_HEADERS=$(ARCH_DIR)/cannon_lake_256.h $(ARCH_DIR)/Arch.h

CANNON_LAKE_512=$(ARCH_DIR)/cannon_lake_512.c
CANNON_LAKE_512_HEADERS=$(ARCH_DIR)/cannon_lake_512.h $(ARCH_DIR)/Arch.h

ICE_LAKE_256=$(ARCH_DIR)/ice_lake_256.c
ICE_LAKE_256_HEADERS=$(ARCH_DIR)/ice_lake_256.h $(ARCH_DIR)/Arch.h

ICE_LAKE_512=$(ARCH_DIR)/ice_lake_512.c
ICE_LAKE_512_HEADERS=$(ARCH_DIR)/ice_lake_512.c $(ARCH_DIR)/Arch.h

KNL=$(ARCH_DIR)/knl.c
KNL_HEADERS=$(ARCH_DIR)/knl.h $(ARCH_DIR)/Arch.h

ZEN=$(ARCH_DIR)/zen.c
ZEN_HEADERS=$(ARCH_DIR)/zen.h $(ARCH_DIR)/Arch.h

ZEN_PLUS=$(ARCH_DIR)/zen_plus.c
ZEN_PLUS_HEADERS=$(ARCH_DIR)/zen_plus.h $(ARCH_DIR)/Arch.h

OUTPUT_DIR=output
$(shell mkdir -p $(OUTPUT_DIR))

OUT_SANDY_BRIDGE=$(OUTPUT_DIR)/sandy_bridge.o
OUT_IVY_BRIDGE=$(OUTPUT_DIR)/ivy_bridge.o
OUT_HASWELL=$(OUTPUT_DIR)/haswell.o
OUT_SKYLAKE_256=$(OUTPUT_DIR)/skylake_256.o
OUT_SKYLAKE_512=$(OUTPUT_DIR)/skylake_512.o
OUT_BROADWELL=$(OUTPUT_DIR)/broadwell.o
OUT_KABY_LAKE=$(OUTPUT_DIR)/kaby_lake.o
OUT_COFFEE_LAKE=$(OUTPUT_DIR)/coffee_lake.o
OUT_CANNON_LAKE=$(OUTPUT_DIR)/cannon_lake.o
OUT_ICE_LAKE_256=$(OUTPUT_DIR)/ice_lake_256.o
OUT_ICE_LAKE_512=$(OUTPUT_DIR)/ice_lake_512.o
OUT_KNL=$(OUTPUT_DIR)/knl.o
OUT_ZEN=$(OUTPUT_DIR)/zen.o
OUT_ZEN_PLUS=$(OUTPUT_DIR)/zen_plus.o

ALL_OUTS=$(OUT_SANDY_BRIDGE) $(OUT_IVY_BRIDGE) $(OUT_HASWELL) $(OUT_SKYLAKE_256) $(OUT_SKYLAKE_512) $(OUT_BROADWELL) $(OUT_KABY_LAKE) $(OUT_COFFEE_LAKE) $(OUT_CANNON_LAKE_256) $(OUT_CANNON_LAKE_512) $(OUT_ICE_LAKE_256) $(OUT_ICE_LAKE_512) $(OUT_KNL) $(OUT_ZEN) $(OUT_ZEN_PLUS)

peakperf: $(MAIN) $(ALL_OUTS)
	$(CXX) $(CXXFLAGS_GENERIC) -mavx $(CXXFLAGS_LINK) $(MAIN) $(ALL_OUTS) -o $@

release: $(MAIN) $(ALL_OUTS)
	$(CXX) $(CXXFLAGS_GENERIC) -mavx -static $(CXXFLAGS_LINK) $(MAIN) $(ALL_OUTS) -o $@

$(OUT_SANDY_BRIDGE): Makefile $(SANDY_BRIDGE) $(SANDY_BRIDGE_HEADERS)
	$(CXX) $(CXXFLAGS_SANDY_BRIDGE) $(SANDY_BRIDGE) -c -o $@
	
$(OUT_IVY_BRIDGE): Makefile $(IVY_BRIDGE) $(IVY_BRIDGE_HEADERS)
	$(CXX) $(CXXFLAGS_IVY_BRIDGE) $(IVY_BRIDGE) -c -o $@
	
$(OUT_HASWELL): Makefile $(HASWELL) $(HASWELL_HEADERS)
	$(CXX) $(CXXFLAGS_HASWELL) $(HASWELL) -c -o $@
	
$(OUT_SKYLAKE_256): Makefile $(SKYLAKE_256) $(SKYLAKE_256_HEADERS)
	$(CXX) $(CXXFLAGS_SKYLAKE_256) $(SKYLAKE_256) -c -o $@
	
$(OUT_SKYLAKE_512): Makefile $(SKYLAKE_512) $(SKYLAKE_512_HEADERS)
	$(CXX) $(CXXFLAGS_SKYLAKE_512) $(SKYLAKE_512) -c -o $@	
	
$(OUT_BROADWELL): Makefile $(BROADWELL) $(BROADWELL_HEADERS)
	$(CXX) $(CXXFLAGS_BROADWELL) $(BROADWELL) -c -o $@
	
$(OUT_KABY_LAKE): Makefile $(KABY_LAKE) $(KABY_LAKE_HEADERS)
	$(CXX) $(CXXFLAGS_KABY_LAKE) $(KABY_LAKE) -c -o $@
	
$(OUT_COFFEE_LAKE): Makefile $(COFFEE_LAKE) $(COFFEE_LAKE_HEADERS)
	$(CXX) $(CXXFLAGS_COFFEE_LAKE) $(COFFEE_LAKE) -c -o $@
	
$(OUT_CANNON_LAKE_256): Makefile $(CANNON_LAKE_256) $(CANNON_LAKE_256_HEADERS)
	$(CXX) $(CXXFLAGS_CANNON_LAKE_256) $(CANNON_LAKE_256) -c -o $@
	
$(OUT_CANNON_LAKE_512): Makefile $(CANNON_LAKE_512) $(CANNON_LAKE_512_HEADERS)
	$(CXX) $(CXXFLAGS_CANNON_LAKE_512) $(CANNON_LAKE_512) -c -o $@	
	
$(OUT_ICE_LAKE_256): Makefile $(ICE_LAKE_256) $(ICE_LAKE_256_HEADERS)
	$(CXX) $(CXXFLAGS_ICE_LAKE_256) $(ICE_LAKE_256) -c -o $@

$(OUT_ICE_LAKE_512): Makefile $(ICE_LAKE_512) $(ICE_LAKE_512_HEADERS)
	$(CXX) $(CXXFLAGS_ICE_LAKE_512) $(ICE_LAKE_512) -c -o $@	
	
$(OUT_KNL): Makefile $(KNL) $(KNL_HEADERS)
	$(CXX) $(CXXFLAGS_KNL) $(KNL) -c -o $@
	
$(OUT_ZEN): Makefile $(ZEN) $(ZEN_HEADERS)
	$(CXX) $(CXXFLAGS_ZEN) $(ZEN) -c -o $@
	
$(OUT_ZEN_PLUS): Makefile $(ZEN_PLUS) $(ZEN_PLUS_HEADERS)
	$(CXX) $(CXXFLAGS_ZEN_PLUS) $(ZEN_PLUS) -c -o $@			
	
clean:
	@rm peakperf $(ALL_OUTS)	
