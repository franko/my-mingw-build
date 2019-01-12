set -e

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <name> <prefix>"
    exit 1
fi

INSTALL_PREFIX="$2"

mkdir -p "${INSTALL_PREFIX}/lib/pkgconfig"
mkdir -p "${INSTALL_PREFIX}/include"
mkdir -p "${INSTALL_PREFIX}/bin"

cat << EOF > "${INSTALL_PREFIX}/bin/activate"
export PATH="${INSTALL_PREFIX}/bin:\${PATH}"

if [ -z "\${LD_LIBRARY_PATH+x}" ]; then
    export LD_LIBRARY_PATH="${INSTALL_PREFIX}/lib"
else
    LD_LIBRARY_PATH="${INSTALL_PREFIX}/lib:\$LD_LIBRARY_PATH"
fi

if [ -z "\${PKG_CONFIG_PATH+x}" ]; then
    export PKG_CONFIG_PATH="${INSTALL_PREFIX}/lib/pkgconfig"
else
    PKG_CONFIG_PATH="${INSTALL_PREFIX}/lib/pkgconfig:\$PKG_CONFIG_PATH"
fi

export CMAKE_PREFIX_PATH="${INSTALL_PREFIX}"
if [ ! -z "\${PS1+x}" ]; then
    PS1="($1) \$PS1"
fi
EOF

chmod a+x "${INSTALL_PREFIX}/bin/activate"

echo "To activate the environment run the command:"
echo "source ${INSTALL_PREFIX}/bin/activate"