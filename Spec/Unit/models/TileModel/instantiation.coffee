jest.autoMockOff()

TileModel = require process.cwd() + '/Resources/coffee/models/TileModel.coffee'

describe 'TileModel instantiation', ->
    it 'should require `x` and `y` as properties of instantiation argument object', ->
        expect( ->
            new TileModel()
        ).toThrow()