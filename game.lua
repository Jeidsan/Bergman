--  ----------------------------------------------------------------------------
--  projectname:
--  filename:     game.lua
--  description:  Contém a definição do loop do jogo
--  authors:      Jeidsan A. da C. Pereira (jeidsanpereira@gmail.com)
--                Juana Pedreira (juanaspedreira@gmail.com)
--                Rafaela Ruchinski (rafaelaruchi@gmail.com)
--  created:      2016-09-25
--  modified:     2016-10-07
--  ----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Configuração inicial para a cena
-- -----------------------------------------------------------------------------

-- Carrego o Composer para tratar as cenas da aplicação
local composer = require("composer")

-- Crio uma nova cena
local scene = composer.newScene()

-- Carrego o motor de física
local physics = require("physics")

-- Seto a gravidade como zero para que os objetos não caiam
physics.start()
physics.setGravity(0, 0)

-- -----------------------------------------------------------------------------
-- Variáveis da cena
-- -----------------------------------------------------------------------------

-- Timers
local gameLoopTimer

-- Imagens
local background
local sheetInfo = require("spritesheet")
local imgSheet = graphics.newImageSheet("images/spritesheet.png", sheetInfo:getSheet())
local imgLives
local imgScore
local imgMunition

-- Textos
local txtLives
local txtScore
local txtMunition

-- Controles
local lives     =   5 -- Inicio o jogo com 5 vidas
local munition  =   100 -- inicio o jogo com 100 jatos
local score     =   0 -- inicio o jogo sem pontos

-- Player
local player

-- Grupos de objetos
local backGroup
local infoGroup
local gameGroup
local controlGroup

-- Tabela para carregar as questões
local questionTable = {}

-- Musica

-- Métodos e escopo principal da cena
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------

-- Cria o plano de fundo da cena e adiciona uma movimentação
local function createBackground(backGroup)
  -- Crio o background para o jogo
  background = display.newImageRect(backGroup, "images/backgroundGame.jpg", 2955, 768)

  -- Posiciono o background
  background.x = display.contentCenterY
  background.y = display.contentCenterY
end

local function loadQuestionTable()
  -- Carrego a biblioteca JSON para decodificao os dados
  local json = require("json")

  -- Defino o caminho do arquivo de dados
  local dataPath = system.pathForFile("data/data.json", system.ResourceDirectory)

  -- Carrego o arquivo de dados na variável file (errorString irá indicar se houve erro)
  local file, errorString = io.open(dataPath, "r")

  -- Carrego os dados na tabela
  if not file then
    -- TODO: Jeidsan: Tratar o caso de erro ao carregar arquivo
  else
    -- Carrego os dados do arquivo
    local contents = file:read("*a")

    -- Converto os dados de JSON para o formato de tabela de Lua
    dataTable = json.decode(contents)

    -- TODO: Jeidsan: Tratar caso em que a tabela não contenha dados
  end
end

-- Atualiza os textos de pontuação, munição e vidas
local function updateText()
  txtLives.text = lives
  txtMunition.text = munition
  txtScore.text = score
end

-- Cria o painel de informações do jogo
local function createInfo(infoGroup)
  -- Crio a imagem para informação das vidas
  imgLives = display.newImageRect(infoGroup, imgSheet, sheetInfo:getFrameIndex("lives"), 64, 64)
  imgLives.x = 64
  imgLives.y = 100

  -- Crio o texto para informações sobre a vidas
  txtLives = display.newText(infoGroup, lives, 128, 100, native.systemFont, 44)
  txtLives.anchorX = 0
  txtLives:setFillColor(color.vermelho.r, color.vermelho.g, color.vermelho.b)

  -- Crio a imagem para informação da munição
  imgMunition = display.newImageRect(infoGroup, imgSheet, sheetInfo:getFrameIndex("munition-stock"), 40, 64)
  imgMunition.x = 400
  imgMunition.y = 100

  -- Crio o texto para informações sobre a munições
  txtMunition = display.newText(infoGroup, munition, 464, 100, native.systemFont, 44)
  txtMunition.anchorX = 0
  txtMunition:setFillColor(color.vermelho.r, color.vermelho.g, color.vermelho.b)

  -- Crio a imagem para informação dos pontos
  imgScore = display.newImageRect(infoGroup, imgSheet, sheetInfo:getFrameIndex("score"), 40, 64)
  imgScore.x = 740
  imgScore.y = 100

  -- Crio o texto para informações sobre a pontos
  txtScore = display.newText(infoGroup, score, 804, 100, native.systemFont, 44)
  txtScore.anchorX = 0
  txtScore:setFillColor(color.vermelho.r, color.vermelho.g, color.vermelho.b)
end

-- Cria o grupo de controles
local function createControl(group)
  -- Cria o botão de pulo
  local btnUp = display.newImageRect(group, "images/btnUp.png", 40, 40)
  btnUp.x = 64
  btnUp.y = display.contentHeight - 100

  -- Cria o botão de atirar
  local btnFight = display.newImageRect(group, "images/btnRight.png", 40, 40)
  btnFight.x = display.contentWidth - 64
  btnFight.y = display.contentHeight - 100

  -- Cria o botão fechar
  local btnClose = display.newImageRect(group, "images/btnClose.png", 40, 40)
  btnClose.x = display.contentCenterX
  btnClose.y = display.contentHeight - 100
