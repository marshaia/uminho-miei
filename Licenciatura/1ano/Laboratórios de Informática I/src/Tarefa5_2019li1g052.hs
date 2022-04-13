module Main where

import System.Random
import LI11920
import Tarefa0_2019li1g052
import Tarefa1_2019li1g052
import Tarefa2_2019li1g052
import Tarefa4_2019li1g052
import Tarefa6_2019li1g052
import Mapas
import Graphics.Gloss
import Graphics.Gloss.Juicy
import Graphics.Gloss.Interface.Pure.Game


{- |

= __INTRODUÇÃO: __
O objetivo desta Tarefa é criar uma interface gráfica do jogo, utilizando os dados obtidos através das outras tarefas. No entanto, para tornar o jogo
mais atrativo e "user-friendly" decidimos criar um Menu para o jogo, onde os jogadores podem escolher modos de jogo desejados, números de Bots e mapas 
que querem jogar. Para isto foi necessário acrescentar mais dados de informação para além do Estado do jogo. 

= __OBJECTIVOS: __
Para guardar toda a informação necessária à criação do jogo, criamos um dado "World", este guarda uma memória e o Estado do jogo. Na memória, guardamos
5 dados diferentes, respetivamente, o Menu a ser desenhado, uma lista de números aleatórios para serem usados como sementes, um lista de imagens carregadas
externamente e utilizadas para adicionar gráficos ao jogo, uma lista de cronómetros para os jogadores e por fim um par de um número de 1 a 3 e uma lista de 4
números que vão desde 0 a 2. Estes servem para indicar o modo de jogo ativo e a lista de jogadores atuais, se estes estão ativos e se são bots ou humanos.

Com estes dados, o gloss poderá desenhar a qualquer momento o jogo atual e as várias reações que deverão ocorrer. Para isto a função 'play' está dividida em três
funções principais, a função de desenho 'desenhaW', a função que reage aos inputs externos 'eventosW' e a função responsável pela atualização do jogo 'tempoW'



== __desenhaW: __
Função responsável por desenhar os menus ou o jogo atual, esta começa por identificar se irá desenhar um jogo, e caso sim, em que modo, ou um menu e os seus componentes.

Menus: Para o desenho de menus a função utiliza o valor guardado na memória, mais específicamente o dado "Menu", e começa por desenhar este em 4 passos: O 'fundo'; o 'seletor',
utilizado para indicar a opção a ser selecionada, os 'butoes' e por fim 'extras'. 

Para o 'fundo' a ser desenhado a função avalia o Menu e vai buscar a lista de imagens o fundo correspondente. Para o 'seletor' a função avalia o Menu atual, o primeiro INT e o 
segundo para descobrir em que posição será colocado, utilizando o segundo INT para defenir o seu "Scale" (este Int aumenta por um a cada iteração e é utilizado numa função 
senusoide para defenir o valor de Scale). Na função 'butoes' apenas é utilizado o menu para definir as posições dos butões. Para concluir, a função 'extras' avalia o menu 
e adiciona gráficos extras da lista de imagens.


Jogo: Para o desenho do jogo, é utilizado a informação do modo de jogo para desenhar o jogo atual descrito no Estado com as tranformações necessárias, de seguida, é desenhada a
tabela de classificações e o semáforo inicial.

Para o semáforo, é apenas utilizada a informação da memória para avaliar em que fase do menu Jogo está a decorrer e de que forma este será desenhado. A tabela também utiliza um
padrão semelhante ao do semáforo, no entando é mais complicado devido ao ser necessário desenhar as informações que estão nesta tabela. Para isto, é utilizada a função 'scoreJog'
que desenha a informação de cada jogador à vez com a informação presente no "World", esta função começa por desenhar o identificador do jogador, depois desenha o número de colas
ou o cronômetro, caso já tenha acabado o mapa, e para concluir desenha a posição do jogador atual.

Para o desenho do jogo útil, são utilizadas as funções 'mapaEjogadores' e 'mapaEjogadoresParty'. A primeira utiliza um Jogador alvo e irá desenhar o resultado de 'mapaEJogsPreFx'
de forma a que o jogador alvo esteja centrado. A segunda utiliza dois dados, a distância do jogador em primeiro lugar e a diferença de distância entre o primeiro e último jogador,
com estes dados é desenhado o 'mapaEJogsPreFx' de forma a que todos os jogadores estejam visíveis.

'mapaEJogsPreFx' : Está função é a principal por desenhar o Estado do jogo e ocorre em várias fases que se repetem. Esta começa por desenhar a pista número 0 do mapa, desenhando peça
a peça com a função 'despeca', quando a pista for acabada, é chamada a função 'desjogadores' para desenhar os jogadores na pista em questão. Esta função começa por desenhar a sombra
utilizando a informação do jogador e de seguida a sua representação física. Depois de acabada a função apenas repete o mesmo processo para a próxima pista até que esta acaba. 





== __eventosW: __
Função responsável por alterar os dados do "World" consoante os inputs dos jogadores. A primeira instrução é referente ao reset do jogo, este reverte todas as mudanças (sem
apagar a lista de sementes ou imagens), e volta ao Menu principal. O resto dos inputs estão divididos em duas seções: Inputs com mais de um output e inputs com apenas um output
possível. 

Funções como 'mSelec' e 'mBack' são funções que avaliam os Menus atuais e as opções selecionadas e devolvem um World correspondente ao resultado dessa seleção, mantendo dados
que não são afetados. Funções como 'm0Ace' e 'm2Dis' são funções com dois outputs possíveis, caso o jogo esteja no Menu "Party" apenas realiza as alterações necessárias, caso
contrário assume que está no Menu "Jogo" e executa a jogada através da função 'comando2jogada'.

Esta função é de extrema importância pois avalia várias coisas como a lista de jogadores ativos, se estes são bots ou humanos, qual a tecla pressionada e, caso não haja restrições, 
executa a função 'jogada' da Tarefa 2 no jogador correto. 

O resto das instruções estão diretamente ligadas à função 'comando2jogada' pois as suas teclas só são utilizadas em jogo.




== __tempoW: __
Função responsável pera passagem do tempo no jogo e nos Menus. Caso o World esteja num Menu de interface, apenas acrescenta por um ao "contador" utilizado pelo seletor.

No caso de estar em jogo, a função começa por aplicar a função responsável pela jogada dos bots 'avaliaJogadaBots' que avalia se já passou os definidos 0.2 segundos para realizar
as jogadas nos vários bots. De seguida aplica a função 'atualizaTempoJogs' que, caso os jogadores já não tenham alcançado a meta, aplica a função passo da Tarefa 4 nos jogadores. Depois
disso e aplicada na memória a função 'avancaContador' que avança o contador atual e decide se o Menu "Jogo" avança para a próxima fase (ver definição do Menu Jogo) e acrescenta por um  
aos valores na lista de cronômetros dos jogadores ativos. Por fim, é aplicado a função 'atualizaMeta' que avalia se algum jogador chegou ao fim do mapa e faz as alterações necessárias
para registar o lugar em que este ficou.


= __CONCLUSÃO: __
Acreditamos que com estas mudanças, conseguimos tornar o jogo muito mais apelativo, apesar de não haver música e som, e conseguimos realizar o que nos foi pedido da Tarefa, até acrescentando
mais do que fora pedido para a interface.

-}

relatório_Tarefa5 :: String
relatório_Tarefa5 = "Relatório"

