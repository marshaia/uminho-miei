module Tarefa4_2019li1g052 where

import Tarefa0_2019li1g052
import Tarefa1_2019li1g052
import Tarefa2_2019li1g052
import LI11920

{- |

= __INTRODUÇÃO: __
O objetivo principal desta tarefa consistia em calcular o efeito da passagem de um instante
de tempo num estado do jogo. A tarefa estava dividida em duas partes: uma que calcula a nova velocidade
do jogador tendo em conta a sua posição actual no mapa, o seu estado e velocidade atual; outra
que usa a velocidade calculada para movimentar o jogador no mapa.

= __OBJECTIVOS: __
O nosso objetivo nesta tarefa consistiu em desenvolver as funções e o seu código de forma eficiente
tentando ao máximo alcançar os resultados supostos e pretendidos pelo site da unidade curricular.
No cerne desta tarefa encontram-se várias expressões de natureza matemática e/ou física (velocidade,
gravidade, aceleração, entre outras), as quais já tinham sido adquiridas em anos letivos anteriores.

Para calcular as novas distâncias, dividimos os cálculos em duas funções, quando o jogador está no chão ou quando está no ar. 
Quando o jogador está no chão apenas são realizados os cálculos especificados no site, quando este está no ar é utilizada a função
'queda' que avalia vários parâmetros como interseções com a pista, se chegou ao fim da peça atual ou em caso nenhum destes aconteça,
calcula a nova posição atráves das equações de física. 

= __CONCLUSÃO: __ 
Consideramos ter atingido o objetivo principal desta tarefa na medida em que fizemos o nosso melhor 
no que toca a otimização do código e funções auxiliares criadas e, segundo os teste do site da 
disciplina termos obtido os resultados esperados nas funções 'move', 'passo' e 'acelera'.

-}

relatório_Tarefa4 :: String
relatório_Tarefa4 = "Relatório"



-- * Testes
-- | Testes unitários da Tarefa 4.
-- Cada teste é um par (/tempo/,/'Mapa'/,/'Jogador'/).
testesT4 :: [(Double,Mapa,Jogador)]
testesT4 = [(0.5,  mapateste1, Jogador 0 0 0 0 (Morto 1)),        (0.8,  mapateste1, Jogador 0 0 0 0 (Morto 0.5)),
            (0.6,  mapateste1, Jogador 0 5.1 1.4 0 (Chao False)), (0.6,  mapateste1, Jogador 0 5.1 2 0 (Chao True)),
            (0.4,  mapateste1, Jogador 0 4.9 1 0 (Chao True)),    (0.4,  mapateste1, Jogador 0 3.9 1 0 (Chao True)),
            (0.5,  mapateste1, Jogador 0 7.9 2 0 (Chao False)),   (0.5,  mapateste1, Jogador 0 8.6 1.4 0 (Chao True)),
            (0.4,  mapateste1, Jogador 0 1.8 3 0 (Chao True)),    (0.8, [[Recta Terra 0,Rampa Terra 0 2,Recta Terra 2]], Jogador 0 1.8 1 0 (Ar 5 20 0)),
            (0.6,  [[Recta Terra 0, Recta Cola 0,Recta Cola 0]] , Jogador 0 1.2 1.6 0 (Chao False)),
            (0.6,  [[Recta Terra 0, Recta Terra 0]], Jogador 0 0.1 1 0 (Ar 2 40 0)),
            (1.5,  [[Recta Terra 0, Recta Terra 0]], Jogador 0 0.1 0.1 0 (Ar 2 0 0)),
            (0.5,  [[Recta Terra 0, Recta Terra 0]], Jogador 0 0.8 1 0 (Ar 2 40 0)),
            (0.5,  mapateste1, Jogador 0 4.4 1 0 (Ar 1.1 (-20) 0)), (0.4, [[Recta Terra 0,Rampa Terra 0 2,Recta Terra 2]], Jogador 0 1.3 0.6 0 (Ar 5 20 0)),
            (0.5,  mapateste1, Jogador 0 4.4 1 0 (Ar 1.1 50 0)),
            (0.8,  mapateste1, Jogador 0 5.8 2 0 (Ar 3.5 (-30) 0.5)),
            (0.8,  [[Recta Terra 0,Recta Terra 0]], Jogador 0 0.1 1 0 (Ar 0.5 (-80) 0)),
            (20,  [[Recta Terra 0,Recta Terra 0]], Jogador 0 0.1 0.00001 0 (Ar 5 0 0)),
            (0.6,  [[Recta Terra 0,Rampa Terra 0 2,Rampa Terra 2 1,Rampa Terra 1 3]], Jogador 0 2.8 1 0 (Chao True)),
            (0.6,  [[Recta Terra 0,Rampa Terra 0 1,Rampa Terra 1 0,Recta Terra 0]], Jogador 0 2.8 1 0 (Chao True))] 
         where mapateste1 = gera 1 16 66
               

