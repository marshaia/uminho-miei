module Tarefa2_2019li1g052 where
        
import Tarefa1_2019li1g052
import Tarefa0_2019li1g052
import LI11920

{- |
= __INTRODUÇÃO: __
O objectivo desta tarefa consistia em, dado um jogador e um estado do jogo, avaliar a jogada requerida pelo jogador
nesse instante e permitir ou não a sua execução.

= __OBJECTIVOS: __
De acordo com os diversos comandos (Dispara,Acelera,Desacelera,Movimenta C/B/D/E) tentamos separar cada caso em funções
diferentes, de modo a organizar melhor o código e torná-lo mais eficiente. Relativamente ao comando Dispara, criamos uma função 
'disparaValido' que, dado um Jogador e o estado do jogo, avalia se é possível ou não a execução deste comando, se sim, executa-o com a 
ajuda da função 'colaMapa'.
Relativamente aos comandos Acelera/Desacelera, criamos as funções 'aceleraX' e 'desacelera' que verificam a possibilidade da execução
do comando Acelera ou Desacelera, respetivamente, e se sim, executam-no, mudando assim o estado do Jogador para Chao True/False 
dependendo do comando requerido.
Passando aos comandos Movimenta, dividimo-los nas quatro possibilidades (C,B,D,E). Com isto, começamos pelas Movimenta D e E utlizando 
as funções 'movD' e 'movE' respetivamente, que avaliam se o comando é executável (ou não) tendo em conta o estado do jogo e o jogador em
causa. Nos Movimenta C e B criamos as restantes funções que funcionam de maneira análoga às anteriores, estas avaliam as duas peças 
(a peça do jogador atual e a peça alvo) e avaliam a diferença de altura entre estas. Dependendo do valor que devolvem é decidido o output da jogada.

= __CONCLUSÃO: __
Após a resolução desta tarefa, acrescentamos testes que pensamos serem oportunos, na medida em que utilizavam grande parte do código e, 
para além disso, tentamos sempre acrescentar testes que se parecessem com situações reais durante o realizar do jogo. Assim, verificamos 
que com a nossa função principal obtínhamos os resultados esperados (nos testes) através do site da disciplina.
-}

relatório_Tarefa2 :: String
relatório_Tarefa2 = "Relatório"

-- * Testes

