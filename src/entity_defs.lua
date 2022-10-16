ENTITY_DEFS = {
    ['player'] = {
        walkSpeed = PLAYER_WALK_SPEED,
        animations = {
            ['idle-down'] = {
                frames = {1},
                texture = 'character_walk'
            },
            ['walk-down'] = {
                frames = {1, 2, 3, 4},
                interval = 0.2,
                texture = 'character_walk'
            }
        }
    }
}