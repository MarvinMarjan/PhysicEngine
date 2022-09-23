Engine = require "engine/engine"

Player = require "player/player"

Rectangle = require "objects/shapes/rectangle"
Circle = require "objects/shapes/circle"
Polygon = require "objects/shapes/polygon"

Sett_GUI = require "GUI/settings_window"

function love.load()

    sett_gui = Settings_GUI:new(0, 0)
    engine = Engine:new(64, 0, 0, true)

    winX, winY = love.window.getMode() -- Window width and height

    player = Player:new(engine.world, winX / 2, winY / 2, 10, 100, 0.3, {1, 1, 1}, "player")

    -- World Barriers
    objects:add(Rectangle:new(engine.world, -2, -2, 1, winY, {1, 1, 1, 0}, "static", "barrier")) -- Left
    objects:add(Rectangle:new(engine.world, -2, winY + 2, winX, 1, {1, 1, 1, 0}, "static", "barrier")) -- Bottom
    objects:add(Rectangle:new(engine.world, winX + 2, 0, 1, winY, {1, 1, 1, 0}, "static", "barrier")) -- Right
    objects:add(Rectangle:new(engine.world, -2, -2, winX, 1, {1, 1, 1, 0}, "static", "barrier")) -- Top
end

function love.update(dt)
    player:update(dt)

    engine:update(dt, sett_gui)
    sett_gui:update()
end

function love.draw()
    
    engine:draw()

    player:draw()

    sett_gui:draw()
end