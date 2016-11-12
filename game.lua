--  ----------------------------------------------------------------------------
--  projectname:
--  filename:     game.lua
--  description:  Contém a definição do loop do jogo
--  authors:      Jeidsan A. da C. Pereira (jeidsanpereira@gmail.com)
--                Juana Pedreira (juanaspedreira@gmail.com)
--                Rafaela Ruchinski (rafaelaruchi@gmail.com)
--  created:      2016-09-25
--  modified:     2016-10-10
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
local gamer1
local gamer2
local gamer3
local nrGamer = 1
local sheetInfo = require("spritesheet")
local imgSheet = graphics.newImageSheet("images/spritesheet.png", sheetInfo:getSheet())
local imgLives
local imgScore
local imgEnergy

-- Textos
local txtLives
local txtScore
local txtEnergy

-- Grupos de objetos
local backGroup
local infoGroup
local gameGroup
local gamerGroup
local controlGroup

-- Timers
local gameLoopTimer
local gamerLoopTimer

-- Tabela para carregar as questões
local questionTable = {}

-- Variável para informar se o jogo está pausado.
local gamePaused = true

-- Musica

-- -----------------------------------------------------------------------------
-- Métodos e escopo principal da cena
-- -----------------------------------------------------------------------------

-- Seto ps parâmetros iniciais
composer.setVariable("lives", 5)
composer.setVariable("score", 0)
composer.setVariable("energy", 5)

-- Cria o plano de fundo da cena e adiciona uma movimentação
local function createBackground(group)
  -- Crio o background para o jogo e posiciono-o
  background = display.newImageRect(group, "images/backgroundGame.jpg", 2955, 768)
  background.x = display.contentCenterY
  background.y = display.contentCenterY
end

-- Controla o efeito do personagem correndo
local function gamerLoop()
  if nrGamer == 1 then
    gamer1.isVisible = true
    gamer2.isVisible = false
    gamer3.isVisible = false
    nrGamer = 2
  elseif nrGamer == 2 then
    gamer1.isVisible = false
    gamer2.isVisible = true
    gamer3.isVisible = false
    nrGamer = 3
  else
    gamer1.isVisible = false
    gamer2.isVisible = false
    gamer3.isVisible = true
    nrGamer = 1
  end
end

-- Cria o jogador e trata a sua movimentação
local function createGamer(group)

  -- Crio o grupo para o jogador
  gamer1 = display.newImageRect(group, imgSheet, sheetInfo:getFrameIndex("gamer0"), 150, 150)
  gamer1.x = 150
  gamer1.y = display.contentHeight - 275

  gamer2 = display.newImageRect(group, imgSheet, sheetInfo:getFrameIndex("gamer1"), 150, 150)
  gamer2.x = 150
  gamer2.y = display.contentHeight - 275

  gamer3 = display.newImageRect(group, imgSheet, sheetInfo:getFrameIndex("gamer2"), 150, 150)
  gamer3.x = 150
  gamer3.y = display.contentHeight - 275

  -- Informo que o gamer é do tipo gamer
  gamer1.type = "gamer"

  -- Adiciono-o ao motor de física
  physics.addBody(gamer1, "static")
  physics.addBody(gamer2, "static")
  physics.addBody(gamer3, "static")
end

local function up()
  gamer1.y = 250
  gamer2.y = 250
  gamer3.y = 250
end

local function down()
  gamer1.y = display.contentHeight - 275
  gamer2.y = display.contentHeight - 275
  gamer3.y = display.contentHeight - 275
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
    questionTable = json.decode(contents)

    -- TODO: Jeidsan: Tratar caso em que a tabela não contenha dados
  end
end

local function adjustText(text)
  local qtyZeros = 8 - #text

  for i=1, qtyZeros do
    text = "0" .. text
  end

  return text
end

-- Atualiza os textos de pontuação, munição e vidas
local function updateText()
  txtLives.text = composer.getVariable("lives")
  txtEnergy.text = (composer.getVariable("energy") / 5) * 100 .. "%"
  txtScore.text = adjustText(""..composer.getVariable("score"))
