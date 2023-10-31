@echo off

@REM You need RUBY for the "Test Runner" and QUEMU to simulate your HW! You have to install due missing dependences in the SDK!!
SET PATH=C:\Ruby32-x64\bin;C:\Program Files\qemu;%PATH%

@REM This paths are from toolchain manager "Generate environment script"
SET PATH=C:\ncs\toolchains\31f4403e35;C:\ncs\toolchains\31f4403e35\mingw64\bin;C:\ncs\toolchains\31f4403e35\bin;C:\ncs\toolchains\31f4403e35\opt\bin;C:\ncs\toolchains\31f4403e35\opt\bin\Scripts;C:\ncs\toolchains\31f4403e35\opt\nanopb\generator-bin;C:\ncs\toolchains\31f4403e35\opt\zephyr-sdk\aarch64-zephyr-elf\bin;C:\ncs\toolchains\31f4403e35\opt\zephyr-sdk\x86_64-zephyr-elf\bin;C:\ncs\toolchains\31f4403e35\opt\zephyr-sdk\arm-zephyr-eabi\bin;%PATH%
SET PYTHONPATH=C:\ncs\toolchains\31f4403e35\opt\bin;C:\ncs\toolchains\31f4403e35\opt\bin\Lib;C:\ncs\toolchains\31f4403e35\opt\bin\Lib\site-packages
SET ZEPHYR_TOOLCHAIN_VARIANT=zephyr
SET ZEPHYR_SDK_INSTALL_DIR=C:\ncs\toolchains\31f4403e35\opt\zephyr-sdk
SET ZEPHYR_BASE=C:\ncs\v2.4.0\zephyr

@REM Set build type. qemu for virtual test. Comment out for test on the real HW device!
set build_type=qemu

if "%build_type%"=="qemu" (
    west build --pristine --board qemu_cortex_m3 -t run
) else (
    west build --pristine --board de1353_cpuapp --no-sysbuild -- -DNCS_TOOLCHAIN_VERSION:STRING="NONE" -DBOARD_ROOT:STRING="./"
    nrfjprog  --recover --coprocessor CP_NETWORK
    west flash -d .\build --skip-rebuild
)

pause