-- | Função principal da Tarefa 5.
-- __NB:__ Esta Tarefa é completamente livre. Deve utilizar a biblioteca <http://hackage.haskell.org/package/gloss gloss> para animar o jogo, e reutilizar __de forma completa__ as funções das tarefas anteriores.
main :: IO ()
main = do x <- randomIO
          seeds <- return (take 20 (randomRs (0,10000) (mkStdGen x)))
          Just m1 <- loadJuicy "graficos/motas/motaj1.png"
          Just m2 <- loadJuicy "graficos/motas/motaj2.png"
          Just m3 <- loadJuicy "graficos/motas/motaj3.png"
          Just m4 <- loadJuicy "graficos/motas/motaj4.png"
          Just m5 <- loadJuicy "graficos/fundos/menuP.png"
          Just m6 <- loadJuicy "graficos/fundos/menuParty.png" 
          Just m7 <- loadJuicy "graficos/fundos/MenuMapa.png"
          Just m8 <- loadJuicy "graficos/butoes/butSol.png"
          Just m9 <- loadJuicy "graficos/butoes/butDuo.png"
          Just m10 <- loadJuicy "graficos/butoes/butParty.png"
          Just m11 <- loadJuicy "graficos/butoes/0Bots.png"
          Just m12 <- loadJuicy "graficos/butoes/1Bots.png"
          Just m13 <- loadJuicy "graficos/butoes/2Bots.png"
          Just m14 <- loadJuicy "graficos/butoes/3Bots.png"
          Just m15 <- loadJuicy "graficos/extras/sem0.png"
          Just m16 <- loadJuicy "graficos/extras/sem1.png"
          Just m17 <- loadJuicy "graficos/extras/sem2.png"
          Just m18 <- loadJuicy "graficos/extras/sem3.png"
          Just m19 <- loadJuicy "graficos/extras/face1.png"
          Just m20 <- loadJuicy "graficos/extras/face2.png"
          Just m21 <- loadJuicy "graficos/extras/face3.png"
          Just m22 <- loadJuicy "graficos/extras/face4.png"
          Just m23 <- loadJuicy "graficos/extras/cola.png"
          Just m24 <- loadJuicy "graficos/extras/winner.png"
          Just m25 <- loadJuicy "graficos/crono/0.png"
          Just m26 <- loadJuicy "graficos/crono/1.png"
          Just m27 <- loadJuicy "graficos/crono/2.png"
          Just m28 <- loadJuicy "graficos/crono/3.png"
          Just m29 <- loadJuicy "graficos/crono/4.png"
          Just m30 <- loadJuicy "graficos/crono/5.png"
          Just m31 <- loadJuicy "graficos/crono/6.png"
          Just m32 <- loadJuicy "graficos/crono/7.png"
          Just m33 <- loadJuicy "graficos/crono/8.png"
          Just m34 <- loadJuicy "graficos/crono/9.png"
          Just m35 <- loadJuicy "graficos/crono/numO.png"
          Just m36 <- loadJuicy "graficos/crono/twoDots.png"
          Just m37 <- loadJuicy "graficos/fundos/fundoJogo.png"
          Just m38 <- loadJuicy "graficos/crono/s.png"
          Just m39 <- loadJuicy "graficos/extras/winner.png"
          Just m40 <- loadJuicy "graficos/motas/motamorto1.png"
          Just m41 <- loadJuicy "graficos/motas/motamorto2.png"
          Just m42 <- loadJuicy "graficos/motas/motamorto3.png"
          Just m43 <- loadJuicy "graficos/motas/motamorto4.png"
          Just m44 <- loadJuicy "graficos/butoes/empty.png"
          Just m45 <- loadJuicy "graficos/butoes/cartajog1.png"
          Just m46 <- loadJuicy "graficos/butoes/cartajog2.png"
          Just m47 <- loadJuicy "graficos/butoes/cartajog3.png"
          Just m48 <- loadJuicy "graficos/butoes/cartajog4.png"
          Just m49 <- loadJuicy "graficos/butoes/BOT.png"
          Just m50 <- loadJuicy "graficos/butoes/extrajog1.png"
          Just m51 <- loadJuicy "graficos/butoes/extrajog2.png"
          Just m52 <- loadJuicy "graficos/butoes/extrajog3.png"
          Just m53 <- loadJuicy "graficos/butoes/extrajog4.png"
          Just m54 <- loadJuicy "graficos/extras/escModo.png"
          Just m55 <- loadJuicy "graficos/extras/escBots.png"
          Just m56 <- loadJuicy "graficos/extras/primaF5.png"
          Just m57 <- loadJuicy "graficos/extras/thumbnails/gerathumb.png"
          Just m58 <- loadJuicy "graficos/extras/thumbnails/thumb1.png"
          Just m59 <- loadJuicy "graficos/extras/thumbnails/thumb2.png"
          Just m60 <- loadJuicy "graficos/extras/thumbnails/thumb3.png"
          Just m61 <- loadJuicy "graficos/extras/thumbnails/thumb4.png"
          Just m62 <- loadJuicy "graficos/extras/thumbnails/thumb5.png"
          pics <- return [m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,m15,m16,m17,m18,m19,m20,m21,m22,m23,m24,m25,m26,m27,m28,m29,m30,m31,m32,m33,m34,m35,m36,m37,m38,m39,m40,
                          m41,m42,m43,m44,m45,m46,m47,m48,m49,m50,m51,m52,m53,m54,m55,m56,m57,m58,m59,m60,m61,m62]
          play FullScreen
               (greyN 0.4)
               fr
               (startup pics seeds) 
               desenhaW
               eventosW
               tempoW

-- | World. Carrega o estado do jogo mais as variáveis utilizadas nas interfaces.
type World = (Memória,Estado)    

-- | Dados para guardar em mémoria. Respetivamente: Menu a desenhar; Lista de sementes; Lista de imagens PNG; Cronómetros dos jogadores e Modo de jogo.
type Memória = (Menu,Seeds,[Picture],[Cronómetro],Modo)  

-- | Lista de números aleatórios para caso o jogador queira um mapa gerado. Lista finita em loop.
type Seeds = [Int]    

-- | Um Int que aumenta por 1 a cada "tempoW". Obtem-se o tempo dividindo o valor pela framerate do jogo (segundos)           
type Cronómetro = Int 

-- | Modo de jogo e lista de jogadores em jogo. Modo: 1-Solo/2-Duo/3-Party /// Lista: 0-Vazio/1-Humano/2-Bot           
type Modo = (Int,[Int])      

-- | Menu a ser desenhado no jogo: 

-- | (1) Menu Principal (Selecionador) (Efeito visual)

-- | (2) Seleção do número de bots (Selecionador) (Efeito visual)

-- | (3) Menu de seleção de jogadores (Lista de números de 0 a 2, por ordem de jogador. 0-Vazio/1-Humano/2-Bot)

-- | (4) Seleção dos mapas (Selecionador) (Efeito visual)

-- | (5) Indicador para desenhar o Estado atual do jogo. (Modo de desenho/ação) (Contador)

-- |              Significado do menu "JOGO"

-- |              Jogo INT Int (significados das ações)

-- | (1)             Jogo 1 _ = Pausa inicial

-- | (2)             Jogo 2 _ = Entrada do semáforo/contador de corrida

-- | (3)             Jogo 3 _ = Pausa depois da Entrada

-- | (4)             Jogo 4 _ = Semáforo primeira luz amarela

-- | (5)             Jogo 5 _ = Semáforo primeira e segunda luz amarela.

-- | (6)             Jogo 6 _ = Semáforo luz verde. Corrida começa.

-- | (7)             Jogo 7 _ = Semádoro sai.

-- | (8)             Jogo 8 _ = Jogo normal. 
data Menu =   Principal Int Int  
            | BotSel Int Int     
            | PartySel [Int]     
            | MapaSel Int Int    
            | Jogo Int Int       
            deriving (Eq,Show)


-- * Constantes do Jogo.
----------------------------------------------------------------

-- | Framerate
fr :: Int
fr = 60

-- | Tamanho dos butões
tbut :: Float 
tbut = 450

-- | Tamanho dos quadrados
sqTam :: Float
sqTam = 300

-- | Tempo do ciclo do efeito visual (segundos)
tciclo :: Float  
tciclo = 2

-- ** Constantes para o desenho do mapa

-- | Scaling Altura (NºPixeis por unidade de altura)
hScl :: Int 
hScl = 250

-- | Distãncia das peças
distP :: Float 
distP = 250

-- | Grossura das pecas
grossP :: Float 
grossP = 200

-- | Prespetiva (Muda o ângulo da inclinação das peças (-90 < ang < 90))
presp :: Float
presp = realToFrac (grossP * tan (realToFrac(deg2rad 10)))

----------------------------------------------------------------- 



-- | 'startup' : Define a interface do jogo no ínicio.
startup :: [Picture] -> Seeds -> World
startup lp ls = ((Principal 1 0,ls,lp,[],(1,[])),Estado [[]] [])   -- Inicia o jogo no menu principal






-- * Função principal de desenho do ecrã. Decide se desenha um menu ou o jogo atual
-- | 'desenhaW' : Com a informação da memória, desenha os menus/interfaces ou o jogo atual.    
desenhaW :: World -> Picture
desenhaW w@(m@((Jogo _ _),_,lp,c,(mode,a)),Estado mapa jogs) 
                  | mode == 1 = Pictures [mapaEjogadores (encontraIndiceLista 0 jogs) w,scoreboard w,Scale 0.9 0.9 (semaforo m)]
                  | mode == 2 = Pictures [Translate 0 275 (Scale (0.8) (0.5) (mapaEjogadores (encontraIndiceLista 0 jogs) w)),
                                          Translate 0 (-275) (Scale (0.8) (0.5) (mapaEjogadores (encontraIndiceLista 1 jogs) w)),
                                          Polygon [(-960,-5),(960,-5),(960,5),(-960,5)],Translate 500 100 (Scale 0.8 0.8 (scoreboard w)),Scale 0.9 0.9 (semaforo m),
                                          Translate (-920) (500) (lp !! 18),Translate (-920) (-50) (lp !! 19)]
                  | mode == 3 = Pictures [mapaEjogadoresParty (distJogadorPrimeiro 0 jogs) (difDistsJogs 2000 0 jogs) (length (head mapa)) w,
                                          scoreboard w,Scale 0.9 0.9 (semaforo m)] 
