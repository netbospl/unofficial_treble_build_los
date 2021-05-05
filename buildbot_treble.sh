#!/bin/bash
echo ""
echo "Uofficial /e/ v1-q Treble Buildbot"
echo "ATTENTION: this script DOES NOT syncs repo on each run"
echo "Executing in 5 seconds - CTRL-C to exit"
echo ""
sleep 5

START=`date +%s`
BUILD_DATE="$(date +%Y%m%d)"
BL=$PWD/unofficial_treble_build_los

echo "Setting up build environment"
source build/envsetup.sh &> /dev/null
echo ""

echo "CHECK PATCH STATUS NOW!"
sleep 5
echo ""

export WITHOUT_CHECK_API=true
export WITH_SU=true
mkdir -p ~/build-output/

buildVariant() {
	lunch ${1}-userdebug
	make installclean
	make -j$(nproc --all) systemimage
	make vndk-test-sepolicy
	mv $OUT/system.img ~/build-output/eos-$LINEAGE_VERSION-${1}.img
}

buildVariant treble_arm_avS
buildVariant treble_arm_bvS
buildVariant treble_a64_avS
buildVariant treble_a64_bvS
buildVariant treble_arm64_avS
buildVariant treble_arm64_bvS
ls ~/build-output | grep 'eos-'

END=`date +%s`
ELAPSEDM=$(($(($END-$START))/60))
ELAPSEDS=$(($(($END-$START))-$ELAPSEDM*60))
echo "Buildbot completed in $ELAPSEDM minutes and $ELAPSEDS seconds"
echo ""
