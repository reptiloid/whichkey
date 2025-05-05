local KeyMapper = import('/lua/keymap/keymapper.lua')
local misckeyactions = import('/lua/keymap/misckeyactions.lua')
local KeyDescriptions = import('/lua/keymap/keydescriptions.lua').keyDescriptions

if KeyDescriptions['sacrifice'] == nil then
        KeyDescriptions['sacrifice'] = 'Sacrifice'
end

KeyMapper.SetUserKeyAction('sacrifice', {action = 'StartCommandMode order RULEUCC_Sacrifice', category = 'orders', order = 35,})