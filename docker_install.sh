#!/bin/bash

cd data
/bin/mkdir -p '/usr/local/share/qalculate'
/usr/bin/install -c -m 644 currencies.xml datasets.xml elements.xml functions.xml planets.xml prefixes.xml units.xml variables.xml eurofxref-daily.xml rates.json '/usr/local/share/qalculate'

cd ..
cd libqalculate

/bin/mkdir -p '/usr/local/lib'
/bin/bash ../libtool   --mode=install /usr/bin/install -c   libqalculate.la '/usr/local/lib'

/bin/mkdir -p '/usr/local/include/libqalculate'
/usr/bin/install -c -m 644 Function.h Calculator.h DataSet.h Variable.h ExpressionItem.h Number.h MathStructure.h Prefix.h util.h includes.h Unit.h BuiltinFunctions.h QalculateDateTime.h qalculate.h '/usr/local/include/libqalculate'

cd ../
cd src
/bin/mkdir -p '/usr/local/bin'
/bin/bash ../libtool   --mode=install /usr/bin/install -c qalc '/usr/local/bin'

cd ..
/bin/mkdir -p '/usr/local/lib/pkgconfig'
/usr/bin/install -c -m 644 libqalculate.pc '/usr/local/lib/pkgconfig'
