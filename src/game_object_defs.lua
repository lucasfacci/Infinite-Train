GAME_OBJECT_DEFS = {
    ['chair'] = {
        type = 'chair',
        texture = 'chairs',
        frame = 1,
        solid = true,
        width = 32,
        height = 48,
        defaultState = 'stopped',
        states = {
            ['stopped'] = {
                frame = 1
            }
        }
    },
    ['heart'] = {
        type = 'heart',
        texture = 'tiles',
        frame = 15,
        solid = false,
        width = 16,
        height = 16,
        defaultState = 'stopped',
        states = {
            ['stopped'] = {
                frame = 15
            }
        }
    }
}