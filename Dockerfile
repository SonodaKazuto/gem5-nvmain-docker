FROM ubuntu:18.04
MAINTAINER SonodaKazuto

VOLUME [ '/home/project' ]

# Install packages
RUN apt update && apt upgrade -y
RUN apt install sudo zsh git nano curl -y
RUN sudo apt install build-essential m4 scons zlib1g zlib1g-dev libprotobuf-dev protobuf-compiler libprotoc-dev \
    libgoogle-perftools-dev python3-dev python3-six python libboost-all-dev pkg-config -y
RUN chsh -s /usr/bin/zsh && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Load and build gem5
WORKDIR /home/project/gem5
RUN curl -s https://gem5.googlesource.com/public/gem5/+archive/525ce650e1a5bbe71c39d4b15598d6c003cc9f9e.tar.gz | \
    tar -xvz -C .
RUN scons build/X86/gem5.opt -j16

# Load and build NVmain
WORKDIR ..
RUN git clone https://github.com/SEAL-UCSB/NVmain
WORKDIR NVmain
COPY /nvmain-solo-build/SConscript /home/project/NVmain
RUN scons --build-type=fast -j16

# Hybrid build gem5 and NVmain
WORKDIR ../gem5
COPY /hybrid-build/SConscript /home/project/NVmain
COPY /hybrid-build/Options.py /home/project/gem5/configs/common
RUN scons EXTRAS=../NVmain build/X86/gem5.opt -j16
RUN ./build/X86/gem5.opt configs/example/se.py -c tests/test-progs/hello/bin/x86/linux/hello \
    --cpu-type=TimingSimpleCPU --caches --l2cache --mem-type=NVMainMemory \
    --nvmain-config=../NVmain/Config/PCM_ISSCC_2012_4GB.config && \
    cat /home/project/gem5/m5out/stats.txt

# Copy start up script
WORKDIR ..
#COPY /scripts/start-up.sh /home/project/
#ENTRYPOINT "sh /home/project/start-up.sh"
