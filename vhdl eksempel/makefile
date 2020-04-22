# Makefile
#  Version: 0.1
#  2018-06-19: CEF

# NOTE: you need to modify these settings:
QBIN=c:/altera/13.0sp1/quartus/bin
#QBIN=/opt/altera/13.0sp1/quartus/bin
PROJECT=vscodeExample

#DEPS = $(PROJECT).qpf $(PROJECT).qsf Makefile
#FASTMAP=--effort=fast --incremental_compilation=full_incremental_compilation
#FASTFIT=--effort=fast

.PHONY=all
all: 
	$(QBIN)/quartus_map $(PROJECT) 	--read_settings_files=on \
																	--write_settings_files=off $(FASTMAP)  
	$(QBIN)/quartus_fit $(PROJECT) 	--read_settings_files=off \
																 	--write_settings_files=off $(FASTFIT)
	$(QBIN)/quartus_asm $(PROJECT) 	--read_settings_files=off \
																	--write_settings_files=off
	@# NOTE: sta stage skipped
	@#$(QBIN)/quartus_sta $(PROJECT) 
	$(QBIN)/quartus_eda $(PROJECT) 	--read_settings_files=off \
																	--write_settings_files=off

srcok:
	$(QBIN)/quartus_map $(PROJECT) 	--csf=filtref \
																	--analyze_file=code_lock_advanced.vhd

.PHONY=timing
timing: 
	$(QBIN)/quartus_map $(PROJECT) --generate_functional_sim_netlist
	$(QBIN)/quartus_sim $(PROJECT) --simulation_results_form=VWF 
	@# NOTE: experimental..
	@#quartus_eda --gen_testbench --check_outputs=on \
	@#														--tool=modelsim_oem \
	@#          									--format=verilog $(PROJECT) -c $(PROJECT) 
	@#quartus_eda --functional=on --simulation=on 
	@#														--tool=modelsim_oem 
	@#														--format=verilog $(PROJECT) -c $(PROJECT)

.PHONY=program
program:
	# NOTE: not testet yet
	$(QBIN)/quartus_pgm --no_banner --mode=jtag -o "P;./output_files/$(PROJECT).sof"

.PHONY=vwfview
vwfview:
	# NOTE: not working 100% yet
	$(QBIN)/qwedt --filename ./db/mytestproj.sim.vwf

.PHONY=clean
clean:
	@ rm -rf db incremental_db simulation output_files
