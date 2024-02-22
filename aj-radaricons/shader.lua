local icons = {
  {
    "img/49.png",
    "radar_dateDrink"
  },
}
addEventHandler("onClientResourceStart", resourceRoot, function()
  for i = 1, #icons do
    local shader = dxCreateShader("shader/shader.fx")
    engineApplyShaderToWorldTexture(shader, icons[i][2])
    dxSetShaderValue(shader, "gTexture", dxCreateTexture(icons[i][1]))
  end
end)
