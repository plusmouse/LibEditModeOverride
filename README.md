# LibEditMode

Modify anchors and settings of frames controlled by edit mode _without_
triggering taint issues. Only works outside of combat.

```lua
local LibEditMode = LibStub("LibEditMode-1-0")
LibEditMode:LoadLayouts()
LibEditMode:ReanchorFrame(MainMenuBar, "TOP", UIParent)
LibEditMode:ApplyChanges()
```

# Usage
## `LibEditMode:LoadLayouts()`

Required to call before doing any frame settings/anchors. Queries and saves from
the Blizzard API last saved edit mode frame settings and positions.

## `LibEditMode:ReanchorFrame(frame, ...)`

For a frame that is managed by edit mode change the default anchor to `...`
(same parameters as a `frame:SetPoint(...)` call)

## `LibEditMode:SetFrameSetting(frame, setting, value)`

Set an edit mode setting on a frame. Use the enumerations found in the Blizzard
Lua dumps for the setting ids.

## `LibEditMode:SetGlobalSetting(setting, value)`

Set an edit mode account setting. This is just an alias for
`C_EditMode.SetAccountSetting`
