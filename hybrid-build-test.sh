./build/X86/gem5.opt configs/example/se.py -c tests/test-progs/hello/bin/x86/linux/hello \
--cpu-type=TimingSimpleCPU --caches --l2cache --mem-type=NVMainMemory \
--nvmain-config=../NVmain/Config/PCM_ISSCC_2012_4GB.config
cat m5out/stats.txt