-- | Testes unitários da Tarefa 2.
--
-- Cada teste é um triplo (/identificador do 'Jogador'/,/'Jogada' a efetuar/,/'Estado' anterior/).
testesT2 :: [(Int,Jogada,Estado)]
testesT2 = [(0,Acelera,    (Estado mapateste [Jogador 0 2 1 1 (Chao False),jogdefault])),(0,Acelera,    (Estado mapateste [Jogador 0 2 1 1 (Chao True),jogdefault])),
            (0,Acelera,    (Estado mapateste [Jogador 0 3 0 0 (Morto 1),jogdefault])),(0,Desacelera, (Estado mapateste [Jogador 0 2 1 1 (Chao False),jogdefault])),
            (0,Desacelera, (Estado mapateste [Jogador 0 2 0 1 (Morto 1),jogdefault])),(0,Desacelera, (Estado mapateste [Jogador 0 2 1 1 (Chao True),jogdefault])),
            (0,Dispara,    (Estado mapateste [Jogador 0 3.5 1 0 (Chao True),jogdefault])),(0,Dispara,    (Estado mapateste [Jogador 0 2 1 1 (Chao True),jogdefault])),
            (0,Dispara,    (Estado mapateste [Jogador 1 5 1 1 (Chao True),jogdefault])),(0,Dispara,    (Estado mapateste [Jogador 0 2 1 0 (Ar 2 0 0),jogdefault])),
            (0,Dispara,    (Estado mapateste [Jogador 0 0.3 1 3 (Chao True),jogdefault])),(0,Dispara,    (Estado mapateste [Jogador 0 3.2 1 3 (Chao True),jogdefault])),
            (0,Movimenta C,(Estado mapateste [Jogador 0 2 1 1 (Chao True),jogdefault])),(0,Movimenta C,(Estado mapateste [Jogador 1 1.5 1 1 (Chao True),jogdefault])),
            (0,Movimenta C,(Estado mapateste [Jogador 1 3.11 1 1 (Chao True),jogdefault])),(0,Movimenta C,(Estado mapateste [Jogador 1 2 0 1 (Morto 1),jogdefault])),
            (0,Movimenta C,(Estado mapateste [Jogador 1 4.9 1 1 (Chao True),jogdefault])),(0,Movimenta C,(Estado [[Recta Terra 0,Recta Terra 0],[Recta Terra 0, Rampa Terra 0 2]] [Jogador 1 1.5 1 1 (Chao True),jogdefault])),
            (0,Movimenta B,(Estado mapateste [Jogador 1 2 1 1 (Chao True),jogdefault])),(0,Movimenta B,(Estado mapateste [Jogador 0 1.5 1 1 (Chao True),jogdefault])),
            (0,Movimenta B,(Estado mapateste [Jogador 0 4.5 1 1 (Chao True),jogdefault])),(0,Movimenta B,(Estado mapateste [Jogador 0 2.5 1 1 (Chao True),jogdefault])),
            (0,Movimenta B,(Estado [[Recta Terra 0,Rampa Terra 0 1],[Recta Terra 0, Rampa Terra 0 1]] [Jogador 0 1.5 1 1 (Chao True),jogdefault])),(0,Movimenta E,(Estado mapateste [Jogador 0 3 5 0 (Ar 2.5 80 0),jogdefault])),
            (0,Movimenta E,(Estado mapateste [Jogador 0 3 5 0 (Ar 2.5 15 0),jogdefault])),(0,Movimenta E,(Estado mapateste [Jogador 0 3 5 0 (Ar 2.5 90 0),jogdefault])),
            (0,Movimenta E,(Estado mapateste [Jogador 0 3 0 0 (Morto 1),jogdefault])),(0,Movimenta D,(Estado mapateste [Jogador 0 3 5 0 (Ar 2.5 (-80) 0),jogdefault])),
            (0,Movimenta D,(Estado mapateste [Jogador 0 3 5 0 (Ar 2.5 0 0),jogdefault])),(0,Movimenta D,(Estado mapateste [Jogador 0 3 5 0 (Ar 2.5 (-90) 0),jogdefault])),(0,Movimenta D,(Estado mapateste [Jogador 0 3 0 0 (Morto 1),jogdefault]))]
                       where mapateste = gera 2 8 4
                             jogdefault = Jogador 0 0 0 5 (Chao False)


-- * Funções principais da Tarefa 2.
-- | Efetua uma jogada.
jogada :: Int -- ^ O identificador do 'Jogador' que efetua a jogada.
       -> Jogada -- ^ A 'Jogada' a efetuar.
       -> Estado -- ^ O 'Estado' anterior.
       -> Estado -- ^ O 'Estado' resultante após o jogador efetuar a jogada.

-- | A função 'jogada' aplicada aos vários comandos.
jogada njogador j q@(Estado mapaEstado jogadoresEstado) = case j of
        Movimenta C -> movValido njogador (Movimenta C) (encontraIndiceLista njogador jogadoresEstado) q
        Movimenta B -> movValido njogador (Movimenta B) (encontraIndiceLista njogador jogadoresEstado) q
        Movimenta D -> Estado mapaEstado (atualizaIndiceLista njogador d jogadoresEstado)
                       where d = movD (encontraIndiceLista njogador jogadoresEstado) (Movimenta D)
        Movimenta E -> Estado mapaEstado (atualizaIndiceLista njogador e jogadoresEstado)
                       where e = movE (encontraIndiceLista njogador jogadoresEstado) (Movimenta E)
        Acelera     -> aceleraX njogador (encontraIndiceLista njogador jogadoresEstado) q
        Desacelera  -> desacelera njogador (encontraIndiceLista njogador jogadoresEstado) q
        Dispara     -> disparaValido njogador (encontraIndiceLista njogador jogadoresEstado) q




-- ** Funções auxiliares da função principal da Tarefa 2 para jogadas do tipo Movimenta.

movValido :: Int -> Jogada -> Jogador -> Estado -> Estado
movValido njogador (Movimenta x) j@(Jogador npista dist v ncola (Chao a)) (Estado mapaact l)
                        | x == C && npista == 0 = Estado mapaact l
                        | x == B && ((length mapaact)-1) == npista = Estado mapaact l
                        | x == C = movJog njogador (Movimenta x) j (encontraPosicaoMatriz (npista,floor dist) mapaact) (encontraPosicaoMatriz (npista-1,floor dist) mapaact) (Estado mapaact l) 
                        | otherwise = movJog njogador (Movimenta x) j (encontraPosicaoMatriz (npista,floor dist) mapaact) (encontraPosicaoMatriz (npista+1,floor dist) mapaact) (Estado mapaact l)

