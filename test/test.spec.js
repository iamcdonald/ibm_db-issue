const data = require('./data');

const INSERT_BLOB = `
  INSERT INTO DB.DUMMY
  (DATA) VALUES (?)
`;

describe('ibm_db memory issue', () => {
  describe('when attempting to insert data', () => {
    let val;
    beforeEach(() => {
      val = 'this is content';
    });

    it('happily inserts', async () => {
      const insertVal = {
        DataType: 'BLOB',
        Data: val
      };
      await data.execute(INSERT_BLOB, [insertVal]);
    });
  });

  describe('when attempting to insert the same data in base64 format', () => {
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
