./build/X86/gem5.opt configs/example/se.py -c ./quicksort \
--cpu-type=TimingSimpleCPU \
--caches --l2cache --l3cache --l3_assoc=1 --l1i_size=32kB --l1d_size=32kB --l2_size=128kB --l3_size=1MB \
--mem-type=NVMainMemory \
--nvmain-config=../NVmain/Config/PCM_ISSCC_2012_4GB.config
cat m5out/stats.txt