end

-- Cria o painel de informações do jogo
local function createInfo(infoGroup)
  -- determino a largura dos textos
  local textWidth = (display.contentWidth / 3) - 164

  -- Crio a imagem para informação das vidas
  imgLives = display.newImageRect(infoGroup, imgSheet, sheetInfo:getFrameIndex("lives"), sheetInfo:getWidth(sheetInfo:getFrameIndex("lives")), sheetInfo:getHeight(sheetInfo:getFrameIndex("lives")))
  imgLives.x = 100
  imgLives.y = 100

  -- Crio o texto para informações sobre a vidas
  txtLives = display.newText(infoGroup, composer.getVariable("lives") , 184, 100, native.systemFont, 44)
  txtLives.anchorX = 0
  txtLives:setFillColor(color.vermelho.r, color.vermelho.g, color.vermelho.b)

  -- Crio a imagem para informação da munição
  imgEnergy = display.newImageRect(infoGroup, imgSheet, sheetInfo:getFrameIndex("energy"), sheetInfo:getWidth(sheetInfo:getFrameIndex("energy")), sheetInfo:getHeight(sheetInfo:getFrameIndex("energy")))
  imgEnergy.x = 204 + textWidth
  imgEnergy.y = 100

  -- Crio o texto para informações sobre a munições
  txtEnergy = display.newText(infoGroup, (composer.getVariable("energy") / 5) * 100 .. "%" , 288 + textWidth, 100, native.systemFont, 44)
  txtEnergy.anchorX = 0
  txtEnergy:setFillColor(color.vermelho.r, color.vermelho.g, color.vermelho.b)

  -- Crio a imagem para informação dos pontos
  imgScore = display.newImageRect(infoGroup, imgSheet, sheetInfo:getFrameIndex("score"), sheetInfo:getWidth(sheetInfo:getFrameIndex("score")), sheetInfo:getHeight(sheetInfo:getFrameIndex("score")))
  imgScore.x = 308 + (2 * textWidth)
  imgScore.y = 100

  -- Crio o texto para informações sobre a pontos
  txtScore = display.newText(infoGroup, composer.getVariable("score"), 392 + (2 * textWidth), 100, native.systemFont, 44)
  txtScore.anchorX = 0
  txtScore:setFillColor(color.vermelho.r, color.vermelho.g, color.vermelho.b)
end

local function gotoMenu()
  composer.gotoScene("menu")
end

-- Cria o grupo de controles
local function createControl(group)
  -- Cria o botão de pulo
  local btnUp = display.newImageRect(group, imgSheet, sheetInfo:getFrameIndex("btnUp"), 64, 64)
  btnUp.x = 100
  btnUp.y = display.contentHeight - 100
  btnUp:addEventListener("tap", up)

  -- Cria o botão de atirar
  local btnDown = display.newImageRect(group, imgSheet, sheetInfo:getFrameIndex("btnDown"), 64, 64)
  btnDown.x = display.contentWidth - 100
  btnDown.y = display.contentHeight - 100
  btnDown:addEventListener("tap", down)

  -- Cria o botão fechar
  local btnClose = display.newImageRect(group, imgSheet, sheetInfo:getFrameIndex("btnClose"), 64, 64)
  btnClose.x = display.contentCenterX
  btnClose.y = display.contentHeight - 100
  btnClose:addEventListener("tap", gotoMenu)
end

-- Cria os objetos que serão bônus
local function createBonus()
  -- Sorteio a imagem que será exibida
  local nrBonus = math.random(1, 13)

  -- Sorteio a posição
  local position = math.random(1, 2) -- 1 = cima;  2 = baixo

  -- Crio o objeto
  local bonus = display.newImageRect(gameGroup, imgSheet, nrBonus, sheetInfo:getWidth(nrBonus) * 1.3, sheetInfo:getHeight(nrBonus) * 1.3)

  -- Posiciono o objeto
  bonus.x = display.contentWidth + 100 -- Crio fora da tela para dar o efeito
  if position == 1 then
    bonus.y = 250
  else
    bonus.y = display.contentHeight - 250
  end

  -- Defino o tipo do objeto e a quantidade de pontos que ele vale
  bonus.type = "bonus"

  -- Submeto o objeto à ação da física
  physics.addBody(bonus, "dynamic")

  -- Impulsiono o obstáculo em direção ao jogador
  transition.to(bonus, { x = -100, y = bonus.y, time = 4000, onComplete = function() display.remove(bonus) end})
