--  ----------------------------------------------------------------------------
--  projectname:
--  filename:     quizPergunta.lua
--  description:  Contém a definição do menu do aplicação
--  authors:      Jeidsan A. da C. Pereira (jeidsanpereira@gmail.com)
--                Juana Pedreira (juanaspedreira@gmail.com)
--                Rafaela Ruchinski (rafaelaruchi@gmail.com)
--  created:      2016-10-01
--  modified:     2016-11-29
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
local function createBackground(sceneGroup)
	-- Crio o background da cena
  background = display.newImageRect(sceneGroup, "images/background.png", display.contentWidth, display.contentHeight)
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

	-- Guardo o tamanho da tela, para posicionar os componentes
	local _HEIGHT = (display.contentHeight - 100) / 3
	local _WIDTH = (display.contentWidth - 150) / 2

	-- Crio um quadro para servir de fundo à pergunta
	local questionBackground = display.newRect(questionGroup, 50, 100, 2 * _WIDTH + 50, _HEIGHT)
  questionBackground.anchorX = 0
  questionBackground.anchorY = 0.5
  questionBackground.alpha = 0.8

	-- Crio a pergunta da questão
	local questao = display.newText(questionGroup, quiz.ds_pergunta, display.contentCenterX, 100, native.systemFont)
  questao.anchorX = 0.5
  questao.anchorY = 0.5
	questao:setFillColor(color.preto.r, color.preto.g, color.preto.b)

	-- Crio quadros para servir de fundo as imagens
	local alternativeQuestionBackground1 = display.newRect(questionGroup, 50, _HEIGHT + 50, _WIDTH, _HEIGHT)
  alternativeQuestionBackground1.anchorX = 0
  alternativeQuestionBackground1.anchorY = 0
  alternativeQuestionBackground1.alpha = 0.8

	local alternativeQuestionBackground2 = display.newRect(questionGroup, _WIDTH + 100 , _HEIGHT + 50, _WIDTH, _HEIGHT)
  alternativeQuestionBackground2.anchorX = 0
  alternativeQuestionBackground2.anchorY = 0
  alternativeQuestionBackground2.alpha = 0.8

	local alternativeQuestionBackground3 = display.newRect(questionGroup, 50, (2 * _HEIGHT) + 100, _WIDTH, _HEIGHT)
  alternativeQuestionBackground3.anchorX = 0
  alternativeQuestionBackground3.anchorY = 0
  alternativeQuestionBackground3.alpha = 0.8

  local alternativeQuestionBackground4 = display.newRect(questionGroup, _WIDTH + 100, (2 * _HEIGHT) + 100, _WIDTH, _HEIGHT)
  alternativeQuestionBackground4.anchorX = 0
  alternativeQuestionBackground4.anchorY = 0
  alternativeQuestionBackground4.alpha = 0.8

  local option = math.random(1, 4)
  if option == 1 then
    alternative1 = display.newText(questionGroup, quiz.ds_resposta, (0.5 * _WIDTH) + 50, (1.5 * _HEIGHT) + 50, native.systemFont, 44)
    alternative1:addEventListener("tap", quizGoodAlternative)
    alternative2 = display.newText(questionGroup, alternativas[1].ds_resposta, (1.5 * _WIDTH) + 100, (1.5 * _HEIGHT) + 50, native.systemFont, 44)
    alternative2:addEventListener("tap", quizBadAlternative)
    alternative3 = display.newText(questionGroup, alternativas[2].ds_resposta, (0.5 * _WIDTH) + 50, (2.5 * _HEIGHT) + 100, native.systemFont, 44)
    alternative3:addEventListener("tap", quizBadAlternative)
    alternative4 = display.newText(questionGroup, alternativas[3].ds_resposta, (1.5 * _WIDTH) + 100, (2.5 * _HEIGHT) + 100, native.systemFont, 44)
    alternative4:addEventListener("tap", quizBadAlternative)
  elseif option == 2 then
    alternative1 = display.newText(questionGroup, alternativas[1].ds_resposta, (0.5 * _WIDTH) + 50, (1.5 * _HEIGHT) + 50, native.systemFont, 44)
    alternative1:addEventListener("tap", quizBadAlternative)
    alternative2 = display.newText(questionGroup, quiz.ds_resposta, (1.5 * _WIDTH) + 100, (1.5 * _HEIGHT) + 50, native.systemFont, 44)
    alternative2:addEventListener("tap", quizGoodAlternative)
    alternative3 = display.newText(questionGroup, alternativas[2].ds_resposta, (0.5 * _WIDTH) + 50, (2.5 * _HEIGHT) + 100, native.systemFont, 44)
    alternative3:addEventListener("tap", quizBadAlternative)
    alternative4 = display.newText(questionGroup, alternativas[3].ds_resposta, (1.5 * _WIDTH) + 100, (2.5 * _HEIGHT) + 100, native.systemFont, 44)
    alternative4:addEventListener("tap", quizBadAlternative)
  elseif option == 3 then
    alternative1 = display.newText(questionGroup, alternativas[1].ds_resposta, (0.5 * _WIDTH) + 50, (1.5 * _HEIGHT) + 50, native.systemFont, 44)
    alternative1:addEventListener("tap", quizBadAlternative)
    alternative2 = display.newText(questionGroup, alternativas[2].ds_resposta, (1.5 * _WIDTH) + 100, (1.5 * _HEIGHT) + 50, native.systemFont, 44)
    alternative2:addEventListener("tap", quizBadAlternative)
    alternative3 = display.newText(questionGroup, quiz.ds_resposta, (0.5 * _WIDTH) + 50, (2.5 * _HEIGHT) + 100, native.systemFont, 44)
    alternative3:addEventListener("tap", quizGoodAlternative)
    alternative4 = display.newText(questionGroup, alternativas[3].ds_resposta, (1.5 * _WIDTH) + 100, (2.5 * _HEIGHT) + 100, native.systemFont, 44)
    alternative4:addEventListener("tap", quizBadAlternative)
  else
    alternative1 = display.newText(questionGroup, alternativas[1].ds_resposta, (0.5 * _WIDTH) + 50, (1.5 * _HEIGHT) + 50, native.systemFont, 44)
    alternative1:addEventListener("tap", quizBadAlternative)
    alternative2 = display.newText(questionGroup, alternativas[2].ds_resposta, (1.5 * _WIDTH) + 100, (1.5 * _HEIGHT) + 50, native.systemFont, 44)
    alternative2:addEventListener("tap", quizBadAlternative)
    alternative3 = display.newText(questionGroup, alternativas[3].ds_resposta, (0.5 * _WIDTH) + 50, (2.5 * _HEIGHT) + 100, native.systemFont, 44)
    alternative3:addEventListener("tap", quizBadAlternative)
    alternative4 = display.newText(questionGroup, quiz.ds_resposta, (1.5 * _WIDTH) + 100, (2.5 * _HEIGHT) + 100, native.systemFont, 44)
    alternative4:addEventListener("tap", quizGoodAlternative)
  end

  alternative1:setFillColor(color.preto.r, color.preto.g, color.preto.b)
	alternative2:setFillColor(color.preto.r, color.preto.g, color.preto.b)
	alternative3:setFillColor(color.preto.r, color.preto.g, color.preto.b)
	alternative4:setFillColor(color.preto.r, color.preto.g, color.preto.b)
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
