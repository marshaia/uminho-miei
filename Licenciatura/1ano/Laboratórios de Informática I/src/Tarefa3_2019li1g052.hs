module Tarefa3_2019li1g052 where

import LI11920
import Tarefa0_2019li1g052

{- |

= __INTRODUÇÃO: __
Esta tarefa consistia em implementar a função 'descontroi' que, dado um mapa, resultava numa série de instruções
para a contrução do mesmo. O principal objetivo era descobrir padrões dentro do mapa e consequentemente
juntá-los no resultado final.

= __OBJECTIVOS: __
Começamos por implementar uma função que transforma as várias peças do mapa em instruções, este segue uma ordem específica, começando pelas peças nas várias pistas 
do mesmo comprimento, priotirizando peças iguais ao pôr as instruções juntas, fazendo isto ao longo do mapa. 

De seguida é aplicada a função 'compVert' que comprime as instruções de forma vertical, esta funciona de forma eficiente graças à ordem das instruções feitas na função anterior. 

Depois da compressão vertical é aplicada a compressão horizontal, através da função 'compHorz', que analisa instruções iguais em peças iguais e comprime-as em "Repete". 

Por fim é aplicada a compressão de Repetes com a função 'compRepete', esta analisa instruções "Repete" com o mesmo número de repetições e em pistas diferente e comprime.

= __CONCLUSÃO: __
Por fim, obtivemos uma taxa de compressão desejável, que prioriza padrões verticais, sem sacrificar os outros padrões.
-}

relatório_Tarefa3 :: String
relatório_Tarefa3 = "Relatório"

-- * Testes
-- | Testes unitários da Tarefa 3.
-- Cada teste é um 'Mapa'.
testesT3 :: [Mapa]
testesT3 = [[[Recta Terra 0,Recta Terra 0,Recta Terra 0],[Recta Terra 0,Rampa Relva 0 2,Rampa Lama 2 1]],[[Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Terra 0],[Recta Terra 0,Recta Relva 0,Recta Relva 0,Recta Relva 0,Recta Relva 0]],
            [[Recta Terra 0,Recta Lama 0],[Recta Terra 0,Recta Boost 0]],[[Recta Terra 0,Rampa Lama 0 1,Rampa Lama 1 0],[Recta Terra 0,Recta Terra 0,Recta Terra 0]],[[Recta Terra 0,Rampa Lama 0 1,Rampa Lama 1 0],[Recta Terra 0,Rampa Lama 0 1,Rampa Lama 1 0]],
            [[Recta Terra 0,Recta Terra 0,Recta Relva 0,Recta Relva 0,Recta Relva 0],[Recta Terra 0,Recta Terra 0,Recta Lama 0,Recta Relva 0,Recta Relva 0]],[[Recta Terra 0,Recta Relva 0,Recta Lama 0],[Recta Terra 0,Recta Relva 0,Recta Lama 0],[Recta Terra 0,Recta Relva 0,Recta Lama 0],[Recta Terra 0,Recta Relva 0,Recta Lama 0]],
            [[Recta Terra 0,Recta Lama 0,Recta Lama 0,Recta Lama 0,Rampa Relva 0 2,Rampa Relva 2 3],[Recta Terra 0,Recta Lama 0,Recta Lama 0,Recta Relva 0,Rampa Relva 0 2,Rampa Relva 2 1],[Recta Terra 0,Recta Lama 0,Recta Lama 0,Recta Relva 0,Rampa Boost 0 2,Rampa Relva 2 1]],
            [[Recta Terra 0,Rampa Terra 0 2,Rampa Terra 2 4,Rampa Terra 4 6],[Recta Terra 0,Rampa Terra 0 1,Rampa Relva 1 3,Rampa Terra 3 5],[Recta Terra 0,Rampa Terra 0 2,Rampa Relva 2 1,Rampa Relva 1 0]],
            [[Recta Terra 0,Rampa Terra 0 2,Rampa Terra 2 1,Rampa Terra 1 0],[Recta Terra 0,Rampa Terra 0 2,Rampa Terra 2 3,Rampa Terra 3 2],[Recta Terra 0,Rampa Terra 0 2,Rampa Terra 2 1,Rampa Relva 1 0]],
            [[Recta Terra 0,Rampa Terra 0 2,Rampa Terra 2 1],[Recta Terra 0,Rampa Terra 0 2,Rampa Terra 2 0]],[[Recta Terra 0,Rampa Terra 0 2,Recta Relva 2,Rampa Relva 2 1,Recta Terra 1],[Recta Terra 0,Rampa Terra 0 2,Recta Terra 2,Rampa Relva 2 0,Recta Terra 0]],
            [[Recta Terra 0,Rampa Terra 0 2,Rampa Terra 2 4,Rampa Relva 4 6,Recta Terra 6],[Recta Terra 0,Rampa Terra 0 2,Rampa Terra 2 4,Rampa Relva 4 6,Recta Terra 6]],[[Recta Terra 0,Rampa Terra 0 2,Recta Relva 2,Recta Terra 2,Rampa Terra 2 3],[Recta Terra 0,Rampa Terra 0 2,Recta Terra 2,Recta Relva 2,Rampa Terra 2 3]],
            [[Recta Terra 0,Rampa Terra 0 2,Recta Relva 2,Recta Terra 2,Rampa Terra 2 3],[Recta Terra 0,Rampa Terra 0 2,Recta Terra 2,Recta Relva 2,Rampa Relva 2 3]],[[Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Relva 0,Recta Relva 0]],
            [[Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Lama 0],[Recta Terra 0,Recta Relva 0,Recta Relva 0,Recta Relva 0]],[[Recta Terra 0,Recta Terra 0,Recta Terra 0,Recta Relva 0,Recta Relva 0],[Recta Terra 0,Recta Relva 0,Recta Relva 0,Recta Relva 0,Recta Relva 0],[Recta Terra 0,Recta Lama 0,Recta Lama 0,Recta Terra 0,Recta Terra 0]]]


