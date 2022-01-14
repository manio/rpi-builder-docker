# About
This is a docker file for Raspberry Pi kernel crosscompilation. It is based on ubuntu which is currently used for official Raspberry Pi kernel building. Using this method one can change and build any kernel module and then it should match for insmod/modprobe on a running Raspberry Pi kernel.<br>
It could also be used for crosscompiling any software, but this README is focusing on kernel and/or modules compilation.

# Usage

## 1. Preparing container
1. Fetch definition and build an image:
```bash
docker build -t manio/rpi-builder https://github.com/manio/rpi-builder-docker.git
```
2. Start a container (this will create a workspace subdirectory in local filesystem which is shared/mounted on container), you can adjust it to your needs:
```bash
docker run -it --name rpi-builder -v $PWD/workspace:/workspace manio/rpi-builder
```
3. Now the docker should be up and running a bash.

## 2. Kernel compilation
Official guide is here:<br>
https://www.raspberrypi.com/documentation/computers/linux_kernel.html#cross-compiling-the-kernel

For example, to compile the kernel for the Raspberry Pi 1 you can type this in the running container:
```bash
cd /workspace
git clone --depth 1 https://github.com/raspberrypi/linux.git
cd linux
make bcmrpi_defconfig
make
```
This will do a full kernel compilation (with modules) which can be then copied out from `/workspace` to a remote Raspberry Pi and loaded with insmod/modprobe.

Keep in mind that this is a latest kernel which may be not what you want.
To corelate a specific firmware with corresponding kernel on which the Raspberry Pi is currently running you need to obtain the firmware version and then check the file content:<br>
https://github.com/raspberrypi/firmware/blob/master/extra/git_hash<br>
but for the specific commit (above link is for master).

After this you can do:
```bash
git checkout <OBTAINED_HASH>
```
in the main source kernel directory and compile as above.