-- * Função principal da Tarefa 4.
-- | Avança o estado de um 'Jogador' um 'passo' em frente, durante um determinado período de tempo.
passo :: Double -- ^ O tempo decorrido.
     -> Mapa    -- ^ O mapa utilizado.
     -> Jogador -- ^ O estado anterior do 'Jogador'.
     -> Jogador -- ^ O estado do 'Jogador' após um 'passo'.
passo t m j = move t m (acelera t m j)



-- * Função 'acelera' e as suas auxiliares.
-- | Altera a velocidade de um 'Jogador', durante um determinado período de tempo.
acelera :: Double -- ^ O tempo decorrido.
     -> Mapa    -- ^ O mapa utilizado.
     -> Jogador -- ^ O estado anterior do 'Jogador'.
     -> Jogador -- ^ O estado do 'Jogador' após acelerar.

acelera _ _ q@(Jogador _ _ _ _ (Morto x)) = q
acelera t mapa q@(Jogador npista dist vel ncola (Chao (x))) = Jogador npista dist v ncola (Chao x)
          where v = velocidade t mapa q
acelera t mapa q@(Jogador npista dist vel ncola (Ar alt ang grav)) = Jogador npista dist v ncola (Ar alt ang (grav+t))
          where v = velocidade t mapa q



-- ** Funcão auxiliar "velocidade" 
-- | 'velocidade' : Com a informação da função acelera, calcula a velocidade caso o jogador esteja no Chão ou no Ar. Evita também que haja velocidades negativas.
velocidade :: Double -> Mapa -> Jogador -> Double
velocidade t mapa q@(Jogador npista dist vel _ e) 
     = case e of 
       (Chao x) -> if vel + ((acelMota q) - atrito (encontraPosicaoMatriz (npista,floor (dist)) mapa) * vel) * t <= 0
                   then 0
                   else vel + ((acelMota q) - atrito (encontraPosicaoMatriz (npista,floor (dist)) mapa) * vel) * t
       (Ar _ _ _) -> if vel - (0.125 * vel * t) <= 0
                     then 0 
                     else vel - (0.125 * vel * t) 



-- *** Funções auxiliares a função velocidade
-- | 'acelMota' : avalia se o jogador tem (Chao True) ou (Chao False) e reage com as fórmulas dadas.                    
acelMota :: Jogador -> Double
acelMota (Jogador _ _ vel _ (Chao x))
     | vel < 2 && x == True = 1
     | otherwise = 0

-- | 'atrito' : Devolve o valor do atrito da peça recebida.
atrito :: Peca -> Double
atrito (Rampa x _ _) = atritoaux x
atrito (Recta x _) = atritoaux x

-- | 'atritoaux' : Guarda a informação dos atritos. 
atritoaux :: Piso -> Double
atritoaux x | x == Terra = 0.25 
            | x == Relva = 0.75
            | x == Lama = 1.50
            | x == Boost = (-0.50)
            | otherwise = 3.00




-- * Função 'move' e as suas auxiliares.
-- | Altera a posição de 'Jogador', durante um determinado período de tempo.
move :: Double -- ^ O tempo decorrido.
     -> Mapa    -- ^ O mapa utilizado.
     -> Jogador -- ^ O estado anterior do 'Jogador'.
     -> Jogador -- ^ O estado do 'Jogador' após se movimentar.

move t mapa (Jogador npista dist vel ncola (Morto x)) 
          | t >= x = (Jogador npista dist vel ncola (Chao False))
          | otherwise = (Jogador npista dist vel ncola (Morto (x-t)))

