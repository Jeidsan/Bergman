--  ----------------------------------------------------------------------------
--  projectname:
--  filename:     quizImagem.lua
--  description:  Contém a definição do menu do aplicação
--  authors:      Jeidsan A. da C. Pereira (jeidsanpereira@gmail.com)
--                Juana Pedreira (juanaspedreira@gmail.com)
--                Rafaela Ruchinski (rafaelaruchi@gmail.com)
--  created:      2016-10-01
--  modified:     2016-10-07
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
local questionImage

-- -----------------------------------------------------------------------------
-- Métodos e escopo principal da cena
-- -----------------------------------------------------------------------------

local function createBackground(backGroup)
	-- Crio o background para a cena
	background = display.newImageRect(backGroup, "images/backgroundCredits.png", 1024, 768)
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
	local _HEIGHT = display.contentHeight - 300

	-- Crio um quadro para servir de fundo à imagem
	local questionImageBackground = display.newRect(questionGroup, (_HEIGHT + 200) / 2, (_HEIGHT + 300) / 2, _HEIGHT, _HEIGHT)

	-- Crio a imagem da questão
	questionImage = display.newImageRect(questionGroup, "images/" .. quiz.nm_imagem, _HEIGHT - 10, _HEIGHT)
	questionImage.anchorX = 0
	questionImage.anchorY = 0
	questionImage.x = 100
	questionImage.y = 150

	-- Verifico o tamanho e a posição para as caixas com as alternativas
	local boxHeight = (_HEIGHT - 60) / 4
	local boxWidth = display.contentWidth - _HEIGHT - 300
	local boxPositionX = (_HEIGHT + (boxWidth / 2) + 200)
	local boxPositionY = 150 + (boxHeight / 2)
	local boxIncrement = boxHeight + 20

	-- Carrego as alternativas
	local altBox1 = display.newRect(questionGroup, boxPositionX, boxPositionY + 0 * boxIncrement, boxWidth, boxHeight)
	local altBox2 = display.newRect(questionGroup, boxPositionX, boxPositionY + 1 * boxIncrement, boxWidth, boxHeight)
	local altBox3 = display.newRect(questionGroup, boxPositionX, boxPositionY + 2 * boxIncrement, boxWidth, boxHeight)
	local altBox4 = display.newRect(questionGroup, boxPositionX, boxPositionY + 3 * boxIncrement, boxWidth, boxHeight)

	-- Sorteio a posição para a resposta certa.
	local resPosition = math.random(0, 3)

	-- Crio os textos com as alternativas
	local altTextResp = display.newText(questionGroup, quiz.ds_resposta, boxPositionX, boxPositionY + resPosition * boxIncrement, native.systemFont, 44)
	altTextResp:setFillColor(color.preto.r, color.preto.g, color.preto.b)
	altTextResp:addEventListener("tap", quizGoodAlternative)

	local altTextErr1 = display.newText(questionGroup, alternativas[1].ds_resposta, boxPositionX, boxPositionY + ((resPosition + 1) % 4) * boxIncrement, native.systemFont, 44)
	altTextErr1:setFillColor(color.preto.r, color.preto.g, color.preto.b)
	altTextErr1:addEventListener("tap", quizBadAlternative)

	local altTextErr2 = display.newText(questionGroup, alternativas[2].ds_resposta, boxPositionX, boxPositionY + ((resPosition + 2) % 4) * boxIncrement, native.systemFont, 44)
	altTextErr2:setFillColor(color.preto.r, color.preto.g, color.preto.b)
	altTextErr2:addEventListener("tap", quizBadAlternative)

	local altTextErr3 = display.newText(questionGroup, alternativas[3].ds_resposta, boxPositionX, boxPositionY + ((resPosition + 3) % 4) * boxIncrement, native.systemFont, 44)
	altTextErr3:setFillColor(color.preto.r, color.preto.g, color.preto.b)
	altTextErr3:addEventListener("tap", quizBadAlternative)
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
