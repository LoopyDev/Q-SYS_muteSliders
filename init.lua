muteSliders = {}

sliderSystem = {}
-- Function to add a slider-toggle pair to the system
function muteSliders.addSlider(slider, toggle)
  if sliderSystem == nil then sliderSystem = {} end
  -- Initialize slider_position_at_mute for each pair
  local slider_position_at_mute = nil
  local newRow = {slider, toggle, slider_position_at_mute}
  table.insert(sliderSystem, newRow)
end

function muteSliders.Start()
-- Iterating over each slider-toggle pair
for controlPair = 1, #sliderSystem do
  -- Slider EventHandler
  sliderSystem[controlPair][1].EventHandler = function()
      -- Mute if slider positioned at 0
      if sliderSystem[controlPair][1].Position == 0 then
        muteSliders.sliderMute(controlPair)
      end

      -- Unmute if muted slider is moved
      local slider_position_at_mute = sliderSystem[controlPair][3]
      if sliderSystem[controlPair][1].Position ~= slider_position_at_mute then
        muteSliders.sliderUnmute(controlPair)
      end
  end

  -- Toggle EventHandler
  sliderSystem[controlPair][2].EventHandler = function()
      -- Muting and unmuting using toggle
      if sliderSystem[controlPair][2].Boolean == true then
          muteSliders.sliderMute(controlPair)
      elseif sliderSystem[controlPair][2].Boolean == false then
        muteSliders.sliderUnmute(controlPair)
      end
  end
end
end

function muteSliders.sliderUnmute(controlPair)
  if sliderSystem[controlPair][1].Position == 0 then sliderSystem[controlPair][1].Position = 0.1 end
  sliderSystem[controlPair][2].Value = 0
  -- Apply unmuted fader style
  sliderSystem[controlPair][1].CssClass = "fader"
  -- Reset the stored position
  sliderSystem[controlPair][3] = nil
end

function muteSliders.sliderMute(controlPair)
  -- Mute the toggle
  sliderSystem[controlPair][2].Boolean = true
  -- Save slider position
  sliderSystem[controlPair][3] = sliderSystem[controlPair][1].Position
  -- Apply muted fader style
  sliderSystem[controlPair][1].CssClass = "fader_disabled"
end


return muteSliders