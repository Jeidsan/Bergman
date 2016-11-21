--  ----------------------------------------------------------------------------
--  projectname:
--  filename:     menu.lua
--  description:  Contém a definição do menu do aplicação
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
-- Textos
local controlGroup
local txtScores
local sheetInfo = require("spritesheet")
local imgSheet = graphics.newImageSheet("images/spritesheet.png", sheetInfo:getSheet())

-- -----------------------------------------------------------------------------
-- Métodos e escopo principal da cena
-- -----------------------------------------------------------------------------

local function createBackground(backGroup)
	-- Crio o background para a cena
	background = display.newImageRect(backGroup, "images/backgroundGameOver.jpg", display.contentWidth, display.contentHeight)
	background.x = display.contentCenterX
	background.y = display.contentCenterY
end

local function gotoGame()
  composer.removeScene("game")
	composer.gotoScene("game", { time=1000, effect="crossFade" })
end

local function gotoMenu()
  composer.gotoScene("menu")
end

-- Cria o grupo de controles
local function createControl(group)
  -- Cria o botão fechar
  local btnClose = display.newImageRect(group, imgSheet, sheetInfo:getFrameIndex("btnClose"), 64, 64)
  btnClose.x = display.contentCenterX
  btnClose.y = display.contentHeight - 80
  btnClose:addEventListener("tap", gotoMenu)
end

local function adjustText(text)
  local qtyZeros = 8 - #text

  for i=1, qtyZeros do
    text = "0" .. text
  end

  return text
end

-- Cria o painel de informações do jogo
local function createInfo(infoGroup)
  -- determino a largura dos textos
  local textWidth = (display.contentWidth / 2)
  local textHeight = (display.contentHeight / 2) + 120

  -- Crio o texto para informações sobre a pontos
  txtScores = display.newText(infoGroup, adjustText(""..composer.getVariable("score")), textWidth, textHeight, native.systemFont, 150)
  txtScores:setFillColor(color.preto.r, color.preto.g, color.preto.b)

end
-- -----------------------------------------------------------------------------
-- Eventos da cena
-- -----------------------------------------------------------------------------

-- Quando a cena é criada.
function scene:create(event)
  -- Busco o grupo principal para a cena
  local sceneGroup = self.view

  -- Crio o background
  createBackground(sceneGroup)

	-- Crio o grupo de Controles e adiciono ao grupo da cena
  controlGroup = display.newGroup()
  sceneGroup:insert(controlGroup)

	-- Crio os Controles
  createControl(controlGroup)

  -- Carrega a pontuação total
  createInfo(sceneGroup)
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