-- * Funções principais da Tarefa 3.
-- | Desconstrói um 'Mapa' numa sequência de 'Instrucoes'.
-- __NB:__ Uma solução correcta deve retornar uma sequência de 'Instrucoes' tal que, para qualquer mapa válido 'm', executar as instruções '(desconstroi m)' produza o mesmo mapa 'm'.
-- __NB:__ Uma boa solução deve representar o 'Mapa' dado no mínimo número de 'Instrucoes', de acordo com a função 'tamanhoInstrucoes'.
desconstroi :: Mapa -> Instrucoes
desconstroi m = compRepete (compHorz (tail (compVert (nextPeca 0 0 m))))



-- ** Funções pertencentes a função principal que traduzem o mapa em forma de intruções numa ordem específica de forma a ajudar as funções compressoras.
-- | 'nextPeca' : Dada uma coordenada e um mapa, chama a peça correspondente na coordenada. Esta função é utilizada para fazer reset à função assim que as funções auxiliares acabarem.
nextPeca :: Int -> Int -> Mapa -> Instrucoes
nextPeca n m mapa = pecaValida n m (encontraPosicaoMatriz (n,m) mapa) mapa

-- | 'pecaValida' : Dada uma coordenada, a peca correspondente e o seu mapa, a função avalia se a peça em questão é uma peça válida (Peça válida significa uma peça que ainda
--                  não foi transformada numa instrução) e chama a função NEXTPECAIGUAL com a mesma, deixando a peça na coordenada uma peça inválida (Recta Terra (-1)) 
pecaValida :: Int -> Int -> Peca -> Mapa -> Instrucoes
pecaValida n m (Recta Terra (-1)) mapa | (m+1) == length (head (mapa)) && (n+1) == length mapa = [] 
                                       | (n+1) == length mapa = nextPeca 0 (m+1) mapa  
                                       | otherwise = nextPeca (n+1) m mapa 
pecaValida n m peca mapa | (n+1) == length mapa = instPeca n peca : nextPeca 0 0 (atualizaPosicaoMatriz (n,m) (Recta Terra (-1)) mapa)
                         | otherwise = instPeca n peca : nextPecaIgual (n+1) m peca (atualizaPosicaoMatriz (n,m) (Recta Terra (-1)) mapa)                         

-- | 'nextPecaIgual' : Dada a coordenada, a peça válida e um mapa, procura mais peças que sejam iguais a si e se sim, junta-as numa só instrução, 
--                    quando acabar os emparelhamentos chama a funcao NEXTPECA para repetir o processo para o resto do mapa. 
nextPecaIgual :: Int -> Int -> Peca -> Mapa -> Instrucoes
nextPecaIgual n m peca mapa = if pecaPisoIgual peca (encontraPosicaoMatriz (n,m) mapa) then if (n+1) == length mapa then instPeca n peca : nextPeca 0 0 (atualizaPosicaoMatriz (n,m) (Recta Terra (-1)) mapa)
                                                                                       else instPeca n peca : nextPecaIgual (n+1) m peca (atualizaPosicaoMatriz (n,m) (Recta Terra (-1)) mapa)
                              else if (n+1) == length mapa then nextPeca 0 0 mapa
                                   else nextPecaIgual (n+1) m peca mapa



-- *** Função auxiliar da funçao NEXTPECAIGUAL
-- | 'instPeca' : Dada o número de uma pista e uma peça, constroi a instrução correspondente.
instPeca :: Int -> Peca -> Instrucao
instPeca n (Recta p h) = Anda [n] p
instPeca n (Rampa p h hf) | (hf - h) > 0 = Sobe [n] p (hf-h)
                          | otherwise = Desce [n] p (h-hf)

