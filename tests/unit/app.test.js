// tests/unit/app.test.js

const request = require('supertest');

const app = require('../../src/app');

describe('404 response test', () => {
   test('404 handler included', () => request(app).get('/doesntexist').expect(404));

});
