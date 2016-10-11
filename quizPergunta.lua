--  ----------------------------------------------------------------------------
--  projectname:
--  filename:     quizPergunta.lua
--  description:  Contém a definição do menu do aplicação
--  authors:      Jeidsan A. da C. Pereira (jeidsanpereira@gmail.com)
--                Juana Pedreira (juanaspedreira@gmail.com)
--                Rafaela Ruchinski (rafaelaruchi@gmail.com)
--  created:      2016-10-01
--  modified:     2016-10-10
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
local alternative1
local alternative2
local alternative3
local alternative4

-- -----------------------------------------------------------------------------
-- Métodos e escopo principal da cena
-- -----------------------------------------------------------------------------
local function createBackground(backGroup)
	-- Crio o background para a cena
	background = display.newImageRect(backGroup, "images/backgroundCredits.jpg", display.contentWidth, display.contentHeight)
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
	local _HEIGHT_Alternativa = (display.contentHeight / 2) - 200
	local _WIDTH_Alternativa = (_WIDTH / 2) - 10

	-- Crio um quadro para servir de fundo à pergunta
	local questionBackground = display.newRect(questionGroup, (_WIDTH / 2) + 45, (_HEIGHT + 120) / 2, _WIDTH, _HEIGHT)

	-- Crio a pergunta da questão
	local questao = display.newText(questionGroup, quiz.ds_pergunta, (_WIDTH / 2) + 35,(_HEIGHT + 100) / 2, native.systemFont)
	questao:setFillColor(color.preto.r, color.preto.g, color.preto.b)

	-- Crio quadros para servir de fundo as imagens
	local alternativeQuestionBackground1 = display.newRect(questionGroup, (_WIDTH_Alternativa + 75) / 2, (_HEIGHT_Alternativa + 520) / 2, _WIDTH_Alternativa, _HEIGHT_Alternativa)
	local alternativeQuestionBackground2 = display.newRect(questionGroup, (_WIDTH_Alternativa + 345), (_HEIGHT_Alternativa + 520) / 2, _WIDTH_Alternativa, _HEIGHT_Alternativa)
	local alternativeQuestionBackground3 = display.newRect(questionGroup, (_WIDTH_Alternativa + 75) / 2, (_HEIGHT_Alternativa + 920) / 2, _WIDTH_Alternativa, _HEIGHT_Alternativa)
	local alternativeQuestionBackground4 = display.newRect(questionGroup, (_WIDTH_Alternativa + 345), (_HEIGHT_Alternativa + 920) / 2, _WIDTH_Alternativa, _HEIGHT_Alternativa)

	-- Sorteio a posição para a resposta certa.
	local resPositionWidth = 0--math.random(0, 2)
	local resPositionHeigth = 0--math.random(0, 2)
	local widthImg = 0

	-- Crio as alternativas da questão
	alternative1 = display.newText(questionGroup, quiz.ds_resposta, ((_WIDTH_Alternativa + 75) / 2) + resPositionWidth * (_WIDTH_Alternativa + 20), ((_HEIGHT_Alternativa + 520) / 2) + resPositionHeigth * (_HEIGHT_Alternativa + 40), native.systemFont, 44)
	alternative1:setFillColor(color.preto.r, color.preto.g, color.preto.b)
	alternative1:addEventListener("tap", quizGoodAlternative)

	alternative2 = display.newText(questionGroup, alternativas[1].ds_resposta, ((_WIDTH_Alternativa + 75) / 2) + ((resPositionWidth + 1) % 2) * (_WIDTH_Alternativa + 20), ((_HEIGHT_Alternativa + 520) / 2) + ((resPositionHeigth + 1) % 2) * (_HEIGHT_Alternativa + 40), native.systemFont, 44)
	alternative2:setFillColor(color.preto.r, color.preto.g, color.preto.b)
	alternative2:addEventListener("tap", quizBadAlternative)

	if resPositionWidth == 0 then
		resPositionWidth = 1
	else
		resPositionWidth = 0
	end

	alternative3 = display.newText(questionGroup, alternativas[2].ds_resposta, ((_WIDTH_Alternativa + 75) / 2) + resPositionWidth * (_WIDTH_Alternativa + 20), ((_HEIGHT_Alternativa + 920) / 2) + resPositionHeigth * (_HEIGHT_Alternativa + 40), native.systemFont, 44)
	alternative3:setFillColor(color.preto.r, color.preto.g, color.preto.b)
	alternative3:addEventListener("tap", quizBadAlternative)

	alternative4 = display.newText(questionGroup, alternativas[3].ds_resposta, ((_WIDTH_Alternativa + 75) / 2) + ((resPositionWidth + 1) % 2) * (_WIDTH_Alternativa + 20), ((_HEIGHT_Alternativa + 920) / 2) + ((resPositionHeigth + 1) % 2) * (_HEIGHT_Alternativa + 40), native.systemFont, 44)
	alternative4:setFillColor(color.preto.r, color.preto.g, color.preto.b)
	alternative4:addEventListener("tap", quizBadAlternative)
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
