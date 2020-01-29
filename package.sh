 #!/usr/bin/env bash
set -e

TARGET_PKG=package.zip
VENDOR_DIR=skill_env/lib/python3.8/site-packages
DIST_DIR=dist
SRC_FILES=(lambda_function.py strings.py)

function clean_package() {
    echo -n "deleting already built package..."
    [ -f $TARGET_PKG ] && rm -f $TARGET_PKG
    [ -d $DIST_DIR ] && rm -rf $DIST_DIR
    echo "  OK  "
}

function compile() {
    echo -n "copying vendor directory..."
    cp -ar $VENDOR_DIR $DIST_DIR && echo -n "  OK  "
    echo

    echo -n "copying source code files..."
    for file in "${SRC_FILES[@]}"; do
        cp -a $file $DIST_DIR && echo -n "  OK  "
    done
    
    echo
}

function package() {
    echo "creating package..."
    pushd $DIST_DIR
    zip -r ../$TARGET_PKG * && echo "successfully created package"
    popd
}

clean_package && compile && package
