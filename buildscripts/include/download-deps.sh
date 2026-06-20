#!/bin/bash -e

. ./include/depinfo.sh

[ -z "$IN_CI" ] && IN_CI=0
[ -z "$WGET" ] && WGET=wget

mkdir -p deps && cd deps

# mbedtls
if [ ! -d mbedtls ]; then
	mkdir mbedtls
	$WGET https://github.com/Mbed-TLS/mbedtls/releases/download/mbedtls-$v_mbedtls/mbedtls-$v_mbedtls.tar.bz2 -O - | \
		tar -xj -C mbedtls --strip-components=1
fi

# dav1d
[ ! -d dav1d ] && git clone https://github.com/videolan/dav1d

# ffmpeg
if [ ! -d ffmpeg ]; then
	args=()
	[ $IN_CI -eq 1 ] && args+=(--depth=1 -b "$v_ci_ffmpeg")
	git clone https://github.com/FFmpeg/FFmpeg ffmpeg "${args[@]}"
fi

# freetype2
[ ! -d freetype2 ] && git clone --recurse-submodules https://gitlab.freedesktop.org/freetype/freetype.git freetype2 -b VER-${v_freetype//./-}

# fribidi
if [ ! -d fribidi ]; then
	mkdir fribidi
	$WGET https://github.com/fribidi/fribidi/releases/download/v$v_fribidi/fribidi-$v_fribidi.tar.xz -O - | \
		tar -xJ -C fribidi --strip-components=1
fi

# harfbuzz
if [ ! -d harfbuzz ]; then
	mkdir harfbuzz
	$WGET https://github.com/harfbuzz/harfbuzz/releases/download/$v_harfbuzz/harfbuzz-$v_harfbuzz.tar.xz -O - | \
		tar -xJ -C harfbuzz --strip-components=1
fi

# unibreak
if [ ! -d unibreak ]; then
	mkdir unibreak
	$WGET https://github.com/adah1972/libunibreak/releases/download/libunibreak_${v_unibreak//./_}/libunibreak-${v_unibreak}.tar.gz -O - | \
		tar -xz -C unibreak --strip-components=1
fi

# libxml2
if [ ! -d libxml2 ]; then
	mkdir libxml2
	$WGET https://gitlab.gnome.org/GNOME/libxml2/-/archive/v${v_libxml2}/libxml2-v${v_libxml2}.tar.gz -O - | \
		tar -xz -C libxml2 --strip-components=1
fi

# fontconfig
if [ ! -d fontconfig ]; then
	mkdir fontconfig
	$WGET https://gitlab.freedesktop.org/fontconfig/fontconfig/-/archive/${v_fontconfig}/fontconfig-${v_fontconfig}.tar.gz -O - | \
		tar -xz -C fontconfig --strip-components=1
fi

# libbluray
if [ ! -d libbluray ]; then
	mkdir libbluray
	$WGET https://downloads.videolan.org/pub/videolan/libbluray/${v_libbluray}/libbluray-${v_libbluray}.tar.xz -O - | \
		tar -xJ -C libbluray --strip-components=1
fi

# libiconv
if [ ! -d libiconv ]; then
	mkdir libiconv
	$WGET https://ftp.gnu.org/pub/gnu/libiconv/libiconv-${v_libiconv}.tar.gz -O - | \
		tar -xz -C libiconv --strip-components=1
fi

# uchardet
if [ ! -d uchardet ]; then
	mkdir uchardet
	$WGET https://gitlab.freedesktop.org/uchardet/uchardet/-/archive/v${v_uchardet}/uchardet-v${v_uchardet}.tar.gz -O - | \
		tar -xz -C uchardet --strip-components=1
fi
# bzip2
if [ ! -d bzip2 ]; then
	mkdir bzip2
	$WGET https://sourceware.org/pub/bzip2/bzip2-${v_bzip2}.tar.gz -O - | \
		tar -xz -C bzip2 --strip-components=1
fi

# xz
if [ ! -d xz ]; then
	mkdir xz
	$WGET https://github.com/tukaani-project/xz/releases/download/v${v_xz}/xz-${v_xz}.tar.xz -O - | \
		tar -xJ -C xz --strip-components=1
fi

# zstd
if [ ! -d zstd ]; then
	mkdir zstd
	$WGET https://github.com/facebook/zstd/releases/download/v${v_zstd}/zstd-${v_zstd}.tar.gz -O - | \
		tar -xz -C zstd --strip-components=1
fi

# libarchive
if [ ! -d libarchive ]; then
	mkdir libarchive
	$WGET https://github.com/libarchive/libarchive/releases/download/v${v_libarchive}/libarchive-${v_libarchive}.tar.xz -O - | \
		tar -xJ -C libarchive --strip-components=1
fi
# libdvdread
if [ ! -d libdvdread ]; then
	mkdir libdvdread
	$WGET https://downloads.videolan.org/pub/videolan/libdvdread/${v_libdvdread}/libdvdread-${v_libdvdread}.tar.xz -O - | \
		tar -xJ -C libdvdread --strip-components=1
fi

# libdvdnav
if [ ! -d libdvdnav ]; then
	mkdir libdvdnav
	$WGET https://downloads.videolan.org/pub/videolan/libdvdnav/${v_libdvdnav}/libdvdnav-${v_libdvdnav}.tar.xz -O - | \
		tar -xJ -C libdvdnav --strip-components=1
fi
# libass
[ ! -d libass ] && git clone https://github.com/libass/libass

# lua
if [ ! -d lua ]; then
	mkdir lua
	$WGET https://www.lua.org/ftp/lua-$v_lua.tar.gz -O - | \
		tar -xz -C lua --strip-components=1
fi

# shaderc is built from the NDK-provided sources; this placeholder keeps it in
# the dependency graph without cloning an extra copy.
mkdir -p shaderc

# libplacebo
[ ! -d libplacebo ] && git clone --recursive https://github.com/haasn/libplacebo

# mpv
: "${MPV_GIT_URL:=https://github.com/FongMi/mpv}"
if [ ! -d mpv ]; then
	if [ -n "$MPV_GIT_REF" ]; then
		git clone --branch "$MPV_GIT_REF" "$MPV_GIT_URL" mpv
	else
		git clone "$MPV_GIT_URL" mpv
	fi
fi

cd ..