desenhaW w@((_,_,_,_,_),_) = Pictures (desMenu w)






-- ** Funções utilizadas no desenho de menus.
-- | 'desMenu' : Faz a ordem no qual os elementos do menu são desenhados. Fundo,seletor,butôes,extras.
desMenu :: World -> [Picture]
desMenu w = [fundo w,seletor w,butoes w,extras w]

-- |'fundo' : Desenha o fundo adequado ao menu
fundo :: World -> Picture
fundo ((Principal _ _,_,lp,_,_),_) = (lp !! 4)
fundo ((BotSel _ _,_,lp,_,_),_) = (lp !! 4)
fundo ((PartySel _,_,lp,_,_),_) = (lp !! 5)
fundo ((MapaSel _ _,_,lp,_,_),_) = (lp !! 6)

-- |'seletor' : Desenha o seletor, dependendo do menu e a opcão a ser selecionada.
seletor :: World -> Picture
seletor (((Principal pos x),_,_,_,_),_) = Translate (350) (fromIntegral pos*(-250)+350) (Scale (func x) (func x) (Color red butforma))
seletor (((BotSel pos x),_,_,_,_),_) | pos == 1 = Translate 100 50 (Scale (func x) (func x) (Color red butforma))
                                     | pos == 2 = Translate 600 50 (Scale (func x) (func x) (Color red butforma))
                                     | pos == 3 = Translate 100 (-200) (Scale (func x) (func x) (Color red butforma))
                                     | pos == 4 = Translate 600 (-200) (Scale (func x) (func x) (Color red butforma))
seletor ((MapaSel pos x,_,_,_,_),_) | pos <= 3 = Translate (-900+fromIntegral pos*450) (100) (Scale (func x) (func x) (Color red square))
                                    | otherwise = Translate (-900+fromIntegral (pos-3)*450) (-300) (Scale (func x) (func x) (Color red square))
seletor _ = Blank

-- |'butoes' : Desenha os "butões" intermédios, dependendo do menu.
butoes :: World -> Picture
butoes (((Principal _ _),_,_,_,_),_) = Pictures [Translate 350 100 butaoVaz, Translate 350 (-150) butaoVaz, Translate 350 (-400) butaoVaz]
butoes (((BotSel _ _),_,_,_,(x,l)),_) = Pictures [Translate 100 50 butaoVaz, Translate 600 50 butaoVaz, Translate 100 (-200) butaoVaz, Translate 600 (-200) butaoVaz]
butoes (((PartySel l),_,lp,_,(x,_)),_) = Pictures (desParty 0 l lp)
butoes (((MapaSel _ _),_,_,_,(x,l)),_) = Pictures [Translate (-450) 100 square,Translate 0 100 square,Translate 450 100 square,
                                                   Translate (-450) (-300) square ,Translate 0 (-300) square ,Translate (450) (-300) square]

-- |'extras' : Vai buscar à lista de imagens gráficos extras e coloca-os em posição
extras :: World -> Picture
extras ((Principal _ _,_,lp,_,_),_) = Pictures [Translate 350 100 (lp !! 7),Translate 350 (-150) (lp !! 8),Translate 350 (-400) (Scale 0.9 0.9 (lp !! 9)),Translate 350 250 (lp !! 53)]
extras ((BotSel _ _,_,lp,_,(x,_)),_) = if x == 1 then Pictures [Translate 100 50 (lp !! 10), Translate 600 50 (lp !! 11), Translate 100 (-200) (lp !! 12), Translate 600 (-200) (lp !! 13),Translate 350 200 (lp !! 54)]
                                                 else Pictures [Translate 100 50 (lp !! 10), Translate 600 50 (lp !! 11), Translate 100 (-200) (lp !! 12), Translate 600 (-200) (lp !! 13),Translate 600 (-200) (Color (makeColorI 70 70 70 200) butforma),Translate 350 200 (lp !! 54)]
extras ((MapaSel _ _,_,lp,_,_),_) = Pictures [Translate (-450) 100 (Scale 1.2 1.2 (lp !! 56)),Translate 0 100 (lp !! 57),Translate (450) 100 (lp !! 58),
                                              Translate (-450) (-300) (lp !! 59),Translate 0 (-300) (lp !! 60),Translate (450) (-300) (lp !! 61)]
extras _ = Blank



-- *** Funções auxiliares no desenho de menus.
-- |'desParty' : Função que desenha por ordem as compenentes do menu PARTY, dependendo da seleção atual.
desParty :: Int -> [Int] -> [Picture] -> [Picture]
desParty 4 _ _ = []
desParty n (h:t) lp = [carta n h lp,info n lp,humanoOuBot n h lp] ++ desParty (n+1) t lp

-- |'carta' : Recebendo o número do jogador e se este está ativo, desenha a imagem no local correto.
carta :: Int -> Int -> [Picture] -> Picture
carta n 0 lp | n == 0 = Translate (-500) (240) (lp !! 43)
             | n == 1 = Translate (500) (240) (lp !! 43)
             | n == 2 = Translate (-500) (-240) (lp !! 43)
             | n == 3 = Translate (500) (-240) (lp !! 43)
carta n _ lp | n == 0 = Translate (-500) (240) (lp !! (n+44))
             | n == 1 = Translate (500) (240) (lp !! (n+44))
             | n == 2 = Translate (-500) (-240) (lp !! (n+44))
             | n == 3 = Translate (500) (-240) (lp !! (n+44))

-- |'info' : Recebendo o número do jogador, desenha a informação dos controlos
info :: Int -> [Picture] -> Picture
info n lp | n == 0 = Translate (-500) (240) (lp !! (n+49))
          | n == 1 = Translate (500) (240) (lp !! (n+49))
          | n == 2 = Translate (-500) (-240) (lp !! (n+49))
          | n == 3 = Translate (500) (-240) (lp !! (n+49))

-- |'humanoOuBot' : Desenha o aviso "BOT" no menu party, sabendo se o jogador a desenhar é um bot.
humanoOuBot :: Int -> Int -> [Picture] -> Picture
humanoOuBot n 2 lp | n == 0 = Translate (-500) (240) (lp !! 48)
                   | n == 1 = Translate (500) (240) (lp !! 48)
                   | n == 2 = Translate (-500) (-240) (lp !! 48)
                   | n == 3 = Translate (500) (-240) (lp !! 48)
humanoOuBot _ _ _ = Blank

-- |'func' : Determina o valor usado no Scale do seletor, para o efeito visual. (Varia de 1.01 até 1.11)
func :: Int -> Float
func x = realToFrac (1.06 + 0.05*(sin (deg2rad (realToFrac((360/(fromIntegral fr*tciclo))*fromIntegral x)))))

-- |'butaoVaz' : Junta dois "butões", um preto e um branco mais pequeno.
butaoVaz :: Picture
butaoVaz = Pictures [Color black butforma, Scale (0.95) (0.9) (Color white butforma)]

-- |'butforma' : Define o poligno usado nos butões, utilizando a constante.
butforma :: Picture
butforma = Polygon [(-(tbut*4/10),(-2/10*tbut)), (tbut*4/10,(-2/10*tbut)), (tbut/2,(-2/20*tbut)), (tbut/2,2/20*tbut), 
                     (tbut*4/10,2/10*tbut) ,(-(tbut*4/10),2/10*tbut) ,(-(tbut/2),2/20*tbut), (-(tbut/2),-(2/20*tbut)) ]

-- |'square' : Define um quadrado, utilizando a constante.
square :: Picture 
square = Polygon [(neg,neg), (pos,neg), (pos,pos), (neg,pos) ]
                     where neg = -1/2*sqTam
                           pos = 1/2*sqTam







-- ** Funções de desenho da interface do jogo útil. Desenha o semáforo inicial e a "scoreboard" 
-- |'semaforo' : Desenha a entrada, alternação e saída do semáforo inicial. A entrada e a saida são descritas por funções parabólicas que utilizam o contador.
semaforo :: Memória -> Picture
semaforo (Jogo x y,_,lp,_,(n,_)) | x == 2 = Translate (-700) (((realToFrac y-(realToFrac fr * 1.5))^2)*0.06+300) (lp !! 14) 
                                 | x >= 3 && x <= 6 = Translate (-700) 300 (lp !! (11+x)) 
                                 | x == 7 = Translate (-700) (((realToFrac y)^2)*0.06+300) (lp !! 17)
                                 | otherwise = Blank

