
## Building PHH-based eOS GSIs branch v1-q ##

Create a new working directory for your LineageOS build and navigate to it:

    mkdir e-build-gsi; cd e-build-gsi

Initialize your /e/ v1-q branch workspace:

    repo init -u https://gitlab.e.foundation/e/os/android.git -b v1-q

Clone the modified treble manifest to local_manifests:

    git clone https://github.com/netbospl/e-treble-local_manifests.git -b v1-q-trebleonly .repo/local_manifests

Sync repos

    repo sync -j$(nproc --all)

Apply LOS patches from /e/

    bash treble_build_los/apply_los_patches.sh

Generate Treble Lineage Device

    cd device/phh/treble
    bash generate.sh lineage
    cd ../../..

Finally, start the build script:

    bash unofficial_treble_build_los/buildbot_treble.sh

Be sure to update the cloned repos from time to time!
