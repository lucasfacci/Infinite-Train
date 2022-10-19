ENTITY_DEFS = {
    ['player'] = {
        walkSpeed = PLAYER_WALK_SPEED,
        animations = {
            ['idle-down'] = {
                frames = {1},
                texture = 'character_walk'
            },
            ['idle-right'] = {
                frames = {5},
                texture = 'character_walk'
            },
            ['idle-up'] = {
                frames = {9},
                texture = 'character_walk'
            },
            ['idle-left'] = {
                frames = {13},
                texture = 'character_walk'
            },
            ['walk-down'] = {
                frames = {1, 2, 3, 4},
                interval = 0.2,
                texture = 'character_walk'
            },
            ['walk-right'] = {
                frames = {5, 6, 7, 8},
                interval = 0.2,
                texture = 'character_walk'
            },
            ['walk-up'] = {
                frames = {9, 10, 11, 12},
                interval = 0.2,
                texture = 'character_walk'
            },
            ['walk-left'] = {
                frames = {13, 14, 15, 16},
                interval = 0.2,
                texture = 'character_walk'
            }
        }
    }
}