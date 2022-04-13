module Tarefa1_2019li1g052 where  
      
import LI11920
import System.Random
import Tarefa0_2019li1g052 

{- |
= __INTRODUÇÃO: __
O desafio desta tarefa consistia em implementar uma função cujo input seria um triplo de inteiros, 
e o seu output um mapa (lista de pistas).

= __OBJECTIVOS: __
Começamos por criar uma função ('geraPares') que, a partir da listas de números aleatórios provenientes
da função 'geraAleatorios', criava uma lista de pares para posteriormente serem utilizados na função 
('geraListaPecas'). Esta última função, a partir da lista de pares, cria uma lista de peças, utilizando como
funções auxiliares 'geraPiso', 'geraPeca', 'geraAltura', que, de acordo com os números dos pares, cria as 
peças correspondentes.
O objectivo principal do nosso grupo foi maximizar o desempenho do nosso código e a sua consequente otimização,
criando funções auxiliares eficientes.
Relativamente aos testes adicionados pelo nosso grupo, pensamos serem pertinentes na medida em que utilizam
grande parte do código. 

= __CONCLUSÃO: __ 
Consideramos ter obtido um resultado bastante agradável com esta tarefa, na medida em que a função principal
'gera' retorna o output desejado.

-}

relatório_Tarefa1 :: String
relatório_Tarefa1 = "Relatório"
  
-- * Testes
-- | Testes unitários da Tarefa 1.
-- Cada teste é um triplo (/número de 'Pista's/,/comprimento de cada 'Pista' do 'Mapa'/,/semente de aleatoriedades/).
testesT1 :: [(Int,Int,Int)]
testesT1 = [(1,2,3),(2,3,5),(4,10,8),(6,20,42),(1,30,(-5)),(2,8,9),(4,6,9),(3,7,0)]


-- * Funções pré-definidas da Tarefa 1.
geraAleatorios :: Int -> Int -> [Int]
geraAleatorios n seed = take n (randomRs (0,9) (mkStdGen seed))


-- ** Utiliza os valores obtidos em geraAleatorios e transforma em x listas de pares de tamanhos idênticos (x é o nº de pistas).
-- | 'geraPares' : transforma a lista vinda de geraAleatórios em pares consecutivos.
geraPares :: [Int] -> [(Int,Int)]
geraPares [] = []
geraPares (x:y:xs) = ((x,y): geraPares xs)

-- | 'geraListaPecas' : Dado uma lista de pares e o nºpistas, cria um array correspondente as peças do mapa.
geraListaPecas :: Int -> [(Int,Int)] -> [[(Int,Int)]]
geraListaPecas 0 _ = []
geraListaPecas x [] = []
geraListaPecas x l@((m,n):t) = (take n l): (geraListaPecas (x-1) (drop n l))
      where n = (length l) `div` x



--- * Funções principais da Tarefa 1.  
gera :: Int -> Int -> Int -> Mapa
gera npistas comprimento semente 
      | npistas == 0 || comprimento == 0 = []
      | otherwise = reverse (geraX npistas comprimento lc) 
                  where lc = geraListaPecas npistas (geraPares l)
                        l = geraAleatorios ((npistas*comprimento-npistas)*2) semente



-- ** Funções auxiliares na criação de um mapa.
-- | 'geraX' : Gera uma lista de pistas (lista de peças)            
geraX :: Int-> Int -> [[(Int,Int)]] -> Mapa
geraX 1 comprimento lc = [geraPista 0 0 lc (Recta Terra 0)]
geraX n comprimento lc = [geraPista (n-1) 0 lc (Recta Terra 0)] ++ geraX (n-1) comprimento lc

-- | 'geraPista': dado um nº de uma pista, a peça anterior e a lista de geraAleatorios cria uma pista (lista de peças) n.
geraPista :: Int -> Int -> [[(Int,Int)]] -> Peca -> [Peca]
geraPista pistact compact lc peca | compact == 0 = Recta Terra 0 : geraPista pistact (compact+1) lc (Recta Terra 0)
                                  | ePosicaoMatrizValida (pistact,compact-1) lc == False = []
                                  | otherwise = geraPeca l1 l2 peca : geraPista pistact (compact+1) lc (geraPeca l1 l2 peca)
                 where (l1,l2) = encontraPosicaoMatriz (pistact,compact-1) lc


  
-- ** Funções sobre gerar peças.
-- | 'geraPiso' : Recebe o primeiro elemento de um par (geraPares) e o piso anterior e transforma num novo piso.
geraPiso :: Int -> Piso -> Piso
geraPiso n p | n >= 0 && n <= 1 = Terra
             | n >= 2 && n <= 3 = Relva
             | n == 4 = Lama
             | n == 5 = Boost
             | n >= 6 && n <= 9 = p
             
-- | 'geraAltura' : Recebe o segundo elemento de um par (geraPares) e a peça anterior e obtém a altura final da peca seguinte.
geraAltura :: Int -> Peca -> Int
geraAltura n (Recta p h) | n >= 0 && n <= 1 = h+n+1  
                         | n >= 2 && n <= 5 && (h-(n-1)) <= 0 = 0
                         | n >= 2 && n <= 5 = h-(n-1)
                         | n >= 6 && n <= 9 = h 
  
geraAltura n (Rampa p hi hf) | n >= 0 && n <= 1 = hf+n+1
                             | n >= 2 && n <= 5 && (hf-(n-1)) <= 0 = 0
                             | n >= 2 && n <= 5 = hf-(n-1)
                             | n >= 6 && n <= 9 = hf
  
-- | 'geraPeca' : Recebe ambos os valores de um par (geraPares) e a peça anterior e gera a peça seguinte. 
geraPeca :: Int -> Int -> Peca -> Peca
geraPeca m n a@(Recta p h) | geraAltura n a == h = Recta (geraPiso m p) (geraAltura n a)  
                           | otherwise = Rampa (geraPiso m p) h (geraAltura n a)
  
geraPeca m n c@(Rampa p a b) | geraAltura n c == b = Recta (geraPiso m p) (geraAltura n c)
                             | otherwise = Rampa (geraPiso m p) b (geraAltura n c)


