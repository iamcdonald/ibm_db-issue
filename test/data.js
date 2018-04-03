const ibmdb = require('ibm_db');
ibmdb.debug(true);

const HOST = process.env.HOST || 'db2';
const PORT = process.env.PORT || '50000';

const CONNECTION_STRING = `DATABASE=DB;CURRENTSCHEMA=DB;UID=db2inst1;PWD=cptdevpw;HOSTNAME=${HOST};PORT=${PORT};DRIVER={DB2};PROTOCOL=TCPIP`;

const execute = async (query, params) =>
	new Promise((resolve, reject) => {
		ibmdb.open(CONNECTION_STRING, (err, conn) => {
			if (err) {
				reject(err);
				return;
			}
			conn.query(query, params, (err, res) => {
				conn.close();
				if (err) {
					reject(err);
					return;
				}
				resolve(res);
			});
		});
	});

module.exports = {
	execute
};