move t mapa q@(Jogador npista dist vel ncola (Chao x)) = Jogador npista (novadist t (encontraPosicaoMatriz (npista,floor dist) mapa) q) vel ncola (novoestado t mapa q)
move t mapa q@(Jogador npista dist vel ncola (Ar alt ang grav)) = queda t (encontraPosicaoMatriz (npista,floor dist) mapa) q 



-- ** Funções auxiliares da função 'move' para quando o jogador está no chão.
-- | 'novadist' : Com o tempo, a informação do jogador e a sua peça atual, calcula a sua nova distância, tendo em conta que pode chegar ao fim da peça
novadist :: Double -> Peca -> Jogador -> Double
novadist t p (Jogador _ dist vel _ (Chao x)) | vel * t * cos (deg2rad (inclinacaoPeca p)) + dist >= roof dist = roof dist            
                                             | otherwise = vel * t * cos (deg2rad (inclinacaoPeca p)) + dist
novadist t p (Jogador _ dist vel _ (Ar alt ang grav)) | vel * t * cos (deg2rad ang) + dist >= roof dist = roof dist            
                                                      | otherwise = vel * t * cos (deg2rad ang) + dist

-- | 'novoestado' : Recebendo as informações da função move, preve e calcula o novo estadoJogador.                                   
novoestado :: Double -> Mapa -> Jogador -> EstadoJogador
novoestado t mapa q@(Jogador npista dist vel ncola (Chao x))
           | novadist t (encontraPosicaoMatriz (npista, floor dist) mapa) q == roof dist = avaliapecas (encontraPosicaoMatriz (npista,floor dist) mapa) (encontraPosicaoMatriz (npista, ceiling dist) mapa) q
           | otherwise = (Chao x)
           
          
-- | 'avaliapecas' : No caso de o Jogador chegar ao fim da peça, utiliza esta função para calcular se o jogador fica no Chao ou no Ar.
avaliapecas :: Peca -> Peca -> Jogador -> EstadoJogador 
avaliapecas a@(Rampa _ h hf) (Recta _ h1) (Jogador npistas dist vel ncola e)
          | (inclinacaoPeca a) > 0 = Ar (fromIntegral h1) (inclinacaoPeca a) 0
          | otherwise = e
avaliapecas (Recta _ h) b@(Rampa _ h1 hf1) (Jogador npistas dist vel ncola e)
          | (inclinacaoPeca b) < 0 = Ar (fromIntegral h) 0 0
          | otherwise = e 
avaliapecas a@(Rampa _ h hf) b@(Rampa _ h1 hf1) (Jogador npistas dist vel ncola e)
          | (inclinacaoPeca a) > (inclinacaoPeca b) = Ar (fromIntegral hf) (inclinacaoPeca a) 0
          | otherwise = e
avaliapecas a b (Jogador _ _ _ _ e) = e 





-- ** Funções auxiliares da função 'move' para quando o jogador está no ar.
-- | 'queda' : Função utilizada no cálculo de trajetórias aéreas, avalia o tempo e a peça atual do jogador para detetar interseções com a pista.
queda :: Double -> Peca -> Jogador -> Jogador
queda t p@(Recta _ h) q@(Jogador npista dist vel ncola (Ar alt ang grav)) 
               | alt < fromIntegral h = Jogador npista dist (velqueda p q) ncola (estadoqueda p q)
               | intersetam (Cartesiano dist alt,Cartesiano (vel * t * cos (deg2rad ang) + dist) (vel * t * sin (deg2rad ang)-(grav * t) + alt)) 
                            (Cartesiano (ground dist) (fromIntegral h),Cartesiano (roof dist) (fromIntegral h)) && dist /= (ground dist)
                            = Jogador npista (distqueda t p q) (velqueda p q) ncola (estadoqueda p q)
               | (vel * t * cos (deg2rad ang) + dist) >= (roof dist) = Jogador npista (novadist t p q) vel ncola (Ar (alturaqueda t q) ang grav)
               | otherwise = Jogador npista (vel * t * cos (deg2rad ang) + dist) vel ncola (Ar (vel * t * sin (deg2rad ang)-(grav * t) + alt) ang grav)
