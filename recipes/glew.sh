set -e
source "build-helper.sh"
enter_git_repository glew https://github.com/nigels-com/glew.git master

echo "Applying patch glew-remove-nostdlib-flag"
git apply ../../patch/glew-remove-nostdlib-flag.patch

export CC="$CC_BASE"
export CFLAGS="$CFLAGS_FASTMATH"
export CXX="$CXX_BASE"
export CXXFLAGS="$CXXFLAGS_FASTMATH"
export GLEW_DEST="${INSTALL_PREFIX}"

make extensions
make all
make install.all