end

-- Cria os obstáculos para o jogo
local function createObstacle()
  -- Sorteio o tipo obstáculos
  local nrObstacle = math.random(22, 24)

  -- Sorteio a posição
  local position = math.random(1, 2) -- 1 = cima;  2 = baixo

  -- Crio o objeto
  local obstacle = display.newImageRect(infoGroup, imgSheet, nrObstacle, sheetInfo:getWidth(nrObstacle) * 1.3, sheetInfo:getHeight(nrObstacle) * 1.3)

  -- Posiciono o objeto
  obstacle.x = display.contentWidth + 100 -- Crio fora da tela para dar o efeito
  if position == 1 then
    obstacle.y = 250
  else
    obstacle.y = display.contentHeight - 250
  end

  -- Defino o tipo do objeto e a quantidade de pontos que ele vale
  obstacle.type = "obstacle"

  -- Submeto o objeto à ação da física
  physics.addBody(obstacle, "dynamic")

  -- Impulsiono o obstáculo em direção ao jogador
  transition.to(obstacle, { x = -100, y = obstacle.y, time = 4000, onComplete = function() display.remove(obstacle) end})
end

-- Cria as questões para o jogo
local function createQuestion()
  -- Sorteio a imagem que irá aparecer
  local nrQuestion = math.random(25, 29)

  -- Sorteio a posição
  local position = math.random(1, 2) -- 1 = cima;  2 = baixo

  -- Crio o objeto
  local question = display.newImageRect(infoGroup, imgSheet, nrQuestion, sheetInfo:getWidth(nrQuestion) * 1.3, sheetInfo:getHeight(nrQuestion) * 1.3)

  -- Posiciono o objeto
  question.x = display.contentWidth + 100 -- Crio fora da tela para dar o efeito
  if position == 1 then
    question.y = 250
  else
    question.y = display.contentHeight - 250
  end

  -- Defino o tipo do objeto e a quantidade de pontos que ele vale
  question.type = "question"

  -- Submeto o objeto à ação da física
  physics.addBody(question, "dynamic")

  -- Impulsiono o obstáculo em direção ao jogador
  transition.to(question, { x = -100, y = question.y, time = 4000, onComplete = function() display.remove(question) end})
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

local function gameOver()
  --ODO: Jeidsan: pensar na lógica do game over

  -- Manda para a proxima cena a pontuaçao total
	composer.setVariable("score", txtScore.text)

  --Muda de cena - Fim de Jogo
  composer.gotoScene("gameover")
end

-- Trata das colisões com os obstáculos
local function obstacleCollision(obj1, obj2)
  local lives = composer.getVariable("lives") - 1
  composer.setVariable("lives", lives)
  updateText()

  if obj1.type == "obstacle" then
    display.remove(obj1)
  else
    display.remove(obj2)
  end

  if lives == 0 then
    gameOver()
  end
end

