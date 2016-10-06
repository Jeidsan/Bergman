--  ----------------------------------------------------------------------------
--  projectname:
--  filename:     main.lua
--  description:  Contém a definição do ponto de entrada da aplicação.
--  authors:      Jeidsan A. da C. Pereira (jeidsanpereira@gmail.com)
--                Juana Pedreira (juanaspedreira@gmail.com)
--                Rafaela Ruchinski (rafaelaruchi@gmail.com)
--  created:      2016-09-24
--  modified:     2016-09-24
--  ----------------------------------------------------------------------------

-- Carrego o Composer para gerenciamento de cenas
local composer = require("composer")

-- Escondo a barra de status
display.setStatusBar(display.HiddenStatusBar)

-- Seto uma nova semente para o gerador de números aleatórios
math.randomseed(os.time())

-- Defino uma tabela de cores para usar em toda a aplicação
color =
{
  amarelo   =   { r = 235/255, g = 189/255, b = 18/255 },
  verde     =   { r = 145/255, g = 163/255, b = 41/255 },
  azul      =   { r = 4/255, g = 107/255, b = 138/255 },
  rosa      =   { r = 210/255, g = 23/255, b = 92/255 },
  vermelho  =   { r = 251/255, g = 53/255, b = 76/255},
  preto     =   { r = 0/255, g = 0/255, b = 0/255 },
  branco    =   { r = 255/255, g = 255/255, b = 255/255},
}
--[[local json = require("json")

local dataPath = system.pathForFile("data/data.json", system.ResourceDirectory)
local file, errorString = io.open(dataPath, "r")
local dataTable = {}

if not file then
  print("ERRO: "..errorString)
else
  print("OK")
  local contents = file:read("*a")
  io.close(file)
  dataTable = json.decode(contents)

  if dataTable == nill then
    print("Tabela nula")
  elseif #dataTable == 0 then
    print("Tabela vazia")
  else
    for i=0, #dataTable do
      print(#dataTable)
    end
  end
end
--]]


-- Chamo a cena do menu
composer.gotoScene("quizImagem")
