## checks if the realsense and NDI libraries are installed in the current system

missing() {
	echo "\e[5m\e[31m$1 is missing, please install it.\e[39m\e[25m"
}

present() {
	#echo "\xE2\x9C\x94"
	echo "\e[32m $1 is ok\e[39m"
}

LIBDIRS="/usr/local/lib /usr/lib/x86_64-linux-gnu /usr/lib/aarch64-linux-gnu /usr/lib"
CHECK="librealsense2.so libndi.so"
for fname in $CHECK; do
  found=false
  #echo "Checking at $dir..."
  for dir in $LIBDIRS; do
    echo "Checking $dir/$fname"
    if [ -f "$dir/$fname" ]; then
    	#present "$fname is there!"
	found=true
    else
	#missing "$fname is not there!"
	found=false
    fi
  done

  if [ "$found" = true ] ; then
     present "$fname"
  else
     missing "$fname"
  fi

done
