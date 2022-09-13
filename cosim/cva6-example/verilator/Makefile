TOP  := $(shell git rev-parse --show-toplevel)
CURR := $(shell pwd)

#############################
# Project Settings
#############################
export TOP_MODULE ?= top

#############################
# Accelerator Software Settings
#############################
export NBF_FILE     ?= $(abspath ../prog.nbf)
export HOST_PROGRAM ?= $(abspath ../ps.cpp)
export BASE_FLIST   ?= $(abspath ../Flist.ariane ../Flist.basejump ../flist.vcs)
export FLIST        ?= $(abspath flist.vcs)
export SIM_ARGS     += $(NBF_FILE)
export SIM_DEFINES  += -DVERILATOR

ELF_FILE ?=
START ?=

SKIP_DRAM ?= -DSKIP_DRAM_TESTING

VV_OPTS += -Wno-BLKANDNBLK
VV_DEFS += -DDEBUG

#CFLAGS += -DZYNQ_PL_DEBUG
CFLAGS += -DZYNQ_PS_DEBUG
CFLAGS += -DGP0_ENABLE -DGP0_ADDR_BASE=0x400000000U -DGP0_ADDR_WIDTH=10 -DGP0_DATA_WIDTH=32 -DGP0_HIER_BASE=TOP.top.axil0
CFLAGS += -DGP1_ENABLE -DGP1_ADDR_BASE=0x500000000U -DGP1_ADDR_WIDTH=30 -DGP1_DATA_WIDTH=64 -DGP1_HIER_BASE=TOP.top.axil1
CFLAGS += $(INCLUDES) $(SKIP_DRAM)

include $(TOP)/cosim/mk/Makefile.verilator

#############################
# Modify base flist
#############################
$(FLIST): $(BASE_FLIST)
	echo "+incdir+$$BASEJUMP_STL_DIR)/bsg_cache" > $@
	echo "+incdir+$$BASEJUMP_STL_DIR/bsg_test" >> $@
	echo "+incdir+$$BASEJUMP_STL_DIR/bsg_noc" >> $@
	echo "$(BASEJUMP_STL_DIR)/bsg_test/bsg_nonsynth_dpi_clock_gen.cpp" >> $@
	echo "$(BASEJUMP_STL_DIR)/bsg_test/bsg_nonsynth_dpi_clock_gen.v " >> $@
	echo "$(BASEJUMP_STL_DIR)/bsg_test/bsg_nonsynth_dpi_gpio.v " >> $@
	echo "$(COSIM_SRC_DIR)/bsg_nonsynth_dpi_to_axil.v" >> $@
	echo "$(COSIM_SRC_DIR)/bsg_nonsynth_axi_mem.v" >> $@
	cat $^ | envsubst >> $@

checkpoint.nbf:
	dromajo $(ELF_FILE) --host --maxinsn=$(START) --save=prog --memory_size=256
	riscv64-unknown-elf-dramfs-objcopy --change-addresses 0x80000000 -I binary -O elf64-littleriscv -B riscv prog.mainram mainram.riscv
	riscv64-unknown-elf-dramfs-objcopy --change-addresses 0x10000000 -I binary -O elf64-littleriscv -B riscv prog.bootram bootrom.riscv
	riscv64-unknown-elf-dramfs-objcopy -O verilog mainram.riscv mainram.mem
	riscv64-unknown-elf-dramfs-objcopy -O verilog bootrom.riscv bootrom.mem
	riscv64-unknown-elf-dramfs-objdump -D mainram.riscv > mainram.dump
	riscv64-unknown-elf-dramfs-objdump -D bootrom.riscv > bootrom.dump
	python $(BLACKPARROT_DIR)/bp_common/software/py/nbf.py --config --debug --mem mainram.mem --boot_mem bootrom.mem --boot_pc 0x10000000 --skip_zeros > checkpoint.nbf
	rm mainram.mem mainram.riscv bootrom.mem bootrom.riscv prog.mainram prog.bootram

run_checkpoint: obj_dir/V$(TOP_MODULE) checkpoint.nbf
	$^ +bsg_trace $(TRACE) 2>&1 | tee -i $(RUN_LOG)
