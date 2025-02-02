# Copyright (c) Meta Platforms, Inc. and affiliates.

CMAKE = $(abspath $(HOST_OUT_DIR)/bin/cmake)

ifeq ($(NDK_ARCH), arm64)
CMAKE_ABI = arm64-v8a
else ifeq ($(NDK_ARCH), x86_64)
CMAKE_ABI = x86_64
else
$(error unknown abi $(NDK_ARCH))
endif

ANDROID_CMAKE_TOOLCHAIN_FILE = $(NDK_PATH)/build/cmake/android.toolchain.cmake
ANDROID_EXTRA_CMAKE_FLAGS = -DCMAKE_TOOLCHAIN_FILE=$(abspath $(ANDROID_CMAKE_TOOLCHAIN_FILE))
ANDROID_EXTRA_CMAKE_FLAGS += -DANDROID_ABI=$(CMAKE_ABI)
ANDROID_EXTRA_CMAKE_FLAGS += -DANDROID_PLATFORM=android-$(NDK_API)
ANDROID_EXTRA_CMAKE_FLAGS += -DANDROID_STL=c++_shared
ANDROID_EXTRA_CMAKE_FLAGS += -DANDROID_ALLOW_UNDEFINED_SYMBOLS=TRUE
ANDROID_EXTRA_CMAKE_FLAGS += -DCMAKE_BUILD_TYPE=$(BUILD_TYPE)

# Install libs/binaries to out directory. Scan the out directory
# when looking up libs and headers.
ANDROID_EXTRA_CMAKE_FLAGS += -DCMAKE_INSTALL_PREFIX=$(abspath $(ANDROID_OUT_DIR))
ANDROID_EXTRA_CMAKE_FLAGS += -DCMAKE_PREFIX_PATH=$(abspath $(ANDROID_OUT_DIR))
ANDROID_EXTRA_CMAKE_FLAGS += -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=NEVER
ANDROID_EXTRA_CMAKE_FLAGS += -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=NEVER
ANDROID_EXTRA_CMAKE_FLAGS += -DCMAKE_FIND_ROOT_PATH_MODE_PACKAGE=NEVER
