-- Copyright 2022 plusmouse. Licensed under terms found in LICENSE file.

local lib = LibStub:NewLibrary("LibEditMode-1-0", 1)

local frame = CreateFrame("Frame")

local FRAME_ERROR = "This frame isn't used by edit mode"

local layoutInfo

local function GetSystemByID(systemID, systemIndex)
  -- Get the system by checking each one for the right system id
  for _, system in pairs(layoutInfo.layouts[layoutInfo.activeLayout].systems) do
    if system.system == systemID and system.systemIndex == systemIndex then
      return system
    end
  end
end

local function GetSystemByFrame(frame)
  assert(frame and type(frame) == "table" and frame.IsObjectType and frame:IsObjectType("Frame"), "Frame required")

  local systemID = frame.system
  local systemIndex = frame.systemIndex

  return GetSystemByID(systemID, systemIndex)
end

function lib:SetGlobalSetting(setting, value)
  C_EditMode.SetAccountSetting(setting, value)
end

-- Set an option found in the Enum.EditMode enumerations
function lib:SetFrameSetting(frame, setting, value)
  local system = GetSystemByFrame(frame)

  assert(system, FRAME_ERROR)

  for _, item in pairs(system.settings) do
    if item.setting == setting then
      item.value = value
      return true
    end
  end
  return false
end

function lib:ReanchorFrame(frame, ...)
  local system = GetSystemByFrame(frame)

  assert(system, FRAME_ERROR)

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
  assert(not InCombatLockdown(), "Cannot move frames in combat")
  C_EditMode.SaveLayouts(layoutInfo)

  ShowUIPanel(EditModeManagerFrame)
  HideUIPanel(EditModeManagerFrame)
end
