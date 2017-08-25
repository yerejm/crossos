#!/bin/env
ISODIR=${1:-$HOME}
FILES="\
    7z1604-x64.msi \
    AddOGLW8and10x64.reg \
    ClassicShellSetup_4_3_1.exe \
    Debloat-Windows-10-master.zip \
    Git-2.14.1-64-bit.exe \
    OOSU10.exe \
    VCForPython27.msi \
    WDK.zip \
    cmake-3.9.1-win64-x64.msi \
    mesa-17.1.7.401-1-sfx.exe \
    ooshutup10.cfg \
    python-2.7.13.amd64.msi \
    pywin32-221.win-amd64-py2.7.exe \
    vs2017layout.zip
"
for f in ${FILES}; do
    if [ -f "${ISODIR}/${f}" ]; then
        echo Linking "${ISODIR}/${f}"
        ln -sf "${ISODIR}/${f}"
    else
        echo Linking "${ISODIR}/${f}" failed.
    fi
done
