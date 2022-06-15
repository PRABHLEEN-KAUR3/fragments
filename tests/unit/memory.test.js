const { readFragment } = require('../../src/model/data/memory') ;
const { writeFragment } = require('../../src/model/data/memory') ;
const { Fragment } = require('../../src/model/fragment');

const fragment = require('../../src/model/data/memory')

describe('index', () => {

  test('read fragment meta data', async() => {
    const read = await readFragment('1234', fragment.id);
    expect(read).toEqual(fragment);
  })
});