-- Trata da colisão com as questões
local function questionCollision(obj1, obj2)
  -- pauso o jogo
  gamePaused = true;

  -- Sorteio uma das questões e asalternativas
  local nrQuestion, alt1, alt2, alt3 = math.random(1, #questionTable), math.random(1, #questionTable), math.random(1, #questionTable), math.random(1, #questionTable)

  while (nrQuestion == alt1) or (nrQuestion == alt2) or (nrQuestion == alt3) or (alt1 == alt2) or (alt1 == alt3) or (alt2 == alt3) do
    nrQuestion, alt1, alt2, alt3 = math.random(1, #questionTable), math.random(1, #questionTable), math.random(1, #questionTable), math.random(1, #questionTable)
  end

  local alts = {
    {
      nm_imagem = questionTable[alt1].nm_imagem,
      ds_resposta = questionTable[alt1].ds_resposta
    },
    {
      nm_imagem = questionTable[alt2].nm_imagem,
      ds_resposta = questionTable[alt2].ds_resposta
    },
    {
      nm_imagem = questionTable[alt3].nm_imagem,
      ds_resposta = questionTable[alt3].ds_resposta
    },
  }

  local quiz = questionTable[nrQuestion]

  -- Carrego a questão na variável com composer
  composer.setVariable("quiz", quiz)
  composer.setVariable("alternativas", alts)

  if quiz.nr_tipo == 1 then
    --Sorteia o quiz
    local tipoQuiz = math.random(0, 1)

    if tipoQuiz == 0 then
      composer.removeScene("quizImagem")
      composer.gotoScene("quizImagem", { time=1000, effect="crossFade" })
    else
      composer.removeScene("quizTipo")
      composer.gotoScene("quizTipo", { time=1000, effect="crossFade" })
    end
  else
    composer.removeScene("quizPergunta")
    composer.gotoScene("quizPergunta", { time=1000, effect="crossFade" })
  end
end

-- Trata da colisão com bonus
local function bonusCollision(obj1, obj2)
  -- Adiciono os pontos para o jogador
  composer.setVariable("score", composer.getVariable("score") + 10)
  updateText()

  -- Apago o bonus
  display.remove(obj2)
end

-- Trata a colisão entre objetos
local function onCollision(event)
  if (not gamePaused) then
    -- Verifico se é o início da colisão com a phase "began"
    if ( event.phase == "began" ) then
      -- Capturo os objetos que colidiram
      local obj1 = event.object1
      local obj2 = event.object2

      -- Testo as colisões que preciso tratar
      if (obj1.type == "gamer" and obj2.type == "obstacle") or (obj1.type == "obstacle" and obj2.type == "gamer") then
        obstacleCollision(obj1, obj2)
      elseif (obj1.type == "gamer" and obj2.type == "question") or (obj1.type == "question" and obj2.type == "gamer") then
        questionCollision(obj1, obj2)
      elseif (obj1.type == "gamer" and obj2.type == "bonus") or (obj1.type == "bonus" and obj2.type == "gamer") then
        bonusCollision(obj1, obj2)
      end
    end
  end
end

Runtime:addEventListener("collision", onCollision)

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

  -- Crio um grupo para o jogador r adiciono ao grupo da cena
  gamerGroup = display.newGroup()
  sceneGroup:insert(gamerGroup)

  -- Crio o jogador
  createGamer(gamerGroup)

  -- Crio o grupo de Controles e adiciono ao grupo da cena
  controlGroup = display.newGroup()
  sceneGroup:insert(controlGroup)

  -- Crio os Controles
  createControl(controlGroup)

  -- Carrego as questões
  loadQuestionTable()

  print(#questionTable)
end

-- Quando a cena está pronta para ser mostrada (phase will) e quando é mostrada (phase did).
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then

	elseif ( phase == "did" ) then
    -- Reinicio o jogo
    gamePaused = false

    -- Reinicio o motor de física
    physics.start()

    -- Programo o loop do jogo para executar a cada 500ms
    gameLoopTimer = timer.performWithDelay(1500, gameLoop, 0)

    -- Programo o loop do jogador para executar a cada segundo
    gamerLoopTimer = timer.performWithDelay(100, gamerLoop, 0)

    -- Atualizo o texto da pontuação
    updateText()
	end
end

-- Quando a cena está prestes a ser escondida (phase will) e assim que é escondida (phase did).
function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
    -- Paro os temporizadores
		timer.cancel(gameLoopTimer)
    timer.cancel(gamerLoopTimer)

	elseif ( phase == "did" ) then
    -- Pauso o jogo
    gamePaused = true

    -- Removo a detecção de colisões
    Runtime:removeEventListener("colision", onCollision)

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
