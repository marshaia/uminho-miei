module Tarefa0_2019li1g052 where


type Angulo = Double
type Vetor = Ponto    

data Ponto = Cartesiano Double Double | Polar Double Angulo deriving Show


-- * Funções não-recursivas.

--  Um ponto a duas dimensões dado num referencial cartesiado (distâncias aos eixos vertical e horizontal)
-- <<http://li1.lsd.di.uminho.pt/images/cartesiano.png cartesisano>>
-- , ou num referencial polar (distância à origem e ângulo do respectivo vector com o eixo horizontal).
-- <<http://li1.lsd.di.uminho.pt/images/polar.png polar>>


-- *** Funções gerais sobre Vetores.
deg2rad :: Angulo -> Angulo
deg2rad a = a * (pi/180) 

polar2cart :: Vetor -> Vetor
polar2cart c@(Cartesiano x y) = c 
polar2cart (Polar r a) = Cartesiano (r * cos (deg2rad a)) (r * sin (deg2rad a))

-- | Soma dois Vetores.
somaVetores :: Vetor -> Vetor -> Vetor
somaVetores (Cartesiano x1 y1)(Cartesiano x2 y2) = Cartesiano (x1+x2)(y1+y2)
somaVetores v1 v2 = somaVetores (polar2cart v1) (polar2cart v2)

-- | Subtrai dois Vetores.
subtraiVetores :: Vetor -> Vetor -> Vetor
subtraiVetores (Cartesiano x1 y1) (Cartesiano x2 y2) = Cartesiano (x1-x2)(y1-y2)
subtraiVetores v1 v2 = subtraiVetores (polar2cart v1) (polar2cart v2)

-- | Multiplica um escalar por um 'Vetor'.
multiplicaVetor :: Double -> Vetor -> Vetor
multiplicaVetor k (Cartesiano x y) = Cartesiano (k*x) (k*y)
multiplicaVetor k v1 = multiplicaVetor k (polar2cart v1) 



-- ** Funções sobre rectas.

-- | Um segmento de reta é definido por dois pontos.
type Reta = (Ponto,Ponto)

-- | Testar se dois segmentos de reta se intersetam.
intersetam :: Reta -> Reta -> Bool
intersetam (Cartesiano x1 y1,Cartesiano x2 y2)(Cartesiano x3 y3,Cartesiano x4 y4) = 
    if (ta <= 1 && ta >= 0) && (tb <= 1 && tb >= 0) then True
    else False
        where   
            d = (x4-x3)*(y1-y2) - (x1-x2)*(y4-y3)
            ta = ((y3-y4)*(x1-x3) + (x4-x3)*(y1-y3)) / d 
            tb = ((y1-y2)*(x1-x3) + (x2-x1)*(y1-y3)) / d

intersetam (v1,v2)(v3,v4) = intersetam (polar2cart v1, polar2cart v2) (polar2cart v3, polar2cart v4)

-- | Calcular o ponto de intersecao entre dois segmentos de reta.
intersecao :: Reta -> Reta -> Ponto
intersecao (Cartesiano x1 y1,Cartesiano x2 y2)(Cartesiano x3 y3,Cartesiano x4 y4) = 
    if intersetam (Cartesiano x1 y1, Cartesiano x2 y2)(Cartesiano x3 y3,Cartesiano x4 y4) == True 
    then  (Cartesiano (x1 + ta*difx) (y1 + ta*dify))
    else error "Interseção Nula"
        where   
            d = (x4-x3)*(y1-y2) - (x1-x2)*(y4-y3)
            ta = ((y3-y4)*(x1-x3) + (x4-x3)*(y1-y3)) / d 
            dify = y2-y1
            difx = x2-x1    

intersecao (v1,v2)(v3,v4) = intersecao (polar2cart v1, polar2cart v2)(polar2cart v3, polar2cart v4)

-- ** Funções sobre listas