queda t p@(Rampa _ hi hf) q@(Jogador npista dist vel ncola (Ar alt ang grav)) 
               | alt < (fromIntegral (hf - hi)) * (dist - ground dist) = Jogador npista dist (velqueda p q) ncola (estadoqueda p q)
               | intersetam (Cartesiano dist alt,Cartesiano (vel * t * cos (deg2rad ang) + dist) (vel * t * sin (deg2rad ang)-(grav * t) + alt)) 
                            (Cartesiano (ground dist) (fromIntegral hi),Cartesiano (roof dist) (fromIntegral hf)) && dist /= (ground dist)
                            = Jogador npista (distqueda t p q) (velqueda p q) ncola (estadoqueda p q)
               | (vel * t * cos (deg2rad ang) + dist) >= (roof dist) = Jogador npista (novadist t p q) vel ncola (Ar (alturaqueda t q) ang grav)
               | otherwise = Jogador npista (vel * t * cos (deg2rad ang) + dist) vel ncola (Ar (vel * t * sin (deg2rad ang)-(grav * t) + alt) ang grav)




-- *** Funções auxiliares da função 'queda'
-- | a função 'distqueda' calcula o ponto de interseção entre o Jogador e a Peça no caso em que se intersetam.
distqueda :: Double -> Peca -> Jogador -> Double
distqueda t (Recta _ h) q@(Jogador npista dist vel ncola (Ar alt ang grav)) = auxdist (intersecao (Cartesiano dist alt,Cartesiano (vel * t * cos (deg2rad ang) + dist) (vel * t * sin (deg2rad ang)-(grav * t) + alt)) (Cartesiano (ground dist) (fromIntegral h),Cartesiano (roof dist) (fromIntegral h)))
distqueda t (Rampa _ hi hf) q@(Jogador npista dist vel ncola (Ar alt ang grav)) = auxdist (intersecao (Cartesiano dist alt,Cartesiano (vel * t * cos (deg2rad ang) + dist) (vel * t * sin (deg2rad ang)-(grav * t) + alt)) (Cartesiano (ground dist) (fromIntegral hi),Cartesiano (roof dist) (fromIntegral hf)))

-- | a função 'alturaqueda' calcula o ponto de interseção entre o Jogador e a reta vertical definida no fim da peça.
alturaqueda :: Double -> Jogador -> Double
alturaqueda t (Jogador _ dist vel _ (Ar alt ang grav)) = auxaltura (intersecao (Cartesiano dist alt,Cartesiano (vel * t * cos (deg2rad ang) + dist) (vel * t * sin (deg2rad ang)-(grav * t) + alt)) (Cartesiano (roof dist) (-9999),Cartesiano (roof dist) 9999))

-- | a função 'auxaltura' auxilia a função 'alturaqueda' no cálculo da distância requerida.
auxaltura :: Ponto -> Double
auxaltura (Cartesiano x y) = y

-- | a função 'auxdist' auxilia a função 'distqueda' no cálculo da distância requerida.
auxdist :: Ponto -> Double
auxdist (Cartesiano x y) = x

-- | a função 'estadoqueda' calcula o estado do Jogador resultante da sua interseção com a Peça.
estadoqueda :: Peca -> Jogador -> EstadoJogador
estadoqueda (Recta _ h) (Jogador npista dist vel ncola (Ar alt ang grav)) | ang > 45 || ang < (-45) = Morto 1
                                                                          | otherwise = Chao False
estadoqueda p@(Rampa _ hi hf) (Jogador npista dist vel ncola (Ar alt ang grav)) | ang > (inclinacaoPeca p) + 45 || ang < (inclinacaoPeca p) - 45 = Morto 1
                                                                                | otherwise = Chao False
-- | função que altera a velocidade do jogador dependendo da sua aterragem.
velqueda :: Peca -> Jogador -> Double
velqueda peca q@(Jogador _ _ vel _ _) = if estadoqueda peca q == Morto 1 then 0 else vel                                                                            




-- *** Funções gerais menores/auxiliares.
-- | 'roof': Função semelhante à "ceiling", mas adaptada para devolver um Double.     
roof :: Double -> Double
roof x = fromIntegral (floor x) + 1

-- | 'ground': Funcão semelhante à "floor", mas adaptada para devolver um Double.
ground :: Double -> Double
ground x = fromIntegral (floor x) 
