# LibEditMode

Modify anchors and settings of frames controlled by edit mode _without_
triggering taint issues. Only works outside of combat.

```lua
local LibEditMode = LibStub("LibEditMode-1-0")
LibEditMode:LoadLayouts()
LibEditMode:ReanchorFrame(MainMenuBar, "TOP", UIParent)
LibEditMode:ApplyChanges()
```
