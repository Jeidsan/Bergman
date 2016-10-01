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

-- -----------------------------------------------------------------------------
-- Métodos e escopo principal da cena
-- -----------------------------------------------------------------------------

-- Leva o usuário até a cena do Jogo
local function gotoGame()
  composer.removeScene("game")
	composer.gotoScene("game", { time=1000, effect="crossFade" })
end

-- Leva o usuário até a cena de pontuação
local function gotoHighScores()
  composer.removeScene("higscores")
	composer.gotoScene("higscores", { time=1000, effect="crossFade" })
end

-- Leva o usuário até a cena de créditos
local function gotoCredits()
  composer.gotoScene("credits", { time=1000, effect="crossFade" })
end

-- -----------------------------------------------------------------------------
-- Eventos da cena
-- -----------------------------------------------------------------------------

-- Quando a cena é criada.
function scene:create(event)
  -- Busco o grupo principal para a cena
	local sceneGroup = self.view

  -- Crio o background da cena
  local background = display.newImageRect(sceneGroup, "images/backgroundMenu.png", 1024, 768)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  -- Crio a logo go jogo
  local logo = display.newText(sceneGroup, "O Alquimista", display.contentCenterX, 175, native.systemFont, 100)
  logo:setFillColor(color.azul.r, color.azul.g, color.azul.b)

  -- Crio as opções do menu
  local btnPlay = display.newText(sceneGroup, "Novo Jogo", display.contentCenterX, 300, native.systemFont, 50)
  btnPlay:setFillColor(color.amarelo.r, color.amarelo.g, color.amarelo.b)
  btnPlay:addEventListener("tap", gotoGame)

  local btnHighScores = display.newText(sceneGroup, "Recordes", display.contentCenterX, 375, native.systemFont, 50)
  btnHighScores:setFillColor(color.verde.r, color.verde.g, color.verde.b)
  btnHighScores:addEventListener("tap", gotoHighScores)

  local btnCredits = display.newText(sceneGroup, "Créditos", display.contentCenterX, 450, native.systemFont, 50)
  btnCredits:setFillColor(color.rosa.r, color.rosa.g, color.rosa.b)
  btnCredits:addEventListener("tap", gotoCredits)

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
