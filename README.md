# Anrhem's DATA HSLab rig

## Journal

## Day 2

#### Setting up the Jetsons
- Downloaded a NVIDIA's stock Jetson distro from the official site: https://www.developer.nvidia.com/embedded/downloads
- Flashed 6 SD cards to have as many devices to work through the week

#### Setting up the RealSense cameras
- Unpacked all the RealSense D435i and rigged them on the provisional pipe rig
- Updated the firmware of each one of them from my Ubuntu laptop
- Got a USB 3 hub (5Gbps) and tested all four cameras (D435i) *on my laptop*:
    - getting all 4 video feeds works fine
    - getting all 4 depth buffers works fine too
    - but getting both pixel and depth starts dropping frames

#### Setting up RealSense on Jetson

[The stock RealSense linux install instructions](https://github.com/IntelRealSense/librealsense/blob/master/doc/distribution_linux.md) will not work on the NVIDIA Jetson, some of the commands will complete successfully, others will not. The Jetson, like the Raspberry Pi needs `arm` builds for all binaries, so you need to build from source or find binaries.

[This article](https://www.jetsonhacks.com/2019/05/16/jetson-nano-realsense-depth-camera/) explains the painful process you are about to embark on.

I downloaded the contents of this repo [JetsonHacksNano/installLibrealsense](https://github.com/JetsonHacksNano/installLibrealsense) and executed `./installLibrealsense.sh` but it ran out of RAM half-way through compilation. So it is recommended that you first create a swap file, so that this happen to you. To create the swap file I used a script that you can get an run like this:

```
curl -s https://raw.githubusercontent.com/JetsonHacksNano/installSwapfile/master/installSwapfile.sh | bash
```

This script will ask a few questions but if you press enter in each of them it will run with reasonable defaults and create a 8Gb swap file that should be enough to compile `librealsense2`. Now you are ready to go back to the directory where your `./installLibrealsense.sh` script is and run it. This will take about 40m, so it's a good time to go and grab a coffee.

#### NDI

Doeke brought up NDI, seems like a fairly solid standard for video over IP that is supported by _Touch Designer_ among others. Looking for a straightforward way to pump NDI video, I found that [OBS has a plugin](https://github.com/Palakis/obs-ndi/releases/tag/4.7.1), that allows to choose NDI as source and also configure NDI as output.

I also found this repo [jadsys/NDI-Video-Sender_Receiver](https://github.com/jadsys/NDI-Video-Sender_Receiver) that seems to have some kind of streaming server.

###### NDI SDK

Newtek has a NDI SDK, but it is hidden behind a dumb signup form, these are the direct links: [NDI SDK for Windows](http://new.tk/NDISDK), [NDI SDK for iOS and OSX](http://new.tk/NDISDKAPPLE), [NDI SDK for Linux](http://new.tk/NDISDKLINUX)

##### Gotcha

After compiling and installing you can try to run `realsense-viewer` to test if your system is ready for realsense stuff. I did notice on the first run that I got an error message related to some files being duplicate.

![dupes](assets/img/sshot-udev-duplicate.png)

##### RealSense D435 vs. D435i

The D435 should work now, so if you plug it and start `realsense-viewer` you should be able to enable and see the video and depth feeds.

![d435](assets/img/d435-working-nvidia-jetson.png)

The D435i however will not, you will see this error in your console when you run `realsense-viewer` with a D435i plugged in.

```WARNING [548463096256] (ds5-factory.cpp:889) DS5 group_devices is empty.```

With a bit of google mining I found these relevant threads:
- [https://github.com/IntelRealSense/librealsense/issues/3165](https://github.com/IntelRealSense/librealsense/issues/3165)
- 

##### Rebuilding the kernel

I took the scripts in this repository [JetsonHacksNano/buildKernelAndModules](https://github.com/JetsonHacksNano/buildKernelAndModules) and followed the README step by step. I only customised one thing in the `getKernelSources.sh` scripts, I updated the variable `L4T_TARGET="32.2.1"` to be `L4T_TARGET="32.2.3"` because that's the version I am running. As of this writing the kernel is still compiling (it takes about 1h30 for the kernel and another 2h for the modules)

## Day 1

- I got `librealsense2` to work on my Ubuntu laptop
- I got [depthkit](https://www.depthkit.tv) to work with the RealSense on a Windows 10 machine (you need to install Media Extensions)
