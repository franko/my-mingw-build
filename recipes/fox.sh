fox_version="1.6.57-franko1"
enter_git_repository fox-1.6 https://github.com/franko/fox-1.6.git "v${fox_version}"
build_and_install meson -Ddefault_library=static -Dapps=false -Dopengl=false
