#!/bin/bash
BL=$PWD/treble_build_los
echo "Reverting LOS FOD implementation"
cd frameworks/base
git am $BL/patches/0001-Squashed-revert-of-LOS-FOD-implementation.patch
cd ../..
cd frameworks/native
git am $BL/patches/0001-Revert-surfaceflinger-Add-support-for-extension-lib.patch
cd ../..
cd vendor/lineage
git revert 612c5a846ea5aed339fe1275c119ee111faae78c --no-edit # soong: Add flag for fod extension
cd ../..
echo ""

echo "Applying PHH patches"
rm -f device/*/sepolicy/common/private/genfs_contexts
cd device/phh/treble
git clean -fdx
bash generate.sh lineage
cd ../../..
bash $BL/apply_patches.sh treble_patches
echo ""

echo "Applying universal patches"
cd frameworks/base
git am $BL/patches/0001-UI-Revive-navbar-layout-tuning-via-sysui_nav_bar-tun.patch
git am $BL/patches/0001-Disable-vendor-mismatch-warning.patch
#git am $BL/patches/0001-core-Add-support-for-MicroG.patch
cd ../..
cd lineage-sdk
git am $BL/patches/0001-sdk-Invert-per-app-stretch-to-fullscreen.patch
cd ..
cd packages/apps/LineageParts
git am $BL/patches/0001-LineageParts-Invert-per-app-stretch-to-fullscreen.patch
cd ../../..
cd vendor/lineage
git am $BL/patches/0001-vendor_lineage-Log-privapp-permissions-whitelist-vio.patch
cd ../..
echo ""

echo "Applying GSI-specific patches"
cd build/make
git am $BL/patches/0001-build-Don-t-handle-apns-conf.patch
cd ../..
cd external/tinycompress
git revert 82c8fbf6d3fb0a017026b675adf2cee3f994e08a --no-edit # tinycompress: Use generated kernel headers
cd ../..
cd frameworks/native
git revert 581c22f979af05e48ad4843cdfa9605186d286da --no-edit # Add suspend_resume trace events to the atrace 'freq' category.
cd ../..
cd hardware/lineage/interfaces
git am $BL/patches/0001-cryptfshw-Remove-dependency-on-generated-kernel-head.patch
cd ../../..
cd system/hardware/interfaces
git revert 5c145c49cc83bfe37c740bcfd3f82715ee051122 --no-edit # system_suspend: start early
cd ../../..
cd system/sepolicy
git revert d12551bf1a6e8a9ece6bbb98344a27bde7f9b3e1 --no-edit # sepolicy: Relabel wifi. properties as wifi_prop
git am $BL/patches/0001-Revert-sepolicy-Address-denials-for-legacy-last_kmsg.patch
cd ../..
cd vendor/lineage
git am $BL/patches/0001-build_soong-Disable-generated_kernel_headers.patch
cd ../..
