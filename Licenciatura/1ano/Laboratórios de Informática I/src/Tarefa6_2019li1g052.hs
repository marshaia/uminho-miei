module Tarefa6_2019li1g052 where

import LI11920
import Tarefa0_2019li1g052
import Tarefa2_2019li1g052
import Tarefa4_2019li1g052


{- |
= __INTRODUÇÃO: __
O objectivo desta tarefa era implementar um robô (bot) que, introduzido no jogo produzido pelo nosso grupo na Tarefa 5, 
jogasse automaticamente, ou seja, que tomasse decisões inteligentes durante um jogo com o objetivo de acabar em primeiro lugar.

= __OBJECTIVOS: __
Através da função criaOpções, criámos um 'campo de visão' ao bot. Esta função para além de apresentar a lista de peças,
coloca na primeira componente do par o movimento (B ou C) necessário para atingit tais peças.

(1) Se estivesse na primeira pista (Exemplo 1), veria, para além das duas peças
consecutivas à sua atual, também a peça adjacente da pista seguinte como as duas seguintes consecutivas.

(2) No caso de se encontrar na pista 2 (Exemplo 2), veria, para além das duas peças pecas consecutivas à atual, as duas 
adjacentes na pista anterior e na pista seguinte e as duas outras peças consecutivas em cada uma das pistas (anterior e seguinte).

(3) Se se encontrasse na pista 3 o comportamento da função seria análogo ao do exemplo 2.

(4)No caso de se encontrar na pista 4, então teria o mesmo comportamento do exemplo 1 com a exceção de substituir a visão
da pista seguinte com a pista anterior.

Exemplo 1)

(1) ª pista 1: 1 * 2 * jogador * 3 * 4

(2) ª pista 2: 5 * 6 *    7    * 8 * 9

Campo de visão: [jogador,3,4,7,8,9]

Exemplo 2)

(1) ª pista 1: 1  * 2  *    3    * 4  * 5

(2) ª pista 2: 6  * 7  * jogador * 8  * 9

(3) ª pista 3: 10 * 11 *    12   * 13 * 14

Campo de visão: [3,4,5,jogador,8,9,12,13,14]

De seguida, após criar esta lista de pares, executa a função 'pistaPossível' dentro da segunda componente do par. Esta consiste em 
definir se o bot conseguiria passar para a pista desejada de acordo com a diferença de alturas de peças.

Definimos um sistema de pontuação (função 'pontuacaoPista') de maneira a pontuar o conjunto de peças que considerávamos promissoras para um melhor 
desempenho do bot. Para tal, com recurso aos valores de atrito das peças em questão, somavamos os valores e escolhemos 
o conjunto de peças com o menor número possível. Através da função 'transforma', tal como o nome indica,
transformamos a lista de pares vinda da função criaOpções em pares que mantêm a primeira componente mas alteram a segunda para um Double
que corresponde ao sistema de pontuação implementado pelo grupo.

De seguida, a função 'escolheMelhor' escolhe o caminho com a menor pontuação possível executando a jogada Movimenta aplicada à direção
armazenada na primeira componente do par. 

= __CONCLUSÃO: __
Em suma, nesta tarefa tentámos implementar um sistema de pontuação, que, de acordo com a lista de peças provenientes do campo de visão 
atribuído ao bot, escolhia a pista cuja pontuação fosse menor e executava a jogada para o efeito.



-}

relatorio_Tarefa6 :: String
relatorio_Tarefa6 = "Relatorio"


-- * Funções principais da Tarefa 6.
-- | Define um ro'bot' capaz de jogar autonomamente o jogo.
bot :: Int          -- ^ O identificador do 'Jogador' associado ao ro'bot'.
    -> Estado       -- ^ O 'Estado' para o qual o ro'bot' deve tomar uma decisão.
    -> Maybe Jogada -- ^ Uma possível 'Jogada' a efetuar pelo ro'bot'.
bot n (Estado mapa jogs) = botAvalia mapa (encontraIndiceLista n jogs) 

