--  ----------------------------------------------------------------------------
--  projectname:
--  filename:     highscores.lua
--  description:  Contém a definição do menu do aplicação
--  authors:      Jeidsan A. da C. Pereira (jeidsanpereira@gmail.com)
--                Juana Pedreira (juanaspedreira@gmail.com)
--                Rafaela Ruchinski (rafaelaruchi@gmail.com)
--  created:      2016-11-21
--  modified:     2016-11-27
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

local scoresTable = {}
local sheetInfo = require("spritesheet")
local imgSheet = graphics.newImageSheet("images/spritesheet.png", sheetInfo:getSheet())

-- -----------------------------------------------------------------------------
-- Métodos e escopo principal da cena
-- -----------------------------------------------------------------------------
-- Função que carrega os dados da tabela
function loadScore()
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

-- Leva o usuário até o menu principal
local function gotoMenu()
  composer.gotoScene("menu")
end

local function createBackground(sceneGroup)
  -- Crio o background da cena
  local background = display.newImageRect(sceneGroup, "images/background.png", display.contentWidth, display.contentHeight)
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  local bottom = display.newImageRect(sceneGroup, "images/backgroundWhite.png", 850, 650)
  bottom.x = display.contentCenterX
  bottom.y = display.contentCenterY
  bottom.alpha = 0.7

  -- Crio o título
  local logo = display.newText(sceneGroup, "Recordes", display.contentCenterX, 150, native.systemFont, 80)
  logo.anchorX = 0.5
  logo.anchorY = 0.5
  logo:setFillColor(color.preto.r, color.preto.g, color.preto.b)

  local textHeight = 250;

  --Preencho os pontos na tela
  for i = 1, 5 do
    -- Se a posição não estiver nula
    if (scoresTable[i]) then
      -- crio um novo texto para inserir
      local left = display.newText(sceneGroup, scoresTable[i], display.contentCenterX - 200, textHeight, native.systemFont, 60)
      left:setFillColor(color.preto.r, color.preto.g, color.preto.b)
      left.anchorX = 0.5

      local right = display.newText(sceneGroup, scoresTable[i + 5], display.contentCenterX + 200, textHeight, native.systemFont, 60)
      right:setFillColor(color.preto.r, color.preto.g, color.preto.b)
      right.anchorX = 0.5

      --Incremnento a posição do texto
      textHeight = textHeight + 75
    end
  end
  -- Adiciono um botão para fechar a cena de créditos
  local btnClose = display.newImageRect(sceneGroup, imgSheet, sheetInfo:getFrameIndex("btnClose"), 64, 64)
  btnClose.x = display.contentCenterX
  btnClose.y = display.contentHeight - 100
  btnClose:addEventListener("tap", gotoMenu)
end

-- -----------------------------------------------------------------------------
-- Eventos da cena
-- -----------------------------------------------------------------------------

-- Quando a cena é criada.
function scene:create(event)
  -- Busco o grupo principal para a cena
	local sceneGroup = self.view

  -- Carrego os dados de scores
  loadScore()

  --
  createBackground(sceneGroup);

  --

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