-- | 'pecaPisoIgual' : Dadas duas peças avalia se estás são "iguais" para a compressão vertical.                             
pecaPisoIgual :: Peca -> Peca -> Bool
pecaPisoIgual (Recta p h) (Recta px hx) = if p == px && hx /= (-1) then True else False
pecaPisoIgual (Rampa p hi hf) (Rampa px hix hfx) = if p == px && ((hfx - hix) == (hf - hi)) then True else False
pecaPisoIgual inst inst1 = False                          



-- ** Funções pertencentes a compressão vertical de instruções
-- | 'compVert' : Recebendo a lista de intruções ordenada, chama a função comparadora de instruções.
compVert :: Instrucoes -> Instrucoes
compVert (h:h1:t) = instIgualV h h1 t

-- | 'instIgualV' : Dadas duas intruções, avalia se estas são iguais e não pertencem a mesma pista, se as condições corresponderem segue a compressão vertical dessas instruções.  
instIgualV :: Instrucao -> Instrucao -> Instrucoes -> Instrucoes
instIgualV (Anda l p) (Anda [lx] px) [] | p == px && elem lx l == False && elemmaior lx l = [Anda (l++[lx]) p]
                                        | otherwise = (Anda l p) : [Anda [lx] px]    
instIgualV (Sobe l p h) (Sobe [lx] px hx) [] | p == px && elem lx l == False && h == hx && elemmaior lx l = [Sobe (l++[lx]) p h]
                                             | otherwise = (Sobe l p h) : [Sobe [lx] px hx]        
instIgualV (Desce l p h) (Desce [lx] px hx) [] | p == px && elem lx l == False && h == hx && elemmaior lx l = [Desce (l++[lx]) p h]
                                               | otherwise = (Desce l p h) : [Desce [lx] px hx]
instIgualV inst inst1 [] = inst : [inst1] 

instIgualV (Anda l p) (Anda [lx] px) (g:t) | p == px && elem lx l == False && elemmaior lx l = instIgualV (Anda (l++[lx]) p) g t
                                           | otherwise = (Anda l p) : instIgualV (Anda [lx] px) g t    
instIgualV (Sobe l p h) (Sobe [lx] px hx) (g:t) | p == px && elem lx l == False && h == hx && elemmaior lx l = instIgualV (Sobe (l++[lx]) p h) g t
                                                | otherwise = (Sobe l p h) : instIgualV (Sobe [lx] px hx) g t        
instIgualV (Desce l p h) (Desce [lx] px hx) (g:t) | p == px && elem lx l == False && h == hx && elemmaior lx l = instIgualV (Desce (l++[lx]) p h) g t
                                                  | otherwise = (Desce l p h) : instIgualV (Desce [lx] px hx) g t
instIgualV inst inst1 (h:t) = inst : instIgualV inst1 h t        



-- *** Função auxiliar das função compressora vertical 
-- | 'elemmaior' : Avalia se um Int é o maior de uma lista.
elemmaior :: Int -> [Int] -> Bool
elemmaior n [] = True
elemmaior n (h:t) | n > h = True && elemmaior n t
                  | otherwise = False 



-- ** Funções pertencentes a compressão horizontal de instruções 
-- | 'compHorz' :  Recebendo a lista de intruções já comprimida verticalmente, chama a função comparadora de instruções. É também usado para dar reset na função comparadora.
compHorz :: Instrucoes -> Instrucoes
compHorz (h:[]) = [constroiRepete 1 h]
compHorz (h:t) = instIgualH 1 h t []

-- | 'instIgualH' : Dado um k, uma instrução, a lista de instruções restantes e uma lista auxiliar, compara duas instruções e se estas tiverem certas condições, a função 
--                 repete com um valor de k acrescentado, quando as condições não forem atingidas chama a função CONSTROIREPETE com o valor de k, de seguida dá reset a lista 
--                 restante com a ajuda da lista auxiliar e repete a função COMPHORZ.
instIgualH :: Int -> Instrucao -> Instrucoes -> Instrucoes -> Instrucoes
instIgualH k inst [] [] = [constroiRepete k inst]
instIgualH k inst [] laux = constroiRepete k inst : compHorz laux
instIgualH k (Anda ln p) l@((Anda lnx px):t) laux | ln == lnx && p == px = instIgualH (k+1) (Anda ln p) t laux                                                 
                                                  | elemslistas ln lnx == False = instIgualH k (Anda ln p) t (laux ++ [Anda lnx px])
                                                  | otherwise = constroiRepete k (Anda ln p) : compHorz (laux ++ l)
instIgualH k (Sobe ln p h) l@((Sobe lnx px hx):t) laux | ln == lnx && p == px && h == hx = instIgualH (k+1) (Sobe ln p h) t laux                                                 
                                                       | elemslistas ln lnx == False = instIgualH k (Sobe ln p h) t (laux ++ [Sobe lnx px hx])
                                                       | otherwise = constroiRepete k (Sobe ln p h) : compHorz (laux ++ l)