-- |´scoreboard' : Desenha a tabela inicial para as classificações.
scoreboard :: World -> Picture 
scoreboard w@((Jogo x y,_,lp,_,(_,lj)),Estado _ jogs)    | x <= 6 = Blank
                                                         | x == 7 = Translate 0 (((realToFrac y-(realToFrac fr * 1.5))^2)*0.04+400) (Pictures (Scale 2 1.4 butaoVaz:scoreJog 0 w lj))
                                                         | otherwise = Translate 0 400 (Pictures (Scale 2 1.4 butaoVaz : (scoreJog 0 w lj))) 



-- *** Funções para desenhar toda a informação presente na scoreboard.
-- |'scoreJog' : Sabendo o número do jogador a desenhar e se estes estão ativos ou não, desenha as informações do jogador. Começa pela cara do jogador, o número de colas ou o cronómetro e depois a posição atual.
scoreJog :: Int -> World -> [Int] -> [Picture]
scoreJog 4 w _ = []
scoreJog n (((Jogo _ _),_,_,[],(_,[])),_) _ = []
scoreJog n w@(((Jogo a b),c,lp,d@(crh:crono),(e,l@(jh:lj))),f@(Estado _ jogs)) lxj | jh == 0 = scoreJog (n+1) (((Jogo a b),c,lp,crono,(e,lj)),f) lxj
                                                                                   | otherwise = [Translate (realToFrac n*190-250) 50 (lp !! (n+18)),
                                                                                            colaouCronometro n crh lxj jogs lp,
                                                                                            primeiroVencedor n lxj jogs lp] 
                                                                                             ++ scoreJog (n+1) (((Jogo a b),c,lp,crono,(e,lj)),f) lxj

-- |'primeiroVencedor' : Verifica se há um primeiro vencedor (dist == 1920) e desenha a vitória.
primeiroVencedor :: Int -> [Int] -> [Jogador] -> [Picture] -> Picture
primeiroVencedor n lxj jogs lp = if (encontraIndiceLista n (ordemDist lxj jogs)) == 1920 then Pictures [Translate (realToFrac n*190-335) 50 (Scale 0.2 0.2 (lp !! 38)),Translate 0 (-160) (lp !! 55)]
                                  else Pictures [Translate (realToFrac n*190-298) 50 (Scale 0.4 0.4 (lp !! 34)),
                                               Translate (realToFrac n*190-335) 50 (Scale 0.4 0.4 (lp !! ((numMaiorIndice n (encontraIndiceLista n (ordemDist lxj jogs)) 1 (ordemDist lxj jogs))+24)))]

-- |'colaouCronometro' : Dependendo se o jogador já acabou o mapa, desenha o número de cola ou então o número no cronómetro
colaouCronometro :: Int -> Int -> [Int] -> [Jogador]-> [Picture] -> Picture
colaouCronometro n crono lxj jogs lp | encontraIndiceLista n lxj < 4 = Pictures [Translate (realToFrac n*190-315) (-50) (Scale 0.15 0.15 (lp !! 22)),
                                                                            Translate (realToFrac n*190-250) (-47) (Scale 0.45 0.45 (lp !! (ncolaJog (encontraIndiceLista (trueJog n n lxj) jogs)+ 24)))]
                                     | otherwise  = Pictures [Translate (realToFrac n*190-355) (-45) (Scale 0.3 0.3 (lp !! ((numCrono 4 crono)+24))),
                                                              Translate (realToFrac n*190-323) (-45) (Scale 0.3 0.3 (lp !! ((numCrono 3 crono)+24))),
                                                              Translate (realToFrac n*190-300) (-45) (Scale 0.3 0.3 (lp !! 35)),
                                                              Translate (realToFrac n*190-275) (-45) (Scale 0.3 0.3 (lp !! ((numCrono 2 crono)+24))),
                                                              Translate (realToFrac n*190-243) (-45) (Scale 0.3 0.3 (lp !! ((numCrono 1 crono)+24))),
                                                              Translate (realToFrac n*190-213) (-45) (Scale 0.3 0.3 (lp !! 37))]

-- |'numCrono' : Recebendo um INT e a casa decimail desejada, calcula o digito correto.                                
numCrono :: Int -> Int -> Int 
numCrono n crono | n == 1 = mod trueSeg 10
                 | n == 2 = div (mod trueSeg 100) 10
                 | n == 3 = mod min 10
                 | n == 4 = div (mod min 100) 10
                                  where seg = floor (fromIntegral crono / fromIntegral fr)
                                        min = floor (fromIntegral seg / fromIntegral 60)
                                        trueSeg = floor (realToFrac (mod (fromIntegral seg) (fromIntegral 60)))

-- |'ncolaJog' : Retira o número de colas de um jogador.
ncolaJog :: Jogador -> Int
ncolaJog (Jogador _ _ _ ncola _) = ncola

-- |'trueJog' : Calcula o indice a usar para chamar o jogador. Na lista de jogadores pode haver "vagas", no entanto a lista da informação dos jogadores não contêm jogadores vazios.
trueJog :: Int -> Int -> [Int] -> Int
trueJog n 0 l = n
trueJog n n1 (h:t) | h == 0 = trueJog (n-1) (n1-1) t
                   | otherwise = trueJog n (n1-1) t  

-- |'ordemDist' : Devolve uma lista ordenada pela lista de jogadores contendo a distância de cada um. 
ordemDist :: [Int] -> [Jogador] -> [Double]
ordemDist (h:lj) n@(Jogador _ dist _ _ _:ljogs) | h == 0 = 0 : ordemDist lj n  
                                                | h >= 4 = ((-20)* fromIntegral h) + 2000 : ordemDist lj ljogs
                                                | otherwise = dist : ordemDist lj ljogs
ordemDist l l1 = []

-- |'numMaiorIndice' : Função que descobre o indice na lista de distâncias, o que devolve o número do lugar de cada jogador.
numMaiorIndice :: Int -> Double -> Int -> [Double] -> Int
numMaiorIndice jog _ x [] = x
numMaiorIndice jog n x (h:t) = if n >= h then numMaiorIndice jog n x t else numMaiorIndice jog n (x+1) t 






-- ** Funções de desenho do jogo útil. Desenha o mapa com os jogadores.
-- |'mapaEjogadores' : Dado um jogador alvo e o World, desenha o estado do jogo centrado no jogador.
mapaEjogadores :: Jogador -> World -> Picture
mapaEjogadores (Jogador _ dist _ _ _) w = Translate (-500 - 0.3*(distP* realToFrac dist)) (-325) (scale (0.3) (0.3) (mapaEJogsPreFx w))

-- |'mapaEjogadoresParty' : Dado o valor da distância entre jogadores e a distância do jogador em primeiro, desenha o estado do jogo e ajusta de forma a caberem todos.
mapaEjogadoresParty :: Double -> Float -> Int -> World -> Picture
mapaEjogadoresParty max dif distmapa w | dif <= 10 =  Translate ((-200*(dif-10)*(-0.05)) - 0.3*(distP* realToFrac max)) (-325) (scale (0.3) (0.3) (mapaEJogsPreFx w))
                                       | dif >= 30 =  Translate ((-200*(dif-10)*(-0.05)) - 0.1*(distP* realToFrac max)) (-325) (scale (0.1) (0.3) (mapaEJogsPreFx w))
                                       | otherwise = Translate ((-200*(dif-10)*(-0.05)) - (0.3 + (-0.2/20*(dif-10)))*(distP* realToFrac max)) (-325) (scale (0.3 + (-0.2/20*(dif-10))) (0.3) (mapaEJogsPreFx w)) 

-- |'distJogadorPrimeiro' : Devolve a distância do jogador em primeiro.
distJogadorPrimeiro :: Double -> [Jogador] -> Double
distJogadorPrimeiro x [] = x
distJogadorPrimeiro x ((Jogador _ dist _ _ _):t) = if dist > x then distJogadorPrimeiro dist t else distJogadorPrimeiro x t

-- |'difDistsJogs' : Calcula a distância entre o primeiro jogador e último.
difDistsJogs :: Double -> Double -> [Jogador] -> Float
difDistsJogs min max [] = realToFrac (max - min)
difDistsJogs min max ((Jogador _ dist _ _ _):t) | dist > max && dist < min = difDistsJogs dist dist t
                                                     | dist > max = difDistsJogs min dist t
                                                     | dist < min = difDistsJogs dist max t
                                                     | otherwise = difDistsJogs min max t 


-- |'mapaEJogsPreFx' : Desenha o mapa com os jogadores, sem efeitos de translate ou scale.
mapaEJogsPreFx :: World -> Picture
mapaEJogsPreFx w@((_,_,lp,_,_),Estado mapa _) = Pictures ((desenhaFundos (lp !! 36) (ceiling(fromIntegral(length (head mapa))/20)) (-1) ) ++ (desmapa 0 (0,0) w mapa))

