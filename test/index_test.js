const mocha = require("mocha");
const chai = require("chai");
const chaiAsPromised = require("chai-as-promised");
chai.use(chaiAsPromised);

it('test 1', async () => {
    function reject42() {
        return Promise.reject(new Error('42'))
    }

    await chai.expect(reject42()).to.eventually.be.rejectedWith('4')
});

it('test 1', async () => {
    function reject42() {
        return Promise.reject(new Error('42'))
    }

    await chai.expect(reject42()).to.eventually.be.rejectedWith('2')
});