instIgualH k (Desce ln p h) l@((Desce lnx px hx):t) laux | ln == lnx && p == px && h == hx = instIgualH (k+1) (Desce ln p h) t laux                                                 
                                                         | elemslistas ln lnx == False = instIgualH k (Desce ln p h) t (laux ++ [Desce lnx px hx])
                                                         | otherwise = constroiRepete k (Desce ln p h) : compHorz (laux ++ l)
instIgualH k inst (h:t) laux | igualHAux inst h = constroiRepete k inst : compHorz (laux ++ (h:t))
                             | otherwise = instIgualH k inst t (laux ++ [h])


-- *** Funções auxiliares da compressão horizontal
-- | 'igualHAux' : Quando recebe duas instruções diferentes, avalia os elementos das listas das instruções. 
igualHAux :: Instrucao -> Instrucao -> Bool
igualHAux (Anda l p) (Sobe lx px h) = elemslistas l lx
igualHAux (Anda l p) (Desce lx px h) = elemslistas l lx
igualHAux (Sobe l p h) (Anda lx px) = elemslistas l lx
igualHAux (Sobe l p h) (Desce lx px hx) = elemslistas l lx
igualHAux (Desce l p h) (Anda lx px) = elemslistas l lx
igualHAux (Desce l p h) (Sobe lx px hx) = elemslistas l lx

-- | 'elemlistas' : Dadas duas listas, avalia se algum membro da primeira lista corresponde aos da segunda.
elemslistas :: [Int] -> [Int] -> Bool
elemslistas (h:t) (h1:t1) = elem h1 (h:t) || elemslistas (h:t) t1
elemslistas (h:t) [] = False

-- | 'constroiRepete' :: Recebendo um k e uma instrução, controi um instrução do tipo (Repete k [inst]). NOTA que se k == 1 apenas constroi a instrução normal.
constroiRepete :: Int -> Instrucao -> Instrucao
constroiRepete n inst | n == 1 = inst
                      | otherwise = Repete n [inst]



-- ** Funções da compressão de instruções do tipo "Repete"
-- | 'compRepete' : Dada uma lista de instruções, chama a função encontraRepete para começar o processo de compressão. É usado como reset.
compRepete :: Instrucoes -> Instrucoes
compRepete (h:[]) = [h]
compRepete (h:t) = encontraRepete h t

-- | 'encontraRepete' : Função que procura encontrar um Repete nas instruções.
encontraRepete :: Instrucao -> Instrucoes -> Instrucoes
encontraRepete inst [] = [inst]
encontraRepete (Repete k [inst]) l = repeteIgual [] (Repete k [inst]) l []
encontraRepete inst (h:[]) = inst : [h]
encontraRepete inst (h:t) = inst : encontraRepete h t   

-- | 'repeteIgual' : Depois de encontrado um Repete, vai procurar outros repetes dentro das condições para comprimi-los, caso não aconteça larga a instrução e da compRepete a lista restante.
repeteIgual :: [Int] -> Instrucao -> Instrucoes -> Instrucoes -> Instrucoes
repeteIgual ln (Repete k linst) [] [] = [Repete k linst]
repeteIgual ln (Repete k linst) [] laux = ((Repete k linst) : compRepete laux)
repeteIgual ln (Repete k linst) ((Repete kx linstx):t) laux | k == kx && elemslistas (ln ++ instpistas linst) (instpistas linstx) == False = repeteIgual (ln++(instpistas linstx)) (Repete k (linst++linstx)) t laux                                                           
                                                            | k /= kx && elemslistas (ln ++ instpistas linst) (instpistas linstx) == False = repeteIgual (ln++(instpistas linstx)) (Repete k linst) t (laux++[Repete kx linstx])
                                                            | otherwise = Repete k linst : compRepete (laux++((Repete kx linstx):t))
repeteIgual ln (Repete k linst) (inst:t) laux | elemslistas (ln ++ instpistas linst) (instpistas [inst]) == False = repeteIgual (ln++(instpistas [inst])) (Repete k (linst)) t (laux++[inst])
                                              | otherwise = Repete k linst : compRepete (laux++(inst:t))                                                          
         
                                              
-- *** Funções auxiliares da função de compressão de repetes.
-- | 'instpistas' : Dada uma lista de instruções dentro de um Repete, devolve a lista de ints onde as instruções se aplicam.
instpistas :: Instrucoes -> [Int]
instpistas [] = []
instpistas ((Anda l p):t) = l ++ instpistas t
instpistas ((Sobe l p h):t) = l ++ instpistas t
instpistas ((Desce l p h):t) = l ++ instpistas t
   
