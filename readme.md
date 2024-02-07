
# Q_SYS_muteSliders

## Module Function
This module allows you to create pairs of volume sliders and mute toggles which work in tandem, influencing each other and providing a visual indication of the mute state.

## Setup Instructions

1. **Move Style Folder**
   - Move the `style_muteSliders` folder to `QSC/Q-Sys Designer/Styles`.

2. **Move Module Directory**
   - Move the parent directory (`Q-SYS_muteSliders`) to `QSC/Q-Sys Designer/Modules`.

3. **Install in Q-SYS Designer**
   - In Q-SYS Designer, install both the style (`style_muteSliders`) and the module (`Q-SYS_muteSliders`) by going to `Tools -> Show Design Resources... -> Available` and clicking the `Install Module` buttons.

   For help, see [Q-Sys 'External Lua Modules' guide](https://q-syshelp.qsc.com/q-sys_9.7/Content/Control_Scripting/External_Lua_Modules.htm)
   and/or the [Q-Sys UCI Styles Guide](https://q-syshelp.qsc.com/Content/Schematic_Library/uci_styles.htm)

4. **Apply the Style**
   - Make sure to apply the style in your UCI's properties panel.

5. **Add Controls in UCI**
   - In your UCI, add `Knob` and `Toggle` controls, naming them appropriately. They will be tied together, so it's recommended to use names which indicate that pairing. Controls' styles are assigned automatically in the Module script.

6. **Initialise the Module in UCI Script**
   - Insert the following Lua code in the UCI Script:
     ```lua
     mutesliders = require('Q-SYS_muteSliders')
     ```

7. **Use `.addSlider()` Function**
   - Call the `.addSlider()` function, passing it first the name of the Knob control, then the Toggle. For example, insert this Lua code:
     ```lua
     mutesliders.addSlider(Controls.fader_1, Controls.toggle_1)
     ```
   - Repeat this for each pair of sliders and toggles in your design.

## Additional Information
For more detailed instructions or troubleshooting, please refer to the [official documentation](https://q-syshelp.qsc.com/).
