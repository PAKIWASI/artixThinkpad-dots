
local function reload_plugin(prefix)
  for name in pairs(package.loaded) do
    if name:match("^" .. prefix) then
      package.loaded[name] = nil
    end
  end
  require(prefix).setup({})
end
