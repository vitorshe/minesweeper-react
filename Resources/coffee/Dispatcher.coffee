Dispatcher = require('Flux').Dispatcher
AppDispatcher = new Dispatcher()
TileStore = require './stores/TileStore.coffee'
ModalStore = require './stores/ModalStore.coffee'

changeModal = (name) ->
    if !name
        ModalStore.reset()
    else
        ModalStore.toggle name

    ModalStore.emitChange()

onTilesChange = ->
    info = TileStore.getInfo()
    if info.win or info.loss
        ModalActions.toggle 'newGame'

    TileStore.emitChange()


AppDispatcher.register (event) ->
    switch event.type
        when 'TILE_FLAG_TOGGLE'
            tile = TileStore.get uid:event.uid
            tile.toggleFlag()
            onTilesChange()

        when 'TILE_CLEAR'
            tile = TileStore.get uid:event.uid
            tile.clear()
            onTilesChange()

        when 'TILES_CLEAR_SAFE_RANDOM'
            tile = TileStore.randomSafeTile()
            if tile
                tile.clear()
                onTilesChange()

        when 'TILES_NEW_GAME'
            TileStore.newGame 8, 4, 10
            onTilesChange()
            changeModal 'newGame'

        when 'MODAL_TOGGLE'
            ModalStore.toggle event.name
            ModalStore.emitChange()

        when 'MODAL_RESET'
            changeModal()

module.exports = AppDispatcher