--  ----------------------------------------------------------------------------
--  projectname:
--  filename:     credits.lua
--  description:  Contém a definição dos creditos do aplicação
--  authors:      Jeidsan A. da C. Pereira (jeidsanpereira@gmail.com)
--                Juana Pedreira (juanaspedreira@gmail.com)
--                Rafaela Ruchinski (rafaelaruchi@gmail.com)
--  created:      2016-09-24
--  modified:     2016-09-24
--  ----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Configuração inicial para a cena
-- -----------------------------------------------------------------------------

-- Carrego o Composer para tratar as cenas da aplicação
local composer = require("composer")

-- Crio uma nova cena
local scene = composer.newScene()

-- -----------------------------------------------------------------------------
-- Variáveis da cena
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Métodos e escopo principal da cena
-- -----------------------------------------------------------------------------

-- Leva o usuário até o menu principal
local function gotoMenu()
  composer.gotoScene("menu")
end

-- -----------------------------------------------------------------------------
-- Eventos da cena
-- -----------------------------------------------------------------------------

-- Quando a cena é criada.
function scene:create(event)
  -- Busco o grupo principal para a cena
	local sceneGroup = self.view

  -- Crio o background da cena
  local background = display.newImageRect(sceneGroup, "images/backgroundCredits.png", 1024, 768)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  -- Crio o título
  local logo = display.newText(sceneGroup, "O Alquimista", display.contentCenterX, 175, native.systemFont, 100)
  logo:setFillColor(color.azul.r, color.azul.g, color.azul.b)

  -- Coloco o nome dos autores
  local txtJeidsan = display.newText(sceneGroup, "Jeidsan Pereira", display.contentCenterX, 300, native.systemFont, 50)
  txtJeidsan:setFillColor(color.vermelho.r, color.vermelho.g, color.vermelho.b)

  local txtJuana = display.newText(sceneGroup, "Juana Pedreira", display.contentCenterX, 375, native.systemFont, 50)
  txtJuana:setFillColor(color.verde.r, color.verde.g, color.verde.b)

  local txtRafaela = display.newText(sceneGroup, "Rafaela Ruchinski", display.contentCenterX, 450, native.systemFont, 50)
  txtRafaela:setFillColor(color.rosa.r, color.rosa.g, color.rosa.b)

  -- Adiciono um botão para fechar a cena de créditos
  local btnClose = display.newImageRect(sceneGroup, "images/btnClose.png", 40, 40)
  btnClose.x = display.contentCenterX
  btnClose.y = display.contentHeight - 100
  btnClose:addEventListener("tap", gotoMenu)
end

-- Quando a cena está pronta para ser mostrada (phase will) e quando é mostrada (phase did).
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then

	end
end

-- Quando a cena está prestes a ser escondida (phase will) e assim que é escondida (phase did).
function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then

	end
end

-- Quando a cena é destruida
function scene:destroy(event)
	local sceneGroup = self.view
end

-- -----------------------------------------------------------------------------
-- Adicionando os escutadores à cena
-- -----------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-- -----------------------------------------------------------------------------

-- Retorno a cena
return scene
