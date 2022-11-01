-- Copyright 2022 plusmouse. Licensed under terms found in LICENSE file.

local lib = LibStub:NewLibrary("LibEditMode-1-0", 1)

local frame = CreateFrame("Frame")
local knownFrames = {
  ChatFrame1,
}
local frameMap = {}

local layoutInfo

local function GetSystemByID(systemID, systemIndex)
  -- Get the system by checking each one for the right system id
  for _, system in pairs(layoutInfo.layouts[layoutInfo.activeLayout].systems) do
    if system.system == systemID and system.systemIndex == systemIndex then
      return system
    end
  end
end

--[[local function WriteOption(layoutInfo, system, setting, value)
  -- Get and set the setting by looking for the right setting id
  local allSettingsUnorg = actualSystem.settings
  for _, j in ipairs(allSettingsUnorg) do
    if j.setting == setting then
      j.value = value
      return
    end
  end
end]]

-- frame
function lib:ReanchorFrame(frame, ...)
  assert(frame and type(frame) == "table" and frame.IsObjectType and frame:IsObjectType("Frame"), "Frame required")
  local systemID = frame.system
  local systemIndex = frame.systemIndex

  assert(systemID, "This frame isn't used by edit mode")

  local system = GetSystemByID(systemID, systemIndex)
  system.isInDefaultPosition = false

  frame:ClearAllPoints()
  frame:SetPoint(...)
  local anchorInfo = system.anchorInfo

  anchorInfo.point, anchorInfo.relativeTo, anchorInfo.relativePoint, anchorInfo.offsetX, anchorInfo.offsetY = frame:GetPoint(1)
  anchorInfo.relativeTo = anchorInfo.relativeTo:GetName()
end

function lib:AreLayoutsLoaded()
  return layoutInfo ~= nil
end

function lib:LoadLayouts()
  layoutInfo = C_EditMode.GetLayouts()
  local tmp = EditModePresetLayoutManager:GetCopyOfPresetLayouts()
  tAppendAll(tmp, layoutInfo.layouts);
  layoutInfo.layouts = tmp
end

function lib:ApplyChanges()
  C_EditMode.SaveLayouts(layoutInfo)

  ShowUIPanel(EditModeManagerFrame)
  HideUIPanel(EditModeManagerFrame)
end
