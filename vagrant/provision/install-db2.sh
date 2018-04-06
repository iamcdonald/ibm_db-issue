DB2INST1_PASSWORD=db2inst1
DB2EXPRESSC_DATADIR=/home/db2inst1/data
DB2EXPRESSC_INSTFILE=v11.1_linuxx64_dec.tar.gz

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Pre-requisites
dpkg --add-architecture i386
apt-get update
apt-get install -y libx32stdc++6 libpam0g:i386 libaio1

# Users + Groups
groupadd db2iadm1
useradd -m -G db2iadm1 db2inst1
(echo "$DB2INST1_PASSWORD"; echo "$DB2INST1_PASSWORD") | passwd db2inst1 > /dev/null  2>&1

# Install DB2
mkdir -p /tmp/expc
tar -xf $DIR/db2/$DB2EXPRESSC_INSTFILE -C /tmp/expc \
    && su - db2inst1 -c "/tmp/expc/**/db2_install -y -b /home/db2inst1/sqllib -p server" \
    && echo '. /home/db2inst1/sqllib/db2profile' >> /home/db2inst1/.bash_profile \
    && rm -rf /tmp/db2* && rm -rf /tmp/expc* \
    && sed -ri  's/(ENABLE_OS_AUTHENTICATION=).*/\1YES/g' /home/db2inst1/sqllib/instance/db2rfe.cfg \
    && sed -ri  's/(RESERVE_REMOTE_CONNECTION=).*/\1YES/g' /home/db2inst1/sqllib/instance/db2rfe.cfg \
    && sed -ri 's/^\*(SVCENAME=db2c_db2inst1)/\1/g' /home/db2inst1/sqllib/instance/db2rfe.cfg \
    && sed -ri 's/^\*(SVCEPORT)=48000/\1=50000/g' /home/db2inst1/sqllib/instance/db2rfe.cfg \
    && mkdir $DB2EXPRESSC_DATADIR && chown db2inst1.db2iadm1 $DB2EXPRESSC_DATADIR

# Increase shmmax
sysctl -w kernel.shmmax=1073741824

# Bootstrap db2
su - db2inst1 -c "db2start && db2set DB2COMM=TCPIP && db2 UPDATE DBM CFG USING DFTDBPATH $DB2EXPRESSC_DATADIR IMMEDIATE && db2 create database db2inst1" \
    && su - db2inst1 -c "db2stop force" \
    && cd /home/db2inst1/sqllib/instance \
    && ./db2rfe -f ./db2rfe.cfg

# Copy init.d script and set to start by default
cp $DIR/db2/init-script /etc/init.d/db2
update-rc.d db2 defaults

# Start DB2
/etc/init.d/db2 start