movValido njogador (Movimenta x) j@(Jogador npista dist v ncola e) (Estado mapaact l) = Estado mapaact l

-- MovValido escolhe entre usar a MovJog ou MovJogAr (ou se o jogador move em primeiro lugar)

-- | 'movJog' : Dado o nº do jogador; a jogada; a informação do jogador; a sua peça atual e a peça onde pretende mover (e o estado atual), realiza a ação
movJog :: Int -> Jogada -> Jogador -> Peca -> Peca -> Estado -> Estado
movJog njogador (Movimenta x) j@(Jogador npista dist v ncola (Chao a)) p1 p2 (Estado mapaact l) 
              | difAlturas j p1 p2 > 0.2 = Estado mapaact (atualizaIndiceLista njogador (Jogador npista dist 0 ncola (Morto 1.0)) l)
              | difAlturas j p1 p2 < (-0.2) && x == C = Estado mapaact (atualizaIndiceLista njogador (Jogador (npista-1) dist v ncola (Ar (alturaPeca dist p1) (inclinacaoPeca p1) 0)) l)
              | difAlturas j p1 p2 < (-0.2) && x == B = Estado mapaact (atualizaIndiceLista njogador (Jogador (npista+1) dist v ncola (Ar (alturaPeca dist p1) (inclinacaoPeca p1) 0)) l)
              | x == C = Estado mapaact (atualizaIndiceLista njogador (Jogador (npista-1) dist v ncola (Chao a)) l)
              | x == B = Estado mapaact (atualizaIndiceLista njogador (Jogador (npista+1) dist v ncola (Chao a)) l)


-- |a função 'movD' avalia se o jogador pode efetuar a jogada (Movimenta D) e, se sim, executa-a alterando o valor da inclinação do jogador.
--
-- >>> movD (Jogador 1 2.5 4 1 (Ar 2 15 0)) (Movimenta D) 
-- Jogador 1 2.5 4 1 (Ar 2 0 0) 

movD :: Jogador -> Jogada -> Jogador
movD j@(Jogador npista distancia v ncola (Ar h i g)) (Movimenta D) | ajustangulo i == (-90) = j
                                                                   | ((ajustangulo i) - 15) >= (-90) = Jogador npista distancia v ncola (Ar h (ajustangulo (i-15)) g) 
                                                                   | otherwise = Jogador npista distancia v ncola (Ar h (-90) g) 
movD j@(Jogador npista distancia v ncola e) (Movimenta D) = j 


ajustangulo :: Double -> Double 
ajustangulo x | x > 360 || x < (-360) = ajustangulo (normalizaAngulo x)
              | x >= 270 = x - 360
              | x <= (-270) = x + 360
              | otherwise = x 

-- |a função 'movE' avalia se o jogador pode efetuar a jogada (Movimenta E) e, se sim, executa-a alterando o valor da inclinação do jogador.
--
-- >>> movE (Jogador 1 2.5 4 1 (Ar 2 15 0)) (Movimenta E) 
-- Jogador 1 2.5 4 1 (Ar 2 30 0) 

movE :: Jogador -> Jogada -> Jogador
 
movE j@(Jogador npista distancia v ncola (Ar h i g)) (Movimenta E) | ajustangulo i == 90 = j
                                                                   | ((ajustangulo i) + 15) <= 90 = Jogador npista distancia v ncola (Ar h (ajustangulo (i+15)) g) 
                                                                   | otherwise = Jogador npista distancia v ncola (Ar h 90 g) 
movE j@(Jogador npista distancia v ncola e) (Movimenta E) = j                                                                                                                                    

-- *** Funçoes auxiliares da função (MOVJOG) de jogadas do tipo "Movimenta C/B" efetuadas no chão.

-- | 'alturaPeca' : Dada a distancia do jogador e sua peça, calcula a sua altura atual (ao sair da peca e ficar no ar)              
alturaPeca :: Double -> Peca -> Double
alturaPeca dist (Recta p h) = fromIntegral h
alturaPeca dist (Rampa p h hf) = ((fi hf - fi h)* n + fi h)
                      where  n = dist - fi (floor dist)
                             fi = fromIntegral

