--  ----------------------------------------------------------------------------
--  projectname:
--  filename:     menu.lua
--  description:  Contém a definição do menu do aplicação
--  authors:      Jeidsan A. da C. Pereira (jeidsanpereira@gmail.com)
--                Juana Pedreira (juanaspedreira@gmail.com)
--                Rafaela Ruchinski (rafaelaruchi@gmail.com)
--  created:      2016-09-24
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

-- Textos
local controlGroup
local txtScores
local sheetInfo = require("spritesheet")
local imgSheet = graphics.newImageSheet("images/spritesheet.png", sheetInfo:getSheet())
local scoresTable = {}

-- -----------------------------------------------------------------------------
-- Métodos e escopo principal da cena
-- -----------------------------------------------------------------------------
local function createBackground(backGroup)
	-- Crio o background para a cena
	background = display.newImageRect(backGroup, "images/backgroundGameOver.jpg", display.contentWidth, display.contentHeight)
	background.x = display.contentCenterX
	background.y = display.contentCenterY
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

  for i = 1, qtyZeros do
    text = "0" .. text
  end

  return text
end

-- Cria o painel de informações do jogo
local function createInfo(infoGroup)
  -- Determino a largura dos textos
  local textWidth = (display.contentWidth / 2)
  local textHeight = (display.contentHeight / 2) + 120

  -- Crio o texto para informações sobre a pontos
  txtScores = display.newText(infoGroup, adjustText(""..composer.getVariable("score")), textWidth, textHeight, native.systemFont, 150)
  txtScores:setFillColor(color.preto.r, color.preto.g, color.preto.b)
end

local function compare(a,b)
  return a > b
end

--Salva a pontuação
local function loadScores()
	-- Carrego a biblioteca JSON para decodificao os dados
	local json = require("json")

	-- Defino o caminho do arquivo de dados
	local dataPath = system.pathForFile("data/scores.json", system.ResourceDirectory)

  -- Carrego o arquivo de dados na variável file (errorString irá indicar se houve erro)
  local file, errorString = io.open(dataPath, "r")

  -- Carrego os dados na tabela
  if not file then
    -- TODO: Jeidsan: Tratar o caso de erro ao carregar arquivo
  else
    -- Carrego os dados do arquivo
  	local contents = file:read("*a")
  	io.close(file)

  	-- Converto os dados de JSON para o formato de tabela de Lua
  	scoresTable = json.decode(contents)

  	if (scoresTable == nil or #scoresTable == 0) then
    	scoresTable = { 100, 90, 80, 70, 60, 50, 40, 30, 20, 10 }
  	end
  end
end

local function saveScores()
	-- Acrescento a pontuaão da partida atual à tabela
	table.insert(scoresTable, tonumber(composer.getVariable("score")))

	-- Reorganizo a tabela
	table.sort(scoresTable, compare)

	-- Apago os registros menores do 11 em diante
	for i = #scoresTable, 11, -1 do
	  table.remove( scoresTable, i )
	end

  -- Carrego a biblioteca JSON para decodificao os dados
	local json = require("json")

	-- Defino o caminho do arquivo de dados
	local dataPath = system.pathForFile("data/scores.json", system.ResourceDirectory)

	local file = io.open(dataPath, "w")

  if file then
    file:write(json.encode(scoresTable))
  	io.close(file)
  end
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
		--Carrega a pontuação e depois salvo-a
		loadScores()
		saveScores()
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
