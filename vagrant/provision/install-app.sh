DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Provision database
su - db2inst1 -c "db2 -stvf /data/db/db2/container/provision.sql"

# Copy the application files to the local file system
mkdir -p /opt/nodejs/ibm_db-issue
rsync --exclude=vagrant -a /data/ /opt/nodejs/ibm_db-issue

# npm install
cd /opt/nodejs/ibm_db-issue
npm install

# Ownership + permissions
chown -R vagrant /opt/nodejs
chmod -R u+w /opt/nodejs
