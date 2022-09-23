nuklear = require "nuklear"

Settings_GUI = {}
Settings_GUI.__index = Settings_GUI

ui = nuklear.newUI()

function Settings_GUI:new(x, y)
    return setmetatable({
        x = x,
        y = y,

        shapeCombo = {value = 2, items = {"Circle", "Rectangle", "Polygon"}},
        stateRadios = {value = 2, items = {"static", "dynamic"}},

        currentShape = "Rectangle",
        currentColor = nuklear.colorRGBA(250, 250, 250),
        currentState = "static",

        isHovered = false
    }, Settings_GUI)
end

function Settings_GUI:update()
    ui:frameBegin()

    if ui:windowBegin("Settings", self.x, self.y, 250, 250, "border", "title", "movable", "minimizable") then
        
        -- Shapes combo box
        ui:layoutRow("dynamic", 25, 2)
        ui:label("Shape:")

        if ui:combobox(self.shapeCombo, self.shapeCombo.items) then
            self.currentShape = self.shapeCombo.items[self.shapeCombo.value]
        end

        ui:layoutRow("dynamic", 15, 3)
        ui:label("State:")

        self.currentState = ui:radio("static", self.currentState)
        self.currentState = ui:radio("dynamic", self.currentState)

        -- Color picker
        ui:layoutRow("dynamic", 25, 1)
        ui:label("Color:")
        ui:layoutRow("dynamic", 140, 1)

        self.currentColor = ui:colorPicker(self.currentColor, "RGBA")

        self.isHovered = ui:windowIsHovered()
    end
    ui:windowEnd()

    ui:frameEnd()
end


function Settings_GUI:draw()
    ui:draw()
end

function love.keypressed(key, scancode, isrepeat)
	ui:keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
	ui:keyreleased(key, scancode)
end

function love.mousepressed(x, y, button, istouch, presses)
	ui:mousepressed(x, y, button, istouch, presses)
end

function love.mousereleased(x, y, button, istouch, presses)
	ui:mousereleased(x, y, button, istouch, presses)
end

function love.mousemoved(x, y, dx, dy, istouch)
	ui:mousemoved(x, y, dx, dy, istouch)
end

function love.textinput(text)
	ui:textinput(text)
end

function love.wheelmoved(x, y)
	ui:wheelmoved(x, y)
end


return Settings_GUI