-- |'botAvalia': Recebendo o mapa e o jogador, avalia o seu estado e faz as decisões respetivas  
botAvalia :: Mapa -> Jogador -> Maybe Jogada
botAvalia mapa q@(Jogador npista dist _ _ (Ar _ _ _)) = avaliaAR (encontraPosicaoMatriz (npista, floor dist) mapa) q
botAvalia mapa q@(Jogador npista dist _ _ (Chao False)) = Just Acelera
botAvalia mapa q@(Jogador npista dist _ _ (Chao True)) | floor dist + 3 >= length (head mapa) = Just Acelera
                                                       | length mapa == 1 = Just Acelera
                                                       | npista == 0 && avaliaMov (criaOpcoes 1 q mapa) /= Nothing = avaliaMov (criaOpcoes 1 q mapa) 
                                                       | npista == (length mapa)-1 && avaliaMov (criaOpcoes 2 q mapa) /= Nothing = avaliaMov (criaOpcoes 2 q mapa) 
                                                       | npista /= 0 && npista /= (length mapa)-1 && avaliaMov (criaOpcoes 3 q mapa) /= Nothing = avaliaMov (criaOpcoes 3 q mapa) 
                                                       | dist <= 2 = Just Acelera
                                                       | otherwise = avaliaChaoAtras (encontraPosicaoMatriz (npista, (floor dist)-1 ) mapa) mapa npista dist
botAvalia mapa q@(Jogador npista dist _ _ (Morto _)) = Nothing


-- ** Funções auxiliares para quando o bot está (Chao True)
-- |'criaOpcoes' : Cria uma lista de 3 peças à frente do jogador e a direção para acede-las. Opção 1: Lista de peças à sua frente e abaixo. Opção 2: Lista de peças à sua frente e acima. Opção 3: Lista de peças à sua frente ,abaixo e acima. 
criaOpcoes :: Int -> Jogador -> Mapa -> [(Maybe Direcao,[Peca])] 
criaOpcoes 1 j@(Jogador npista comp _ _ _) mapa = [(Nothing,pista npista comp mapa),(pistaPossivel j mapa (Just B) (encontraPosicaoMatriz (npista,floor comp) mapa) (encontraPosicaoMatriz (npista+1,floor comp) mapa))]
criaOpcoes 2 j@(Jogador npista comp _ _ _) mapa = [(Nothing,pista npista comp mapa),(pistaPossivel j mapa (Just C) (encontraPosicaoMatriz (npista,floor comp) mapa) (encontraPosicaoMatriz (npista-1,floor comp) mapa))]
criaOpcoes 3 j@(Jogador npista comp _ _ _) mapa = [(Nothing,pista npista comp mapa),(pistaPossivel j mapa (Just B) (encontraPosicaoMatriz (npista,floor comp) mapa) (encontraPosicaoMatriz (npista+1,floor comp) mapa)),(pistaPossivel j mapa (Just C) (encontraPosicaoMatriz (npista,floor comp) mapa) (encontraPosicaoMatriz (npista-1,floor comp) mapa))]

-- |'pistaPossivel' : Avalia se a pista acima ou abaixo é acessível sem o jogador morrer.
pistaPossivel :: Jogador -> Mapa -> Maybe Direcao -> Peca -> Peca -> (Maybe Direcao,[Peca])
pistaPossivel j@(Jogador npista comp _ _ _) mapa x p p1 | difAlturas j p p1 > 0.2 = (Nothing,[Rampa Cola 0 2,Rampa Cola 2 4,Rampa Cola 4 6])
                                                        | otherwise = (x,pista (aux x npista) comp mapa)

-- |'aux' : Devolve o número da pista no qual a lista de peças será criada
aux :: Maybe Direcao -> Int -> Int
aux Nothing npista = npista
aux (Just x) npista = if x == C then (npista - 1) else (npista + 1)

-- |'pista' : Devolve uma lista das 3 peças seguidas  
pista :: Int -> Double -> Mapa -> [Peca]
pista npista comp mapa = [encontraPosicaoMatriz (npista,floor comp) mapa,encontraPosicaoMatriz (npista,(floor comp) +1) mapa,encontraPosicaoMatriz (npista,(floor comp)+2) mapa]

-- |'avaliaMov' : Devolve a melhor jogada de um lista de jogadas potenciais.
avaliaMov :: [(Maybe Direcao,[Peca])] -> Maybe Jogada
avaliaMov l =  escolheMelhor (Nothing,1000) (transforma l)