-- |'desenhaFundos' : Dado o valor do comprimento do mapa, desenha o número de fundos necessários para o mapa.
desenhaFundos :: Picture -> Int -> Int -> [Picture]
desenhaFundos fundo comp n = if comp == (n-1) then [Blank] else Translate (realToFrac(800 + 6500*n)) 1100 (Scale 3.4 3.4 fundo) : desenhaFundos fundo comp (n+1)

-- |'desmapa' : Desenha o mapa, começando pela pista 0, depois de acabada, desenha os jogadores nessa pista. Repete o processo para todas as pistas.
desmapa :: Int -> (Float,Float) -> World -> Mapa -> [Picture]
desmapa n (x,y) (m@(_,_,lp,_,(_,l)),Estado [[]] jogs)       mapa = [desjogadores (encontraIndiceLista n mapa) n (0,l) jogs lp]
desmapa n (x,y) (m@(_,_,lp,_,_),Estado ((h:t):t1) jogs) mapa = despeca (x,y) h : desmapa n (x+distP,y) (m,Estado ((t):t1) jogs) mapa
desmapa n (x,y) (m@(_,_,lp,_,(_,l)),Estado ([]:t1) jogs)    mapa = desjogadores (encontraIndiceLista n mapa) n (0,l) jogs lp : desmapa (n+1) (realToFrac n*presp + presp,y-grossP) (m,Estado t1 jogs) mapa
 
-- |'despeca' : Recebe a informção da peça numa coordenada e desenha-a em três fases. O chão da peça, o suporte/parede e depois o outline.
despeca :: (Float,Float) -> Peca -> Picture
despeca pos p = Pictures [desChao pos p,enchePeca pos p,Line (pecapath pos p)]

-- |'desChao' : Desenha o chão da peça, dependo se esta é uma rampa ou recta e preenche a cor correspondente ao piso.
desChao :: (Float,Float) -> Peca -> Picture
desChao pos pe@(Recta p h) = Color (piscor p) (Polygon (pecapath pos pe)) 
desChao pos pe@(Rampa p h hf) = Color (piscor p) (Polygon (pecapath pos pe))

-- |'enchePeca' : Desenha o suporte da peça.
enchePeca :: (Float,Float) -> Peca -> Picture
enchePeca (x,y) (Recta p h) = Color (piscorT p) (Polygon [(x, y+rtf),  (x+distP, y+rtf), (x+distP, y), (x,y)])
                                                             where rtf = realToFrac (h*hScl)
enchePeca (x,y) (Rampa p h hf) = Color (piscorT p) (Polygon [(x, y+rtf),   (x+distP, y+rtf+realToFrac(hScl*(hf - h))), (x+distP, y),   (x,y)])
                                                             where rtf = realToFrac (h*hScl)



-- *** Funções constantes para o desenho das peças.
-- |'piscor' : Guarda a informação da cor do chão.   
piscor :: Piso -> Color
piscor p = case p of
            Terra -> makeColorI 188 94 0 256
            Relva -> makeColorI 50 205 50 256
            Lama -> makeColorI 102 51 0 256
            Boost -> makeColorI 255 215 0 256
            Cola -> makeColorI 128 128 128 256

-- |'piscorT' : Guarda a informação da cor do suporte (Transparência).   
piscorT :: Piso -> Color
piscorT p = case p of
      Terra -> makeColorI 188 94 0 80
      Relva -> makeColorI 50 205 50 80
      Lama -> makeColorI 102 51 0 80
      Boost -> makeColorI 255 215 0 80
      Cola -> makeColorI 128 128 128 80

-- |'pecapath' : Define a forma dos polignos das peças, utilizando as constantes do tamanho do mapa em cima.     
pecapath :: (Float,Float) -> Peca -> Path
pecapath (x,y) (Recta p h) = [(x, y+rtf),    (x+distP, y+rtf),   (x+distP-presp, y+grossP+rtf),   (x-presp, y+grossP+rtf)]
                                where rtf = realToFrac (h*hScl)  
pecapath (x,y) (Rampa p h hf) = [(x, y+rtf),   (x+distP, y+rtf+realToFrac(hScl*(hf - h))),   
                                 (x+distP-presp, y+grossP+rtf+realToFrac(hScl*(hf - h))),   (x-presp,y+grossP+rtf)]
                                where rtf = realToFrac (h*hScl)
--- ***
     
                                
-- ** Funções de desenho do jogo útil. Desenha os Jogadores.
-- |'desjogadores' : Função que recebe a informação da pista, o número desta, a lista de jogadores por ordem e a lista efetiva e desenha os jogadores.
desjogadores :: [Peca] -> Int -> (Int,[Int]) -> [Jogador] -> [Picture] -> Picture
desjogadores lpec n (x,lj) jogs lp = Pictures (desJogAux lpec n (x,lj) jogs lp)

-- |'desJogAux' : Determina os jogadores na pista e desenha-os, a começar pela sua sombra e depois o jogador.
desJogAux :: [Peca] -> Int -> (Int,[Int]) -> [Jogador] -> [Picture] -> [Picture]
desJogAux lpec n (x,lj) [] lp = [Blank]
desJogAux lpec n (x,(h:lj)) ljog@(j@(Jogador npista dist _ _ _):t) lp | h == 0 = desJogAux lpec n (x+1,lj) ljog lp
                                                                      | h >= 4 && n == npista = desJogAux lpec n (x+1,lj) t lp
                                                                      | n == npista = Pictures [desSombra (encontraIndiceLista (floor dist) lpec) j,desJog (encontraIndiceLista (floor dist) lpec) x j lp] : desJogAux lpec n (x+1,lj) t lp
                                                                      | otherwise = desJogAux lpec n (x+1,lj) t lp

-- |'desJog' : Desenha o jogador na posição correta.
desJog :: Peca -> Int -> Jogador -> [Picture] -> Picture
desJog _ n j@(Jogador _ _ _ _ (Ar _ ang _)) lp = Translate (auxX j) (auxYar j) (Rotate (realToFrac (-ang)) (ajustMota n (Chao False) lp))  
desJog p@(Recta _ h) n j@(Jogador npista dist _ _ e) lp = Translate (auxX j) (auxYpeca p j) (ajustMota n e lp) 
desJog p@(Rampa _ h hf) n j@(Jogador npista dist _ _ e) lp = Translate (auxX j) (auxYpeca p j) (Rotate (realToFrac (-(inclinacaoPeca p))) (ajustMota n e lp)) 


-- |'ajustMota' : Desenha a mota correspondente ao jogador.
ajustMota :: Int -> EstadoJogador -> [Picture] -> Picture
ajustMota n (Morto _) lp | n == 0 = Translate 0 20 (Scale 1.2 1.2 (lp !! (n+39)))
                         | n == 1 = Translate 0 10 (Scale 1.1 1.1 (lp !! (n+39)))
                         | n == 2 = Translate 0 20 (Scale 1.3 1.3 (lp !! (n+39)))
                         | n == 3 = Translate 0 20 (Scale 1.4 1.4 (lp !! (n+39)))
ajustMota n (Chao _) lp | n == 0 = Translate 0 80 (Scale 1.2 1.2 (lp !! n))
                        | n == 1 = Translate 0 70 (Scale 1.1 1.1 (lp !! n))
                        | n == 2 = Translate 0 80 (Scale 1.3 1.3 (lp !! n))
                        | n == 3 = Translate 0 80 (Scale 1.4 1.4 (lp !! n))

-- |'auxX' : Determina o valor da coordenada X do jogador.
auxX :: Jogador -> Float
auxX (Jogador npista dist _ _ _) = (rtf dist)*distP -(presp/2)+(presp*fi npista)
               where rtf = realToFrac
                     fi = fromIntegral

-- |'auxYar' : Determina o valor da coordenada Y do jogador caso esteja no ar.               
auxYar :: Jogador -> Float 
auxYar (Jogador npista dist _ _ (Ar alt ang _)) = grossP/2 - (grossP * (fi npista)) + (fi hScl * rtf alt)
              where rtf = realToFrac
                    fi = fromIntegral

-- |'auxYpeca' : Determina o valor da coordenada Y do jogador caso esteja no chão.
auxYpeca :: Peca -> Jogador -> Float 
auxYpeca (Recta _ h) (Jogador npista dist _ _ _) = grossP/2 - grossP * fi npista + fi hScl * rtf h
              where rtf = realToFrac
                    fi = fromIntegral
auxYpeca (Rampa _ h hf) (Jogador npista dist _ _ _) = grossP/2 - (grossP * (fi npista)) + (fi h+ fi(hf-h)*rtf (dist - ground dist))* (fi hScl)
              where rtf = realToFrac
                    fi = fromIntegral                    


