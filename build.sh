#!/bin/sh

### Kiss-GUI build script by Alex Fedorov AKA FedorComander

NWJS_VERSION="0.17.0"
GUI_LOCATION="../kissfc-chrome-gui/"
NWJS_OSX_URL="https://dl.nwjs.io/v${NWJS_VERSION}/nwjs-v${NWJS_VERSION}-osx-x64.zip"
NWJS_OSX_FILE="nwjs-v${NWJS_VERSION}-osx-x64"
NWJS_WIN64_URL="https://dl.nwjs.io/v${NWJS_VERSION}/nwjs-v${NWJS_VERSION}-win-x64.zip"
NWJS_WIN64_FILE="nwjs-v${NWJS_VERSION}-win-x64"
NWJS_WIN32_URL="https://dl.nwjs.io/v${NWJS_VERSION}/nwjs-v${NWJS_VERSION}-win-ia32.zip"
NWJS_WIN32_FILE="nwjs-v${NWJS_VERSION}-win-ia32"

EXECUTABLE_NAME="Kiss-GUI"
GUI_VERSION="1.0.13"

echo "Prepare sources"
if [ ! -d tmp ] ; then
    mkdir tmp
fi
if [ ! -d build ] ; then
    mkdir build
fi

echo "Starting to build OSX binary"
if [ ! -f tmp/${NWJS_OSX_FILE}.zip ] ; then
    echo "Downloading OSX version ${NWJS_VERSION} of NWJS"
    curl ${NWJS_OSX_URL} -o tmp/${NWJS_OSX_FILE}.zip
fi
unzip tmp/${NWJS_OSX_FILE} -d tmp/
mv tmp/${NWJS_OSX_FILE}/nwjs.app tmp/${NWJS_OSX_FILE}/${EXECUTABLE_NAME}.app
mkdir tmp/${NWJS_OSX_FILE}/${EXECUTABLE_NAME}.app/Contents/Resources/app.nw
rsync -av --progress ${GUI_LOCATION}/ tmp/${NWJS_OSX_FILE}/${EXECUTABLE_NAME}.app/Contents/Resources/app.nw/ --exclude '.*'
cp res/osx/app.icns tmp/${NWJS_OSX_FILE}/${EXECUTABLE_NAME}.app/Contents/Resources/
cp res/osx/document.icns tmp/${NWJS_OSX_FILE}/${EXECUTABLE_NAME}.app/Contents/Resources/
cd tmp/${NWJS_OSX_FILE}/
zip -r ../../build/${EXECUTABLE_NAME}-${GUI_VERSION}-osx-x64.zip ${EXECUTABLE_NAME}.app 
cd ../..
rm -rf tmp/${NWJS_OSX_FILE}
echo "Done building OSX binary"




echo "Starting to build WIN64 binary"
if [ ! -f tmp/${NWJS_WIN64_FILE}.zip ] ; then
    echo "Downloading WIN64 version ${NWJS_VERSION} of NWJS"
    curl ${NWJS_WIN64_URL} -o tmp/${NWJS_WIN64_FILE}.zip
fi
unzip tmp/${NWJS_WIN64_FILE} -d tmp/
mkdir tmp/${NWJS_WIN64_FILE}/package.nw
rsync -av --progress ${GUI_LOCATION}/ tmp/${NWJS_WIN64_FILE}/package.nw/ --exclude '.*'
cd tmp/${NWJS_WIN64_FILE}/
mv nw.exe ${EXECUTABLE_NAME}.exe
zip -r ../../build/${EXECUTABLE_NAME}-${GUI_VERSION}-win-x64.zip *
cd ../..
rm -rf tmp/${NWJS_WIN64_FILE}
echo "Done building WIN64 binary"




echo "Starting to build WIN32 binary"
if [ ! -f tmp/${NWJS_WIN32_FILE}.zip ] ; then
    echo "Downloading WIN32 version ${NWJS_VERSION} of NWJS"
    curl ${NWJS_WIN32_URL} -o tmp/${NWJS_WIN32_FILE}.zip
fi
unzip tmp/${NWJS_WIN32_FILE} -d tmp/
mkdir tmp/${NWJS_WIN32_FILE}/package.nw
rsync -av --progress ${GUI_LOCATION}/ tmp/${NWJS_WIN32_FILE}/package.nw/ --exclude '.*'
cd tmp/${NWJS_WIN32_FILE}/
mv nw.exe ${EXECUTABLE_NAME}.exe
zip -r ../../build/${EXECUTABLE_NAME}-${GUI_VERSION}-win-ia32.zip *
cd ../..
rm -rf tmp/${NWJS_WIN32_FILE}
echo "Done building WIN32 binary"


