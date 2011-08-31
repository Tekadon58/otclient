function print(...)
  local msg = ""
  for i,v in ipairs(arg) do
    msg = msg .. tostring(v) .. "\t"
  end
  Logger.log(LogInfo, msg)
end

function createEnvironment()
  local env = { }
  setmetatable(env, { __index = _G} )
  return env
end

function connect(object, signalsAndSlots)
  for signal,slot in pairs(signalsAndSlots) do
    if not object[signal] then
        object[signal] = slot
    elseif type(object[signal]) == 'function' then
        object[signal] = { object[signal], slot }
    elseif type(signal) == 'table' then
        table.insert(object[signal], slot)
    else
    end
  end
end