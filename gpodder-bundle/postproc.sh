#!/bin/sh

rm -Rf ~/Desktop/gPodder.app/Contents/Resources/lib/python2.7/test
rm -Rf ~/Desktop/gPodder.app/Contents/Resources/lib/python2.7/unittest
rm -Rvf ~/Desktop/gPodder.app/Contents/Resources/lib/python2.7/*/test
rm -f ~/Desktop/gPodder.app/Contents/Resources/lib/python2.7/config/libpython2.7.a
find ~/Desktop/gPodder.app/Contents/Resources/lib/python2.7 -name '*.pyc' -delete
find ~/Desktop/gPodder.app/Contents/Resources/lib/python2.7 -name '*.pyo' -delete
rm -f ~/Desktop/gPodder.app/Contents/MacOS/gPodder-bin
rm -Rf ~/Desktop/gPodder.app/Contents/Resources/share/gpodder/ui/qml
rm -Rf ~/Desktop/gPodder.app/Contents/Resources/lib/python2.7/site-packages/gpodder/{qmlui,webui}

# Command-XX shortcuts in gPodder menus 
/usr/bin/xsltproc -o gpodder.ui.tmp adjust-modifiers.xsl ~/Desktop/gPodder.app/Contents/Resources/share/gpodder/ui/gtk/gpodder.ui
mv gpodder.ui.tmp ~/Desktop/gPodder.app/Contents/Resources/share/gpodder/ui/gtk/gpodder.ui

# check for dynamic linking consistency : nothing should reference gtk/inst
find ~/Desktop/gPodder.app -name '*.so' -and -print -and  -exec sh -c 'otool -L $1 | grep /gtk/inst' '{}' '{}' ';'

# Set the version and copyright automatically 
/usr/bin/xsltproc -o ~/Desktop/gPodder.app/Contents/Info.plist info-plist.xsl Info-gpodder.plist
