#!/bin/bash -ex

# Copy documentation
cp license.txt "$DIR_NAME"
cp README.md "$DIR_NAME"

tar -cJvf "${REV_NAME}-source.tar.xz" src externals CMakeLists.txt README.md license.txt
cp "${REV_NAME}-source.tar.xz" "$DIR_NAME"

tar $COMPRESSION_FLAGS "$ARCHIVE_NAME" "$DIR_NAME"

mv "$DIR_NAME" $RELEASE_NAME
mv "${REV_NAME}-source.tar.xz" $RELEASE_NAME

# create AppImage
./.ci/scripts/linux/appimage.sh

7z a "$REV_NAME.7z" $RELEASE_NAME

# move the compiled archive into the artifacts directory to be uploaded by travis releases
mv "$ARCHIVE_NAME" artifacts/
mv "$REV_NAME.7z" artifacts/
mv yuzu-`$REV_NAME`.AppImage artifacts/