-- |'desSombra' : Descobre a posição da sombra e desenha-a
desSombra :: Peca  -> Jogador -> Picture
desSombra p j@(Jogador npista dist _ _ (Ar alt _ _))  = Translate ((auxX j)+(distP/24)) ((auxYpeca p j)-(grossP/14)) (Rotate (- realToFrac (inclinacaoPeca p)) (sombra p j))
desSombra p j@(Jogador npista dist _ _ _)  = Translate ((auxX j)+(distP/24)) ((auxYpeca p j)-(grossP/14)) (Rotate (- realToFrac (inclinacaoPeca p)) (sombra p j))

-- |'sombra' : Desenha a sombra, tendo em conta a altura do jogador ao chão.
sombra :: Peca -> Jogador -> Picture 
sombra (Recta _ h) (Jogador _ _ _ _ (Ar alt _ _)) = Scale (rtf fu) (rtf fu*(1/2)) (Color (makeColorI 10 10 10 (floor cgrey)) (ThickCircle (distP/12) (distP/6))) 
                           where fu = ( ((-1)/2) * (alt-fi h) ) + 2
                                 cgrey = ( (-40) * (alt-fi h) ) + 160
                                 rtf = realToFrac 
                                 fi = fromIntegral
sombra (Rampa _ h hf) (Jogador _ dist _ _ (Ar alt _ _)) = Scale (rtf fu) (rtf fu*(1/2)) (Color (makeColorI 10 10 10 (floor cgrey)) (ThickCircle (distP/12) (distP/6))) 
                                 where fu = (((-1)/2) * (alt-(fi h + (fi (hf-h)*(dist - ground dist)))) ) + 2
                                       cgrey = ( (-40) * (alt-(fi h + (fi (hf-h)*(dist - ground dist)))) ) + 160
                                       rtf = realToFrac 
                                       fi = fromIntegral
sombra _ (Jogador _ _ _ _ e) = Scale (2) (1) (Color (makeColorI 10 10 10 160) (ThickCircle (distP/12) (distP/6)))






-- * Função principal que reage a eventos e determina o output. No caso da tecla ter vários outputs dependendo do menu/jogo, chama uma função auxiliar correspondente à tecla.
-- |'eventosW' : Com dadas teclas, determina os outputs, diretamente ou indiretamente.
eventosW :: Event -> World -> World
eventosW (EventKey (SpecialKey KeyF5)        Down _ _) ((_,ls,lp,_,_),_) = ((Principal 1 0,ls,lp,[],(1,[])),Estado [[]] [])
eventosW (EventKey (SpecialKey KeyEnter)     Down _ _) w = mSelec w 
eventosW (EventKey (SpecialKey KeyTab)       Down _ _) w = mBack  w

eventosW (EventKey (SpecialKey KeyRight)     Down _ _) w = mRight w
eventosW (EventKey (SpecialKey KeyLeft)      Down _ _) w = mLeft  w
eventosW (EventKey (SpecialKey KeyUp)        Down _ _) w = mUp    w
eventosW (EventKey (SpecialKey KeyDown)      Down _ _) w = mDown  w

eventosW (EventKey (Char 'm')               Down _ _) w = m0Ace w
eventosW (EventKey (Char 'n')               Down _ _) w = m0Dis w
eventosW (EventKey (Char 'q')               Down _ _) w = m1Ace w
eventosW (EventKey (Char 'e')               Down _ _) w = m1Dis w 
eventosW (EventKey (Char 'r')               Down _ _) w = m2Ace w
eventosW (EventKey (Char 'y')               Down _ _) w = m2Dis w
eventosW (EventKey (Char 'u')               Down _ _) w = m3Ace w
eventosW (EventKey (Char 'o')               Down _ _) w = m3Dis w

eventosW (EventKey (Char 'm')      Up _ _) w@(m@(Jogo x _,_,_,_,(_,l)),e) = if x >= 6 then (m,comando2jogada 0 0 l (Desacelera) e) else w
eventosW (EventKey (Char 'q')      Up _ _) w@(m@(Jogo x _,_,_,_,(_,l)),e) = if x >= 6 then (m,comando2jogada 1 0 l (Desacelera) e) else w
eventosW (EventKey (Char 'r')      Up _ _) w@(m@(Jogo x _,_,_,_,(_,l)),e) = if x >= 6 then (m,comando2jogada 2 0 l (Desacelera) e) else w
eventosW (EventKey (Char 'u')      Up _ _) w@(m@(Jogo x _,_,_,_,(_,l)),e) = if x >= 6 then (m,comando2jogada 3 0 l (Desacelera) e) else w

eventosW (EventKey (Char 'w')  Down _ _) w@(m@(Jogo x _,_,_,_,(_,l)),e) = if x >= 6 then (m,comando2jogada 1 0 l (Movimenta C) e) else w
eventosW (EventKey (Char 'a')  Down _ _) w@(m@(Jogo x _,_,_,_,(_,l)),e) = if x >= 6 then (m,comando2jogada 1 0 l (Movimenta E) e) else w
eventosW (EventKey (Char 's')  Down _ _) w@(m@(Jogo x _,_,_,_,(_,l)),e) = if x >= 6 then (m,comando2jogada 1 0 l (Movimenta B) e) else w
eventosW (EventKey (Char 'd')  Down _ _) w@(m@(Jogo x _,_,_,_,(_,l)),e) = if x >= 6 then (m,comando2jogada 1 0 l (Movimenta D) e) else w

eventosW (EventKey (Char 't')  Down _ _) w@(m@(Jogo x _,_,_,_,(_,l)),e) = if x >= 6 then (m,comando2jogada 2 0 l (Movimenta C) e) else w
eventosW (EventKey (Char 'f')  Down _ _) w@(m@(Jogo x _,_,_,_,(_,l)),e) = if x >= 6 then (m,comando2jogada 2 0 l (Movimenta E) e) else w
eventosW (EventKey (Char 'g')  Down _ _) w@(m@(Jogo x _,_,_,_,(_,l)),e) = if x >= 6 then (m,comando2jogada 2 0 l (Movimenta B) e) else w
eventosW (EventKey (Char 'h')  Down _ _) w@(m@(Jogo x _,_,_,_,(_,l)),e) = if x >= 6 then (m,comando2jogada 2 0 l (Movimenta D) e) else w

eventosW (EventKey (Char 'i')  Down _ _) w@(m@(Jogo x _,_,_,_,(_,l)),e) = if x >= 6 then (m,comando2jogada 3 0 l (Movimenta C) e) else w
eventosW (EventKey (Char 'j')  Down _ _) w@(m@(Jogo x _,_,_,_,(_,l)),e) = if x >= 6 then (m,comando2jogada 3 0 l (Movimenta E) e) else w
eventosW (EventKey (Char 'k')  Down _ _) w@(m@(Jogo x _,_,_,_,(_,l)),e) = if x >= 6 then (m,comando2jogada 3 0 l (Movimenta B) e) else w
eventosW (EventKey (Char 'l')  Down _ _) w@(m@(Jogo x _,_,_,_,(_,l)),e) = if x >= 6 then (m,comando2jogada 3 0 l (Movimenta D) e) else w

eventosW ka es = es 



-- ** Funções auxiliares de teclas com vários outputs.
-- |'mSelec' : Determina o output da ação "Selecionar"
mSelec :: World -> World
mSelec (((Principal pos _),b,c,d,e),f)  | pos == 1 = (((BotSel 1 0),b,c,d,(1,[1])),f) 
                                        | pos == 2 = (((BotSel 1 0),b,c,d,(2,[1,1])),f) 
                                        | pos == 3 = (((PartySel [0,0,0,0]),b,c,d,(3,[])),f) 
mSelec (((BotSel pos _),b,c,d,(x,l)),f) | pos == 1 = (((MapaSel 1 0),b,c,d,(x,l)),f) 
                                        | pos == 2 = (((MapaSel 1 0),b,c,d,(x,l++[2])),f) 
                                        | pos == 3 = (((MapaSel 1 0),b,c,d,(x,l++[2,2])),f)
                                        | pos == 4 = (((MapaSel 1 0),b,c,d,(x,l++[2,2,2])),f) 
mSelec w@(((PartySel l),b,c,d,(x,lh)),f) = if elem 1 l || elem 2 l then (((MapaSel 1 0),b,c,d,(x,l)),f) else w
mSelec w@(((MapaSel 1 a),_,_,_,_),_) = failsafe 0 w
mSelec (((MapaSel pos _),ls,c,d,(x,l)),f) = ((Jogo 1 0,ls,c,[0,0,0,0],(x,l)),Estado (invmapa !! (pos-2)) (montajogs 0 l)) 
mSelec w = w


