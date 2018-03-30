const data = require('./data');
const fs = require('fs');
const path = require('path');

const INSERT_BLOB = `
  INSERT INTO DUMMY
  (
    DATA
  )
  VALUES (?)
`;

const ADD_TO_TABLE = `
  INSERT INTO TABLE
  (
    FID
  )
  VALUES (?)
`;

describe('ibm_db memory issue with larger file input', () => {

  describe('when attempting to insert the data in base64 format', () => {
    let val;
    beforeEach(() => {
      val = fs.readFileSync(path.resolve('test', 'file.xlsx')).toString('base64')
    });

    it('throws a myriad of memory errors within the ODBC binding', async () => {
      const insertVal = {
        SQLType: 'BLOB',
        Data: val
      };
      // requires a insert prior to inserting the blob
      // removing the line below cause the memory issue to not present
      await data.execute(ADD_TO_TABLE, ['1']);
      await data.execute(INSERT_BLOB, [
        insertVal
      ]);
    });
  });
});
