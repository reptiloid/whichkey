function getCurrentCommandQueue()
  return currentCommandQueue
end

function ActivateEnhTab()
    if controls.constructionGroup:IsHidden() then return end
    
    if controls.enhancementTab:IsDisabled() then 
      return 
    elseif controls.enhancementTab:IsChecked() then
      return
    else
      controls.enhancementTab:SetCheck(true)
    end
end

function GetCurrentTabName()
  local lastControl = 'NONE'
  for _, control in controls.tabs do
    lastControl = control.ID
  end

  if lastControl == 'NONE' then
    return 'Attached'
  elseif lastControl == 'templates' then
    return 'Construction'
  elseif lastControl == 'LCH' then
    return 'Enhancement'
  end
end

function ActivateSelTab()
    if controls.constructionGroup:IsHidden() then return end
    controls.selectionTab:SetCheck(true)
end