-- |'mBack' : Determina o output da ação "Voltar"
mBack :: World -> World
mBack ((BotSel _ _,a,b,c,d@(x,_)),e) = ((Principal x 0,a,b,c,d),e)
mBack ((PartySel _,a,b,c,d),e) = ((Principal 3 0,a,b,c,d),e)
mBack ((MapaSel _ _,a,b,c,(x,l)),e) | x == 1 = ((BotSel (length l) 0,a,b,c,(x,[1])),e)
                                    | x == 2 = ((BotSel (length l -1) 0,a,b,c,(x,[1,1])),e)
                                    | x == 3 = ((PartySel l,a,b,c,(x,[])),e)
mBack w = w

-- |'mRight' : Determina o output da ação "Direita"
mRight :: World -> World
mRight (((BotSel pos x),b,c,d,e@(n,l)),f) | pos == 3 && n == 2 = ((BotSel 1 x,b,c,d,e),f)
                                          | pos == 4 = ((BotSel 1 x,b,c,d,e),f)
                                          | otherwise = ((BotSel (pos+1) x,b,c,d,e),f)
mRight ((MapaSel pos x,b,c,d,e),f) | pos == 6 = ((MapaSel 1 x,b,c,d,e),f)
                                   | otherwise = ((MapaSel (pos+1) x,b,c,d,e),f)
mRight w@((Jogo x y,a,b,c,d@(_,l)),f) = if x >= 6 then ((Jogo x y,a,b,c,d),comando2jogada 0 0 l (Movimenta D) f) else w
mRight w = w


-- |'mLeft' : Determina o output da ação "Esquerda"
mLeft :: World -> World
mLeft (((BotSel pos x),b,c,d,e@(n,l)),f) | pos == 1 && n == 2 = ((BotSel 3 x,b,c,d,e),f)
                                         | pos == 1 = ((BotSel 4 x,b,c,d,e),f)
                                         | otherwise = ((BotSel (pos-1) x,b,c,d,e),f)
mLeft ((MapaSel pos x,b,c,d,e),f) | pos == 1 = ((MapaSel 6 x,b,c,d,e),f)
                                  | otherwise = ((MapaSel (pos-1) x,b,c,d,e),f)
mLeft w@((Jogo x y,a,b,c,d@(_,l)),f) = if x >= 6 then ((Jogo x y,a,b,c,d),comando2jogada 0 0 l (Movimenta E) f) else w
mLeft w = w

-- |'mUp' : Determina o output da ação "Cima"
mUp :: World -> World
mUp (((Principal pos x),b,c,d,e),f) | pos == 1 = ((Principal 3 x,b,c,d,e),f)
                                    | otherwise = ((Principal (pos-1) x,b,c,d,e),f)
mUp (((BotSel pos x),b,c,d,e@(s,_)),f) | s == 1 && pos-2 <= 0 = (((BotSel (pos+2) x),b,c,d,e),f) 
                                       | s == 1 = (((BotSel (pos-2) x),b,c,d,e),f) 
                                       | s == 2 && pos-2 <= 0 = (((BotSel 3 x),b,c,d,e),f) 
                                       | s == 2 = (((BotSel 1 x),b,c,d,e),f) 
mUp ((MapaSel pos x,b,c,d,e),f) | pos - 3 <= 0 = ((MapaSel (pos+3) x,b,c,d,e),f)         
                                | otherwise = ((MapaSel (pos-3) x,b,c,d,e),f)      
mUp w@((Jogo x y,a,b,c,d@(_,l)),f) = if x >= 6 then ((Jogo x y,a,b,c,d),comando2jogada 0 0 l (Movimenta C) f) else w                          
mUp w = w

-- |'mDown' : Determina o output da ação "Baixo"
mDown :: World -> World
mDown (((Principal pos x),b,c,d,e),f) | pos == 3 = ((Principal 1 x,b,c,d,e),f)
                                      | otherwise = ((Principal (pos+1) x,b,c,d,e),f)
mDown (((BotSel pos x),b,c,d,e@(s,_)),f) | s == 1 && pos+2 >= 5 = (((BotSel (pos-2) x),b,c,d,e),f) 
                                         | s == 1 = (((BotSel (pos+2) x),b,c,d,e),f) 
                                         | s == 2 && pos+2 >= 5 = (((BotSel 1 x),b,c,d,e),f) 
                                         | s == 2 = (((BotSel 3 x),b,c,d,e),f) 
mDown ((MapaSel pos x,b,c,d,e),f) | pos + 3 >= 7 = ((MapaSel (pos-3) x,b,c,d,e),f)         
                                  | otherwise = ((MapaSel (pos+3) x,b,c,d,e),f)  
mDown w@((Jogo x y,a,b,c,d@(_,l)),f) = if x >= 6 then ((Jogo x y,a,b,c,d),comando2jogada 0 0 l (Movimenta B) f) else w
mDown w = w


-- |'m0Ace' : Determina o output da ação do jogador 1 ao "Acelerar"
m0Ace :: World -> World
m0Ace ((PartySel l,a,b,c,d),f) = if encontraIndiceLista 0 l == 1 then ((PartySel (atualizaIndiceLista 0 0 l),a,b,c,d),f) 
                                                                  else ((PartySel (atualizaIndiceLista 0 1 l),a,b,c,d),f)
m0Ace w@((Jogo x y,a,b,c,d@(_,l)),f) = if x >= 6 then ((Jogo x y,a,b,c,d),comando2jogada 0 0 l (Acelera) f) else w
m0Ace w = w

-- |'m0Dis' : Determina o output da ação do jogador 1 ao "Disparar"
m0Dis :: World -> World
m0Dis ((PartySel l,a,b,c,d),f) = if encontraIndiceLista 0 l == 2 then ((PartySel (atualizaIndiceLista 0 0 l),a,b,c,d),f) 
                                                                  else ((PartySel (atualizaIndiceLista 0 2 l),a,b,c,d),f)
m0Dis w@((Jogo x y,a,b,c,d@(_,l)),f) = if x >= 6 then ((Jogo x y,a,b,c,d),comando2jogada 0 0 l (Dispara) f) else w
m0Dis w = w

-- |'m1Ace' : Determina o output da ação do jogador 2 ao "Acelerar"
m1Ace :: World -> World
m1Ace ((PartySel l,a,b,c,d),f) = if encontraIndiceLista 1 l == 1 then ((PartySel (atualizaIndiceLista 1 0 l),a,b,c,d),f) 
                                                                   else ((PartySel (atualizaIndiceLista 1 1 l),a,b,c,d),f)
m1Ace w@((Jogo x y,a,b,c,d@(_,l)),f) = if x >= 6 then ((Jogo x y,a,b,c,d),comando2jogada 1 0 l (Acelera) f) else w
m1Ace w = w

-- |'m1Dis' : Determina o output da ação do jogador 2 ao "Disparar"
m1Dis :: World -> World
m1Dis ((PartySel l,a,b,c,d),f) = if encontraIndiceLista 1 l == 2 then ((PartySel (atualizaIndiceLista 1 0 l),a,b,c,d),f) 
                                                              else ((PartySel (atualizaIndiceLista 1 2 l),a,b,c,d),f)
m1Dis w@((Jogo x y,a,b,c,d@(_,l)),f) = if x >= 6 then ((Jogo x y,a,b,c,d),comando2jogada 1 0 l (Dispara) f) else w
m1Dis w = w

-- |'m2Ace' : Determina o output da ação do jogador 3 ao "Acelerar"
m2Ace :: World -> World
m2Ace ((PartySel l,a,b,c,d),f) = if encontraIndiceLista 2 l == 1 then ((PartySel (atualizaIndiceLista 2 0 l),a,b,c,d),f) 
                                                                 else ((PartySel (atualizaIndiceLista 2 1 l),a,b,c,d),f)
m2Ace w@((Jogo x y,a,b,c,d@(_,l)),f) = if x >= 6 then ((Jogo x y,a,b,c,d),comando2jogada 2 0 l (Acelera) f) else w
m2Ace w = w

-- |'m2Dis' : Determina o output da ação do jogador 3 ao "Disparar"
m2Dis :: World -> World
m2Dis ((PartySel l,a,b,c,d),f) = if encontraIndiceLista 2 l == 2 then ((PartySel (atualizaIndiceLista 2 0 l),a,b,c,d),f) 
                                                                  else ((PartySel (atualizaIndiceLista 2 2 l),a,b,c,d),f)
m2Dis w@((Jogo x y,a,b,c,d@(_,l)),f) = if x >= 6 then ((Jogo x y,a,b,c,d),comando2jogada 2 0 l (Dispara) f) else w
m2Dis w = w