-- | 'inclinacaoPeca' : Dada uma peça (onde o jogador se encontra), calcula a inclinação do jogador (ao sair dessa peça)
inclinacaoPeca :: Peca -> Double
inclinacaoPeca (Recta p h) = 0
inclinacaoPeca (Rampa p h hf) = (atan (fi hf- fi h))* 180 / pi
                    where fi = fromIntegral

                  
-- | 'difAlturas' : Com a dist do jogador, a peça em que se encontra e a peça onde pretende ir, calcula a diferença de altura
difAlturas :: Jogador -> Peca -> Peca -> Double
difAlturas j@(Jogador npista dist v ncola (Chao a)) (Recta p h) (Recta p1 h1) = fromIntegral (h1 - h)
difAlturas j@(Jogador npista dist v ncola (Chao a)) (Recta p h) (Rampa p1 h1 hf1) = ((fi hf1 - fi h1) * n + fi h1) - fi h
               where  n = dist - fi (floor dist)
                      fi = fromIntegral
difAlturas j@(Jogador npista dist v ncola (Chao a)) (Rampa p h hf)  (Recta p1 h1) = fi h1 - ((fi hf - fi h)* n + fi h)
               where  n = dist - fi (floor dist)
                      fi = fromIntegral
difAlturas j@(Jogador npista dist v ncola (Chao a)) (Rampa p h hf) (Rampa p1 h1 hf1) = ((fi hf1 - fi h1)* n + fi h1) - ((fi hf - fi h)* n + fi h)
               where  n = dist - fi (floor dist)
                      fi = fromIntegral

-- ** Função auxiliar da jogada Acelera

-- | 'aceleraX' : Dado o nº do jogador, a sua informação e o estado do jogo atual, verifica se o comando Acelera é válido e se sim executa-o.
aceleraX :: Int -> Jogador -> Estado -> Estado
aceleraX njogador j@(Jogador npista dist v ncola (Chao x)) (Estado mapaact l)
                  | x == True = Estado mapaact l
                  | otherwise = Estado mapaact (atualizaIndiceLista njogador (Jogador npista dist v ncola (Chao True)) l)
aceleraX njogador j@(Jogador npista dist v ncola e) (Estado mapaact l) = Estado mapaact l


-- ** Função auxiliar da jogada Desacelera

-- | 'desacelera' : Dado o nº do jogador, a sua informação e o estado do jogo atual, verifica se o comando Desacelera é válido e se sim executa-o.
desacelera :: Int -> Jogador -> Estado -> Estado
desacelera njogador j@(Jogador npista dist v ncola (Chao x)) (Estado mapaact l)
                  | x == False = Estado mapaact l
                  | otherwise = Estado mapaact (atualizaIndiceLista njogador (Jogador npista dist v ncola (Chao False)) l)
desacelera njogador j@(Jogador npista dist v ncola e) (Estado mapaact l) = Estado mapaact l



-- ** Funçôes auxiliares da jogada Dispara

-- | 'disparaValido' : Dado o nº do jogador, a sua informação e o estado do jogo atual, verifica se o comando Dispara é válido e se sim executa (colaMapa)
disparaValido :: Int -> Jogador -> Estado -> Estado
disparaValido njogador j@(Jogador npista dist v ncola (Chao x)) (Estado mapaact (h:t)) 
            | ncola == 0 = Estado mapaact (h:t)
            | floor dist == 0 = Estado mapaact (h:t)
            | otherwise = Estado (colaMapa npista dist (encontraPosicaoMatriz (npista,(floor dist)-1) mapaact) mapaact) (atualizaIndiceLista njogador (Jogador npista dist v (ncola-1) (Chao x)) (h:t))      
disparaValido njogador j@(Jogador npista dist v ncola e) (Estado mapaact (h:t)) = Estado mapaact (h:t)


-- | 'colaMapa': Dado o nº da pista e a distância do jogador no mapa, assim como a peça anterior e o mapa atual, gera o novo mapa com com a alteração 
-- da peça anterior ao jogador para piso Cola.
colaMapa :: Int -> Double -> Peca -> Mapa -> Mapa 
colaMapa npista dist (Recta p h) mapaact = atualizaPosicaoMatriz (npista,(floor dist)-1) (Recta Cola h) mapaact
colaMapa npista dist (Rampa p h hf) mapaact = atualizaPosicaoMatriz (npista,(floor dist)-1) (Rampa Cola h hf) mapaact