-- *** Funções gerais sobre listas.
-- | Verifica se o indice pertence à lista.
eIndiceListaValido :: Int -> [a] -> Bool
eIndiceListaValido n [] = False
eIndiceListaValido n (h:t) | n < 0 = False
                           | (n <= length (h:t) - 1) = True
                           | otherwise = False


-- ** Funções sobre matrizes.

-- *** Funções gerais sobre matrizes.

-- | A dimensão de um mapa dada como um par (/número de linhas/,/número de colunhas/).
type DimensaoMatriz = (Int,Int)

type PosicaoMatriz = (Int,Int)

-- | Uma posição numa matriz dada como um par (/linha/,/colunha/).
-- As coordenadas são dois números naturais e começam com (0,0) no canto superior esquerdo,
-- com as linhas incrementando para baixo e as colunas incrementando para a direita:
-- | Uma matriz é um conjunto de elementos a duas dimensões.
type Matriz a = [[a]]

-- | Calcula a dimensão de uma matriz.
--
-- __NB:__ Note que não existem matrizes de dimensão /m * 0/ ou /0 * n/, e que qualquer matriz vazia deve ter dimensão /0 * 0/.
dimensaoMatriz :: Matriz a -> DimensaoMatriz
dimensaoMatriz [[]] = (0,0)
dimensaoMatriz [] = (0,0)
dimensaoMatriz ([]:t) = (0,0)
dimensaoMatriz ((h:t):t1) = (length ((h:t):t1), length (h:t)) 

-- | Verifica se a posição pertence à matriz.
ePosicaoMatrizValida :: PosicaoMatriz -> Matriz a -> Bool 
ePosicaoMatrizValida (a,b) x | ((a >= 0 && a < l1) && (b>=0 && b< l2)) = True
                             | otherwise = False
            where (l1,l2) = dimensaoMatriz x

-- * Funções recursivas.

-- ** Funções sobre ângulos

-- | Normaliza um ângulo na gama [0..360).
normalizaAngulo :: Angulo -> Angulo
normalizaAngulo a | a >= 360 = normalizaAngulo (a - 360)
                  | a < 0 = normalizaAngulo (a + 360)
                  | otherwise = a

-- ** Funções sobre listas.

-- | Devolve o elemento num dado índice de uma lista.
encontraIndiceLista :: Int -> [a] -> a
encontraIndiceLista 0 (h:t) = h
encontraIndiceLista n (h:t) | (n > (length (h:t))) = error "Índice não existente" 
                            | otherwise = encontraIndiceLista (n-1) t

-- | Modifica um elemento num dado índice.
atualizaIndiceLista :: Int -> a -> [a] -> [a]
atualizaIndiceLista 0 x (h:t) = (x:t)
atualizaIndiceLista n x (h:t) | eIndiceListaValido n (h:t) == False = error "Índice não existente"
                              | otherwise = h: (atualizaIndiceLista (n-1) x t) 

-- ** Funções sobre matrizes.

-- | Devolve o elemento numa dada 'Posicao' de uma 'Matriz'.
encontraPosicaoMatriz :: PosicaoMatriz -> Matriz a -> a
encontraPosicaoMatriz (a,b) ((h:t):t1) = if ePosicaoMatrizValida (a,b) ((h:t):t1) == True 
                                            then encontraIndiceLista b (encontraIndiceLista a ((h:t):t1))
                                            else error "Posição Inexistente"
-- | Modifica um elemento numa dada 'Posicao'
--
-- __NB:__ Devolve a própria 'Matriz' se o elemento não existir.
atualizaPosicaoMatriz :: PosicaoMatriz -> a -> Matriz a -> Matriz a
atualizaPosicaoMatriz (l,c) x [] = []
atualizaPosicaoMatriz (0,c) x (l:ls) = (atualizaIndiceLista c x l) : ls 
atualizaPosicaoMatriz (l,c) x (l1:ls) = l1 : atualizaPosicaoMatriz (l-1,c) x ls