#!/bin/sh
echo "These tasks have been completed:" > ~/logs/update_darwinports.log

#cd /darwinports/base
cd /opt/local/var/db/dports/sources/rsync.rsync.opendarwin.org_dpupdate1/base
echo "" >> ~/logs/update_darwinports.log
echo "cd /darwinports/base" >> ~/logs/update_darwinports.log
date  >> ~/logs/update_darwinports.log

cvs -z3 update -dP
echo "" >> ~/logs/update_darwinports.log
echo "cvs -z3 update -dP" >> ~/logs/update_darwinports.log
date  >> ~/logs/update_darwinports.log

./configure
echo "" >> ~/logs/update_darwinports.log
echo "./configure" >> ~/logs/update_darwinports.log
date  >> ~/logs/update_darwinports.log

make clean && make
echo "" >> ~/logs/update_darwinports.log
echo "make clean && make" >> ~/logs/update_darwinports.log
date  >> ~/logs/update_darwinports.log

sudo make install
echo "" >> ~/logs/update_darwinports.log
echo "make install" >> ~/logs/update_darwinports.log
date  >> ~/logs/update_darwinports.log

#cd /darwinports/dports
cd /opt/local/var/db/dports
echo "" >> ~/logs/update_darwinports.log
echo "cd /darwinports/dports" >> ~/logs/update_darwinports.log
date  >> ~/logs/update_darwinports.log

cvs -z3 update -dP
echo "" >> ~/logs/update_darwinports.log
echo "cvs -z3 update -dP" >> ~/logs/update_darwinports.log
date  >> ~/logs/update_darwinports.log

portindex
echo "" >> ~/logs/update_darwinports.log
echo "portindex" >> ~/logs/update_darwinports.log
date  >> ~/logs/update_darwinports.log

