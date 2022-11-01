# LibEditMode

Modify anchors and settings of frames controlled by edit mode _without_
triggering taint issues.

```lua
local LibEditMode = LibStub("LibEditMode-1-0")
LibEditMode:LoadLayouts()
LibEditMode:ReanchorFrame(MainMenuBar, "TOP", UIParent)
LibEditMode:ApplyChanges()
```
