const data = require('./data');

const INSERT_BLOB = `
  INSERT INTO DUMMY
  (DATA) VALUES (?)
`;

describe('ibm_db memory issue', () => {

  describe('when attempting to insert the data in base64 format', () => {
    let val;
    beforeEach(() => {
      val = 'dGhlIGZpbGUgY29udGVudA==';
    });

    it('throws a myriad of memory errors within the ODBC binding', async () => {
      const insertVal = {
        DataType: 'BLOB',
        Data: val
      };
      await data.execute(INSERT_BLOB, [insertVal]);
    });
  });
});