-- |'m3Ace' : Determina o output da ação do jogador 4 ao "Acelerar"
m3Ace :: World -> World
m3Ace ((PartySel l,a,b,c,d),f) = if encontraIndiceLista 3 l == 1 then ((PartySel (atualizaIndiceLista 3 0 l),a,b,c,d),f) 
                                                                  else ((PartySel (atualizaIndiceLista 3 1 l),a,b,c,d),f)
m3Ace w@((Jogo x y,a,b,c,d@(_,l)),f) = if x >= 6 then ((Jogo x y,a,b,c,d),comando2jogada 3 0 l (Acelera) f) else w
m3Ace w = w

-- |'m3Dis' : Determina o output da ação do jogador 4 ao "Disparar"
m3Dis :: World -> World
m3Dis ((PartySel l,a,b,c,d),f) = if encontraIndiceLista 3 l == 2 then ((PartySel (atualizaIndiceLista 3 0 l),a,b,c,d),f) 
                                                                  else ((PartySel (atualizaIndiceLista 3 2 l),a,b,c,d),f)
m3Dis w@((Jogo x y,a,b,c,d@(_,l)),f) = if x >= 6 then ((Jogo x y,a,b,c,d),comando2jogada 3 0 l (Dispara) f) else w
m3Dis w = w





-- *** Funções auxiliares para realizar as ações.
-- |'montajogs' : Quando recebe a ordem de execução do jogo, monta os jogadores.
montajogs :: Int -> [Int] -> [Jogador]
montajogs n [] = []
montajogs n (h:t) = if h == 0 then montajogs (n+1) t else (Jogador n 0 0 3 (Chao False)) : montajogs (n+1) t 

-- |'comando2jogada' : Dada um certo comando, avalia se esse comando é válido para certo jogador no momento e executa-o, caso seja válido.
comando2jogada :: Int -> Int -> [Int] -> Jogada -> Estado -> Estado
comando2jogada _ _ [] _ e = e
comando2jogada n x (h:t) jog e | n == 0 && h == 1 = jogada x jog e
                               | n /= 0 && h == 0 = comando2jogada (n-1) x t jog e  
                               | n /= 0 = comando2jogada (n-1) (x+1) t jog e
                               | otherwise = e 

-- |'failsafe' : Função utilizada para gerar um mapa genérico caso as 20 sementes sejam inválidas.
failsafe :: Int -> World -> World
failsafe 20 (((MapaSel 1 a),(b:ls),c,d,(x,l)),f) = ((Jogo 1 0,ls++[b],c,[0,0,0,0],(x,l)),Estado (gera 4 60 100) (montajogs 0 l)) 
failsafe n (((MapaSel 1 a),(b:ls),c,d,(x,l)),f) = if mapaMaxAltura 0 (gera 4 60 b) > 8 then mSelec (((MapaSel 1 a),(ls++[b]),c,d,(x,l)),f) 
                                                                                       else ((Jogo 1 0,ls++[b],c,[0,0,0,0],(x,l)),Estado (gera 4 60 b) (montajogs 0 l))

-- |'mapaMaxAltura' : Determina o valor da altura máxima de um mapa. Usado para restringir o gera com mapas de altura elevada.
mapaMaxAltura :: Int -> Mapa -> Int
mapaMaxAltura n [[]] = n
mapaMaxAltura n ([]:t) =  mapaMaxAltura n t
mapaMaxAltura n ((Recta _ h:t):t1) =    if h > n then mapaMaxAltura h (t:t1) else mapaMaxAltura n (t:t1)
mapaMaxAltura n ((Rampa _ hi hf:t):t1) = if hi > hf then if hi > n then mapaMaxAltura hi (t:t1) else mapaMaxAltura n (t:t1)
                                                    else if hf > n then mapaMaxAltura hf (t:t1) else mapaMaxAltura n (t:t1)








-- * Função que reage ao tempo no jogo. Usado nos menus para o efeito visual do seletor e no jogo para as ações dos bots e as físicas do jogo.
-- |'tempoW' : Dentro de certos menus/jogo, decido o output do tempo.
tempoW :: Float -> World -> World
tempoW t w@((Principal a x,b,c,d,e),f) | fromIntegral x == fromIntegral fr*tciclo = ((Principal a 0,b,c,d,e),f)
                                       | otherwise = ((Principal a (x+1),b,c,d,e),f)
tempoW t w@((BotSel a x,b,c,d,e),f)    | fromIntegral x == fromIntegral fr*tciclo = ((BotSel a 0,b,c,d,e),f)
                                       | otherwise = ((BotSel a (x+1),b,c,d,e),f)
tempoW t w@((MapaSel a x,b,c,d,e),f)   | fromIntegral x == fromIntegral fr*tciclo = ((MapaSel a 0,b,c,d,e),f)
                                       | otherwise = ((MapaSel a (x+1),b,c,d,e),f)
tempoW t w@(m@(Jogo x _,_,_,_,_),e) = if x >= 6 then atualizaMeta (avancaContador m,atualizaTempoJogs t (avaliaJogadaBots w)) else (avancaContador m,e) 
tempoW t w = w

-- |'atualizaTempoJogs' : Atualiza o Estado do jogo.
atualizaTempoJogs :: Float -> Estado -> Estado
atualizaTempoJogs t (Estado mapa jogs) = (Estado mapa (atualizaListaJogs t mapa jogs))

-- |'atualizaListaJogs' : Atualiza as posições individuais dos jogadores
atualizaListaJogs :: Float -> Mapa -> [Jogador] -> [Jogador]
atualizaListaJogs t mapa [] = []
atualizaListaJogs t mapa (h@(Jogador _ dist _ _ _):x) = if fromIntegral (length (head mapa)) == dist then [h] ++ atualizaListaJogs t mapa x
                                   else [passo (realToFrac t) mapa h] ++ atualizaListaJogs t mapa x

-- |'avancaContador' : Dependendo da fase em que vai, altera o contador.
avancaContador :: Memória -> Memória
avancaContador (Jogo x y,a,b,c,d@(_,l)) | (x >= 1 && x <= 3) || x == 7 = if y == floor (fromIntegral fr*1.5) then (Jogo (x+1) 0,a,b,c,d) else (Jogo x (y+1),a,b,avancaCronometros x c l,d)
                                        | x >= 4 && x <= 6 = if y == fr then (Jogo (x+1) 0,a,b,c,d) else (Jogo x (y+1),a,b,avancaCronometros x c l,d)
                                        | x == 8 = if y == floor (fromIntegral fr*0.2) then (Jogo 8 0,a,b,c,d) else (Jogo x (y+1),a,b,avancaCronometros x c l,d)

-- |'avancaCronometros' : Avança os crónometros por uma unidade dos jogadores ativos.
avancaCronometros :: Int -> [Int] -> [Int] -> [Int]
avancaCronometros _ [] [] = []
avancaCronometros _ l [] = []
avancaCronometros x (h:t) (h1:t1) | x <= 5 = [0,0,0,0]
                                  | h1 == 1 || h1 == 2 = (h+1) : avancaCronometros x t t1
                                  | otherwise = h : avancaCronometros x t t1

-- |'avaliaJogadaBots' : Caso seja vez dos bots jogarem, executa as jogadas.
avaliaJogadaBots :: World -> Estado
avaliaJogadaBots ((Jogo _ x,_,_,_,(_,l)),e) = if fromIntegral x == (floor (realToFrac fr*0.2)) then jogadaBots 0 l e else e

-- |'jogadaBots' : Percorre os jogadores e executa jogadas aos bots.
jogadaBots :: Int -> [Int] -> Estado -> Estado
jogadaBots n [] e = e
jogadaBots n (h:t) e | h == 2  = jogadaBots (n+1) t (jogada n (notMaybe (bot n e)) e) -- && bot n e /= Nothing
                     | h == 0 = jogadaBots n t e
                     | otherwise = jogadaBots (n+1) t e 

-- |'notMaybe' : Retira o Maybe.
notMaybe :: Maybe Jogada -> Jogada
notMaybe (Just x) = x
notMaybe Nothing = Acelera


-- |'atualizaMeta' : Verifica se algum jogador já ultrapassou a meta.
atualizaMeta :: World -> World
atualizaMeta ((Jogo a b,c,d,e,(f,lj)),Estado mapa jogs) = ((Jogo a b,c,d,e,(f,aux lj lj jogs (length(head mapa)))),Estado mapa jogs)
                               where aux laux l [] n = []
                                     aux laux [] l n = []
                                     aux laux ljogs@(h:lj) j@(Jogador _ dist _ _ _:t) n = if h == 0 then 0 : aux laux lj j n else if h >= 4 && dist == fromIntegral n then h : aux laux lj t n
                                                                                   else if dist == fromIntegral n then if maximum laux < 4 then 4 : aux laux lj t n 
                                                                                                                       else maximum laux +1 : aux laux lj t n 
                                                                                        else h: aux laux lj t n
                                                                                        