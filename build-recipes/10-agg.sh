
if [ -z $INSTALL_PREFIX ]
then
    echo "Please run the env.sh script before with the prefix directory"
    exit 1
fi

cd agg-2.5
make clean
CC="$CC_BASE" CFLAGS="$CFLAGS_AGG" CXX="$CXX_BASE" CXXFLAGS="$CXXFLAGS_AGG" make

cp src/libagg.a "$INSTALL_PREFIX/lib"

rm -fr "$INSTALL_PREFIX/include/agg2"
mkdir -p "$INSTALL_PREFIX/include/agg2"
cp -R include/* "$INSTALL_PREFIX/include/agg2"

PKG_NAME=libagg

WIN_INSTALL_PREFIX=${INSTALL_PREFIX/\/c\//c:\/}
WIN_INSTALL_PREFIX=${WIN_INSTALL_PREFIX//\//\\}

# Warning, since the 'EOF' below in unquoted shell variables substitutions
# will be done on the text body. The '$' should be therefore escaped to
# avoid shell substitution when needed.
cat << EOF > $PKG_NAME.pc
prefix=${WIN_INSTALL_PREFIX}
libdir=\${prefix}/lib
includedir=\${prefix}/include

Name: libagg
Description: Anti-grain library
Version: 2.5.0

Libs: -L\${libdir} -lagg -lm
Cflags: -I\${includedir}
EOF

cp "$PKG_NAME.pc" "$INSTALL_PREFIX/lib/pkgconfig"

touch "${BUILD_DIR}/${SCRIPT_NAME}.build-complete"