-- |'transforma' : Transforma as listas de jogadas e peças numa pontuação.
transforma :: [(Maybe Direcao,[Peca])] -> [(Maybe Direcao,Double)]
transforma [] = []
transforma ((x,l):t) = (x, pontuacaoPista l) : transforma t

-- |'escolheMelhor' : Escolhe o caminho com a menor "pontuação" possível
escolheMelhor :: (Maybe Direcao,Double) -> [(Maybe Direcao,Double)] -> Maybe Jogada
escolheMelhor (Just x,_) [] = Just (Movimenta x)
escolheMelhor (Nothing,_) [] = Nothing   
escolheMelhor (x,num) ((x1,num1):t) | num1 < num = escolheMelhor (x1,num1) t
                                    | otherwise = escolheMelhor (x,num) t


-- |'pontuacaoPista' : Transforma as peças em Pontuações... dependendo do tipo de piso e se é do tipo Recta ou Rampa.
pontuacaoPista :: [Peca] -> Double
pontuacaoPista [] = 0
pontuacaoPista ((Recta Boost _):t) = (-1) + pontuacaoPista t
pontuacaoPista ((Rampa Boost _ _):t) = (-1.5) + pontuacaoPista t
pontuacaoPista ((Recta p _):t) = 1 + atritoaux p + pontuacaoPista t
pontuacaoPista ((Rampa p hi hf):t) | hf - hi <= 0 = 0.5 + (atritoaux p)*0.3 + pontuacaoPista t
                                   | hf - hi == 1 = 1.25 + atritoaux p  + pontuacaoPista t
                                   | hf - hi == 2 = 1.5 + atritoaux p + pontuacaoPista t
-- ** 


-- ** Funções auxiliares para quando o jogador já está (Chao True) e não efetua nenhuma mudança de pista. Procura por Boosts e avalia se Dispara ou não.
-- |'avaliaChaoAtras' : Caso a peça atrás seja um Boost... avalia as peças anteriores a essa... para não haver desperdicio de colas.
avaliaChaoAtras :: Peca -> Mapa -> Int -> Double -> Maybe Jogada
avaliaChaoAtras (Recta Boost _) mapa npista dist = if dist < 4 then Just Dispara else avalia3Pecas [encontraPosicaoMatriz (npista,(floor dist)-2) mapa,encontraPosicaoMatriz (npista,(floor dist)-3) mapa ]
avaliaChaoAtras (Rampa Boost _ _) mapa npista dist = if dist < 4 then Just Dispara else avalia3Pecas [encontraPosicaoMatriz (npista,(floor dist)-2) mapa,encontraPosicaoMatriz (npista,(floor dist)-3) mapa ]
avaliaChaoAtras _ _ _ _ = Nothing

-- |'avalia3Pecas' : Se houver um tipo de piso Cola... Não faz nada... Senão Dispara
avalia3Pecas :: [Peca] -> Maybe Jogada
avalia3Pecas lp = if haCola lp then Nothing else Just Dispara

-- |'haCola' : Se houver cola, interrompe e devolve True.
haCola :: [Peca] -> Bool
haCola [] = False
haCola (Rampa Cola _ _:t) = True 
haCola (Recta Cola _:t) = True
haCola (h:t) = False || haCola t
-- **




-- ** Funções auxiliares para quando o jogador está no Ar. 
-- |'avaliaAR' : Avalia a peça em baixo, caso seja um Rampa a descer chama a próxima função na opção 2, senão utiliza a opção 1.
avaliaAR :: Peca -> Jogador -> Maybe Jogada
avaliaAR (Rampa _ hi hf) jog | hf - hi <= 0 = ajustaAngulo 2 jog
                             | otherwise = ajustaAngulo 1 jog
avaliaAR p jog = ajustaAngulo 1 jog

-- |'ajustaAngulo' : Escolhe o ângulo preferível, dependendo a opção 1 ou 2.   
ajustaAngulo :: Int -> Jogador -> Maybe Jogada
ajustaAngulo 2 (Jogador _ _ _ _ (Ar _ ang _)) | ang < (-45) = Just (Movimenta E)
                                              | ang > (-30) = Just (Movimenta D)
                                              | otherwise = Nothing
ajustaAngulo 1 (Jogador _ _ _ _ (Ar _ ang _)) | ang < 30 = Just (Movimenta E)
                                              | ang > 45 = Just (Movimenta D)
                                              | otherwise = Nothing
-- **
-- *