end

local function createPlayer(group)
  player.type = "player"
end

-- Cria os objetos que serão bônus
local function createBonus()
  -- Sorteio o tipo obstáculos
  local nrBonus = math.random(1, 18)

  -- Sorteio a posição
  local position = math.random(1, 2) -- 1 = cima;  2 = baixo

  -- Crio o objeto
  local bonus = display.newImageRect(infoGroup, imgSheet, nrBonus, 100, 100)

  -- Posiciono o objeto
  bonus.x = display.contentWidth + 100 -- Crio fora da tela para dar o efeito
  if position == 1 then
    bonus.y = 250
  else
    bonus.y = display.contentHeight - 250
  end

  -- Defino o tipo do objeto e a quantidade de pontos que ele vale
  bonus.type = "bonus"
  bonus.points = 10

  -- Submeto o objeto à ação da física
  physics.addBody(bonus, "dynamic")

  -- Impulsiono o obstáculo em direção ao jogador
  transition.to(bonus, { x = -100, y = bonus.y, time = 6000, onComplete = function() display.remove(bonus) end})
end

-- Cria os obstáculos para o jogo
local function createObstacle()
  -- Sorteio o tipo obstáculos
  local nrObstacle = math.random(30, 32)

  -- Sorteio a posição
  local position = math.random(1, 2) -- 1 = cima;  2 = baixo

  -- Crio o objeto
  local obstacle = display.newImageRect(infoGroup, imgSheet, nrObstacle, 100, 100)

  -- Posiciono o objeto
  obstacle.x = display.contentWidth + 100 -- Crio fora da tela para dar o efeito
  if position == 1 then
    obstacle.y = 250
  else
    obstacle.y = display.contentHeight - 250
  end

  -- Defino o tipo do objeto e a quantidade de pontos que ele vale
  obstacle.type = "obstacle"
  obstacle.points = 100

  -- Submeto o objeto à ação da física
  physics.addBody(obstacle, "dynamic")

  -- Impulsiono o obstáculo em direção ao jogador
  transition.to(obstacle, { x = -100, y = obstacle.y, time = 6000, onComplete = function() display.remove(obstacle) end})
end

-- Cria as questões para o jogo
local function createQuestion()
  -- Sorteio o tipo obstáculos
  local nrQuestion = math.random(33, 36)

  -- Sorteio a posição
  local position = math.random(1, 2) -- 1 = cima;  2 = baixo

  -- Crio o objeto
  local question = display.newImageRect(infoGroup, imgSheet, nrQuestion, 100, 100)

  -- Posiciono o objeto
  question.x = display.contentWidth + 100 -- Crio fora da tela para dar o efeito
  if position == 1 then
    question.y = 250
  else
    question.y = display.contentHeight - 250
  end

  -- Defino o tipo do objeto e a quantidade de pontos que ele vale
  question.type = "question"
  question.points = 1000

  -- Submeto o objeto à ação da física
  physics.addBody(question, "dynamic")

  -- Impulsiono o obstáculo em direção ao jogador
  transition.to(question, { x = -100, y = question.y, time = 6000, onComplete = function() display.remove(question) end})
end

-- Cria os tiros para o jogo
local function createShot()
end

-- Trata a colisão entre objetos
local function onCollision(event)
end

-- Implementa o loop do jogo
local function gameLoop()
  -- Sorteio o objeto que será criado
  local objectType = math.random(1, 3)

  if objectType == 1 then
    createObstacle()
  elseif objectType == 2 then
    createBonus()
  else
    createQuestion()
  end
end

-- -----------------------------------------------------------------------------
-- Eventos da cena
-- -----------------------------------------------------------------------------

-- Quando a cena é criada.
function scene:create(event)
  -- Busco o grupo principal para a cena
	local sceneGroup = self.view

  -- Pauso a física temporareamente
  physics.pause()

  -- Crio o grupo de background e adiciono ao grupo da cena
  backGroup = display.newGroup()
  sceneGroup:insert(backGroup)

  -- Crio o background para a cena
  createBackground(backGroup)

  -- Crio o grupo do jogo e adiciono ao grupo da cena
  gameGroup = display.newGroup()
  sceneGroup:insert(gameGroup)

  -- Crio o grupo de informações e adiciono ao grupo da cena
  infoGroup = display.newGroup()
  sceneGroup:insert(infoGroup)

  -- Crio as informações na tabela
  createInfo(infoGroup)

  -- Crio o grupo de Controles e adiciono ao grupo da cena
  controlGroup = display.newGroup()
  sceneGroup:insert(controlGroup)

  -- Crio os Controles
  createControl(controlGroup)
end

-- Quando a cena está pronta para ser mostrada (phase will) e quando é mostrada (phase did).
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
    -- Reinicio o motor de física
    physics.start()

    -- Programo o loop do jogo para executar a cada 500ms
    gameLoopTimer = timer.performWithDelay(2500, gameLoop, 0)
	end
end

-- Quando a cena está prestes a ser escondida (phase will) e assim que é escondida (phase did).
function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
    -- Paro os temporizadores
		timer.cancel(gameLoopTimer)

	elseif ( phase == "did" ) then
    -- Removo a detecção de colisões
    --Runtime:removeEventListener("colision", onCollision)

    -- Pauso o motor de física
    physics.pause()
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
