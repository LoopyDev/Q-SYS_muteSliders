-- Module object
muteSliders = {}

-- Control components array:
--sliderSystem = {
--  {fader},{toggle}, {valueAtMute}
--};
sliderSystem = {}

-- This is the only function which needs to be called in the UCI script, 
-- apart from 'something = require('Q-Sys_muteSliders')'.
-- A fader and toggle need to be passed to it, in order for them to cooperate. 
-- It then adds them to an array which is used to programatically create 
-- appropriate eventhandlers for toggling values and CSS styles.
function muteSliders.addSlider(fader, toggle)
    if sliderSystem == nil then sliderSystem = {} end
    -- Initialize slider_position_at_mute for each pair, 
    -- this allows unmuting by moving the muted slider
    local slider_position_at_mute = nil
    local newRow = {fader, toggle, slider_position_at_mute}
    -- Populate the array 
    table.insert(sliderSystem, newRow)

    muteSliders.assignEventHandlers()
    -- Initial call to adjust styles based on values at load time 
  muteSliders.callEventHandlers()
end

-- Call the fader and toggle eventhandlers in sliderSystem array
function muteSliders.callEventHandlers()
  for controlPair = 1, #sliderSystem do
    sliderSystem[controlPair][1].EventHandler()
    sliderSystem[controlPair][2].EventHandler()
    end
end

function muteSliders.assignEventHandlers()
    -- Iterating over each row in array
    for controlPair = 1, #sliderSystem do
        -- Slider EventHandler
        sliderSystem[controlPair][1].EventHandler = function()
            -- Mute if slider positioned at 0
            if sliderSystem[controlPair][1].Position == 0 then
                muteSliders.mute(controlPair)
            end
            -- Unmute if muted slider is moved
            local slider_position_at_mute = sliderSystem[controlPair][3]
            if sliderSystem[controlPair][1].Position ~= slider_position_at_mute then
                muteSliders.unmute(controlPair)
            end
        end

        -- Toggle EventHandler
        sliderSystem[controlPair][2].EventHandler = function()
            -- Muting and unmuting using toggle
            if sliderSystem[controlPair][2].Boolean == true then
                muteSliders.mute(controlPair)
            elseif sliderSystem[controlPair][2].Boolean == false then
                muteSliders.unmute(controlPair)
            end
        end
    end
end

function muteSliders.unmute(controlPair)
    if sliderSystem[controlPair][1].Position == 0 then sliderSystem[controlPair][1].Position = 0.1 end
    sliderSystem[controlPair][2].Value = 0
    -- Apply unmuted fader style
    sliderSystem[controlPair][1].CssClass = "fader_unmuted"
    sliderSystem[controlPair][2].CssClass = "muteToggle"
    -- Reset the stored position
    sliderSystem[controlPair][3] = nil
end

function muteSliders.mute(controlPair)
    -- Mute the toggle
    sliderSystem[controlPair][2].Boolean = true
    -- Save slider position
    sliderSystem[controlPair][3] = sliderSystem[controlPair][1].Position
    -- Apply muted fader style
    sliderSystem[controlPair][1].CssClass = "fader_muted"
    sliderSystem[controlPair][2].CssClass = "muteToggle"

end

return muteSliders
