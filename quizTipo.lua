--  ----------------------------------------------------------------------------
--  projectname:
--  filename:     quizTipo.lua
--  description:  Contém a definição do menu do aplicação
--  authors:      Jeidsan A. da C. Pereira (jeidsanpereira@gmail.com)
--                Juana Pedreira (juanaspedreira@gmail.com)
--                Rafaela Ruchinski (rafaelaruchi@gmail.com)
--  created:      2016-10-01
--  modified:     2016-10-01
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

local quiz = composer.getVariable("quiz");
local alternativas = composer.getVariable("alternativas")

local background
local questionGroup
local alternativeImage1
local alternativeImage2
local alternativeImage3

-- -----------------------------------------------------------------------------
-- Métodos e escopo principal da cena
-- -----------------------------------------------------------------------------
local function createBackground(backGroup)
	-- Crio o background para a cena
	background = display.newImageRect(backGroup, "images/background.png", display.contentWidth, display.contentHeight)
	background.x = display.contentCenterX
	background.y = display.contentCenterY
end

local function quizGoodAlternative(event)
	-- Se o jogador acertar a pergunta, eu somo 0 pontos ao seu score
	local score = composer.getVariable("score") + 50
	composer.setVariable("score", score)
	composer.gotoScene("game")
end

local function quizBadAlternative(event)
	-- Se o jogador errar a pergunta, ele perde score
	local energy = composer.getVariable("energy")

	if energy > 1 then
		energy = energy - 1
	else
		energy = 5
		composer.setVariable("lives", composer.getVariable("lives") - 1)
	end

	composer.setVariable("energy", energy)
	composer.gotoScene("game")
end

local function loadQuestion(backGroup)
	-- Crio um grupo para carregar os dados da questão
	questionGroup = display.newGroup()
	backGroup:insert(questionGroup)

	-- Guardo o tamanho da tela, para posicionar oc componentes
	local _HEIGHT = display.contentHeight - 630
	local _WIDTH = display.contentWidth - 80
	local _HEIGHT_Image = (display.contentHeight / 2) + 180
	local _WIDTH_Image = (_WIDTH / 3) - 10

	-- Crio um quadro para servir de fundo à pergunta
	local questionBackground = display.newRect(questionGroup, (_WIDTH / 2) + 35, (_HEIGHT + 100) / 2, _WIDTH, _HEIGHT)

	-- Crio a pergunta da questão
	local questao = display.newText(questionGroup, quiz.ds_pergunta, (_WIDTH / 2) + 35, (_HEIGHT + 100) / 2, native.systemFont)
	questao:setFillColor(color.preto.r, color.preto.g, color.preto.b)

	-- Crio quadros para servir de fundo as imagens
	local alternativeImageBackground1 = display.newRect(questionGroup, (_WIDTH_Image + 75) / 2, (_HEIGHT_Image + 320) / 2, _WIDTH_Image, _HEIGHT_Image)
	local alternativeImageBackground2 = display.newRect(questionGroup, (_WIDTH_Image + 245), (_HEIGHT_Image + 320) / 2, _WIDTH_Image, _HEIGHT_Image)
	local alternativeImageBackground3 = display.newRect(questionGroup, (_WIDTH_Image + 650), (_HEIGHT_Image + 320) / 2, _WIDTH_Image, _HEIGHT_Image)

	-- Sorteio a posição para a resposta certa.
	local resPosition = math.random(0, 2)
	local widthImg = 0

	-- Ajusta possição da imagem
	if resPosition == 0 then
		widthImg = 340
	elseif resPosition == 1 then
		widthImg = 170
	end

	-- Crio as imagens da questão
	alternativeImage1 = display.newImageRect(questionGroup, "images/" .. quiz.nm_imagem, 350, 350)
	alternativeImage1.anchorX = 0
	alternativeImage1.anchorY = 0
	alternativeImage1.x = alternativeImageBackground1.x + (resPosition *  (alternativeImageBackground1.x)) + 165 - widthImg
	alternativeImage1.y = 255
	alternativeImage1:addEventListener("tap", quizGoodAlternative)

 	-- Ajusta possição da imagem
	if resPosition == 0 then
		widthImg = 720
	elseif resPosition == 2 then
		widthImg = 1440
	else
		widthImg = 0
	end

	alternativeImage2 = display.newImageRect(questionGroup, "images/" .. alternativas[1].nm_imagem, 350, 350)
	alternativeImage2.anchorX = 0
	alternativeImage2.anchorY = 0
	alternativeImage2.x = alternativeImageBackground2.x - (((resPosition + 1) % 3) * (alternativeImageBackground2.x / 2)) + 860 - widthImg
	alternativeImage2.y = 255
	alternativeImage2:addEventListener("tap", quizBadAlternative)

	-- Ajusta possição da imagem
	if resPosition == 1 then
		widthImg = 1850
	elseif resPosition == 2 then
		widthImg = 925
	else
		widthImg = 0
	end

	alternativeImage3 = display.newImageRect(questionGroup, "images/" .. alternativas[2].nm_imagem, 350, 350)
	alternativeImage3.anchorX = 0
	alternativeImage3.anchorY = 0
	alternativeImage3.x = alternativeImageBackground3.x - (((resPosition + 2) % 3) * (alternativeImageBackground3.x / 2)) + 860 - widthImg
	alternativeImage3.y = 255
	alternativeImage3:addEventListener("tap", quizBadAlternative)
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

	-- Carrega a questão e as alternativas
	loadQuestion(sceneGroup)
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
