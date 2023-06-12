module Mutant where

import Prelude hiding (True,False)

import Ast
import Gramatica
import Generator 

import Test.QuickCheck (Gen, frequency, elements)
import Test.QuickCheck.Gen (generate)
import Test.QuickCheck.Random (mkQCGen)

import Data.Generics.Zipper
import Library.Ztrategic 
import Library.StrategicData (StrategicData)

instance StrategicData Int
instance StrategicData Statement
instance StrategicData Grammar
instance StrategicData a => StrategicData [a]



mainGen :: IO ()
mainGen = do 
    original <- generate genGrammar
    mutated <- generate $ mutationGenerator original
    putStrLn $ "Initial AST: " ++ show original
    putStrLn $ "Mutated AST: " ++ show mutated


escolherTipo :: Gen Int
escolherTipo = elements [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15] 


mutationGenerator :: Grammar -> Gen Grammar
mutationGenerator ast = do
  tipo <- escolherTipo
  case tipo of
    1 -> return (mutateAddZipper ast)
    2 -> return (mutateMinusZipper ast)
    3 -> return (mutateDivZipper ast)
    4 -> return (mutateMultZipper ast)
    5 -> return (mutateTrueFalseZipper ast)
    6 -> return (mutateToLessZipper ast)
    7 -> return (mutateToLEqualZipper ast)
    8 -> return (mutateToMoreZipper ast)
    9 -> return (mutateToMEqualZipper ast)
    10 -> return (mutateToEqualZipper ast)
    11 -> return (mutateToNEqualZipper ast)
    12 -> return (mutateLogicZipper ast)
    13 -> return (mutateNotZipper ast)
    14 -> return (mutateConstZipper ast)
    15 -> return (mutateVarToConstZipper ast)
    _ -> return ast 



-- mutante para tranformar qual operador numérico numa soma
mutateToAdd :: Exp -> Maybe Exp
mutateToAdd (Mul a b) = Just (Add a b)
mutateToAdd (Div a b) = Just (Add a b)
mutateToAdd (Minus a b) = Just (Add a b)
mutateToAdd e = Nothing

mutateAddZipper :: Grammar -> Grammar
mutateAddZipper l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (once_tdTP step) arvZipper
            where step = failTP `adhocTP` mutateToAdd
    in fromZipper listaNova

-- mutante para tranformar qual operador numérico numa subtração
mutateToMinus :: Exp -> Maybe Exp
mutateToMinus (Mul a b) = Just (Minus a b)
mutateToMinus (Div a b) = Just (Minus a b)
mutateToMinus (Add a b) = Just (Minus a b)
mutateToMinus e = Nothing

mutateMinusZipper :: Grammar -> Grammar
mutateMinusZipper l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (once_tdTP step) arvZipper
            where step = failTP `adhocTP` mutateToMinus
    in fromZipper listaNova

-- mutante para tranformar qual operador numérico numa divisão
mutateToDiv :: Exp -> Maybe Exp
mutateToDiv (Mul a b) = Just (Div a b)
mutateToDiv (Minus a b) = Just (Div a b)
mutateToDiv (Add a b) = Just (Div a b)
mutateToDiv e = Nothing

mutateDivZipper :: Grammar -> Grammar
mutateDivZipper l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (once_tdTP step) arvZipper
            where step = failTP `adhocTP` mutateToDiv
    in fromZipper listaNova

-- mutante para tranformar qual operador numérico numa multiplicação
mutateToMult :: Exp -> Maybe Exp
mutateToMult (Mul a b) = Just (Mul a b)
mutateToMult (Minus a b) = Just (Mul a b)
mutateToMult (Add a b) = Just (Mul a b)
mutateToMult e = Nothing

mutateMultZipper :: Grammar -> Grammar 
mutateMultZipper l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (once_tdTP step) arvZipper
            where step = failTP `adhocTP` mutateToMult
    in fromZipper listaNova




-- mutante para alterar valor de Constante
mutateConst :: Exp -> Maybe Exp
mutateConst (Add (Const a) b) = Just (Add (Const (a+3)) b)
mutateConst (Add a (Const b)) = Just (Add a (Const (b+3)))
mutateConst (Minus (Const a) b) = Just (Minus (Const (a+3)) b)
mutateConst (Minus a (Const b)) = Just (Minus a (Const (b+3)))
mutateConst (Mul (Const a) b) = Just (Mul (Const (a+3)) b)
mutateConst (Mul a (Const b)) = Just (Mul a (Const (b+3)))
mutateConst (Div (Const a) b) = Just (Div (Const (a+3)) b)
mutateConst (Div a (Const b)) = Just (Div a (Const (b+3)))
mutateConst e = Nothing

mutateConstZipper :: Grammar -> Grammar
mutateConstZipper l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (once_tdTP step) arvZipper
            where step = failTP `adhocTP` mutateConst
    in fromZipper listaNova


-- mutante para transformar Variável em Constante
mutateVarToConst :: Exp -> Maybe Exp
mutateVarToConst (Add a (Var _)) = Just (Add a (Const 1))
mutateVarToConst (Add (Var _) b) = Just (Add (Const 1) b)
mutateVarToConst (Minus a (Var _)) = Just (Minus a (Const 1))
mutateVarToConst (Minus (Var _) b) = Just (Minus (Const 1) b)
mutateVarToConst (Mul (Var _) b) = Just (Mul (Const 1) b)
mutateVarToConst (Mul a (Var _)) = Just (Mul a (Const 1))
mutateVarToConst (Div (Var _) b) = Just (Div (Const 1) b)
mutateVarToConst (Div a (Var _)) = Just (Div a (Const 1))
mutateVarToConst e = Nothing

mutateVarToConstZipper :: Grammar -> Grammar
mutateVarToConstZipper l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (once_tdTP step) arvZipper
            where step = failTP `adhocTP` mutateVarToConst
    in fromZipper listaNova



-- mutante para alterar o valor de True ou False
mutateTrueFalse :: Exp -> Maybe Exp
mutateTrueFalse True = Just False
mutateTrueFalse False = Just True
mutateTrueFalse e = Nothing

mutateTrueFalseZipper :: Grammar -> Grammar
mutateTrueFalseZipper l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (once_tdTP step) arvZipper
            where step = failTP `adhocTP` mutateTrueFalse
    in fromZipper listaNova



-- mutante para transformar operadores relacionais no operador '<'
mutateToLess :: Exp -> Maybe Exp
mutateToLess (LEqual a b) = Just (Less a b)
mutateToLess (More a b) = Just (Less a b)
mutateToLess (MEqual a b) = Just (Less a b)
mutateToLess (Equal a b) = Just (Less a b)
mutateToLess (NotEqual a b) = Just (Less a b)
mutateToLess e = Nothing

mutateToLessZipper :: Grammar -> Grammar
mutateToLessZipper l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (once_tdTP step) arvZipper
            where step = failTP `adhocTP` mutateToLess
    in fromZipper listaNova


-- mutante para transformar operadores relacionais no operador '<='
mutateToLEqual :: Exp -> Maybe Exp
mutateToLEqual (Less a b) = Just (LEqual a b)
mutateToLEqual (More a b) = Just (LEqual a b)
mutateToLEqual (MEqual a b) = Just (LEqual a b)
mutateToLEqual (Equal a b) = Just (LEqual a b)
mutateToLEqual (NotEqual a b) = Just (LEqual a b)
mutateToLEqual e = Nothing

mutateToLEqualZipper :: Grammar -> Grammar 
mutateToLEqualZipper l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (once_tdTP step) arvZipper
            where step = failTP `adhocTP` mutateToLEqual
    in fromZipper listaNova


-- mutante para transformar operadores relacionais no operador '>'
mutateToMore :: Exp -> Maybe Exp
mutateToMore (Less a b) = Just (More a b)
mutateToMore (LEqual a b) = Just (More a b)
mutateToMore (MEqual a b) = Just (More a b)
mutateToMore (Equal a b) = Just (More a b)
mutateToMore (NotEqual a b) = Just (More a b)
mutateToMore e = Nothing

mutateToMoreZipper :: Grammar -> Grammar
mutateToMoreZipper l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (once_tdTP step) arvZipper
            where step = failTP `adhocTP` mutateToMore
    in fromZipper listaNova


-- mutante para transformar operadores relacionais no operador '>='
mutateToMEqual :: Exp -> Maybe Exp
mutateToMEqual (Less a b) = Just (MEqual a b)
mutateToMEqual (LEqual a b) = Just (MEqual a b)
mutateToMEqual (More a b) = Just (MEqual a b)
mutateToMEqual (Equal a b) = Just (MEqual a b)
mutateToMEqual (NotEqual a b) = Just (MEqual a b)
mutateToMEqual e = Nothing

mutateToMEqualZipper :: Grammar -> Grammar 
mutateToMEqualZipper l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (once_tdTP step) arvZipper
            where step = failTP `adhocTP` mutateToMEqual
    in fromZipper listaNova




-- mutante para transformar operadores relacionais no operador '=='
mutateToEqual :: Exp -> Maybe Exp
mutateToEqual (Less a b) = Just (Equal a b)
mutateToEqual (LEqual a b) = Just (Equal a b)
mutateToEqual (More a b) = Just (Equal a b)
mutateToEqual (MEqual a b) = Just (Equal a b)
mutateToEqual (NotEqual a b) = Just (Equal a b)
mutateToEqual e = Nothing

mutateToEqualZipper :: Grammar -> Grammar 
mutateToEqualZipper l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (once_tdTP step) arvZipper
            where step = failTP `adhocTP` mutateToEqual
    in fromZipper listaNova


-- mutante para transformar operadores relacionais no operador '=='
mutateToNEqual :: Exp -> Maybe Exp
mutateToNEqual (Less a b) = Just (NotEqual a b)
mutateToNEqual (LEqual a b) = Just (NotEqual a b)
mutateToNEqual (More a b) = Just (NotEqual a b)
mutateToNEqual (MEqual a b) = Just (NotEqual a b)
mutateToNEqual (Equal a b) = Just (NotEqual a b)
mutateToNEqual e = Nothing

mutateToNEqualZipper :: Grammar -> Grammar
mutateToNEqualZipper l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (once_tdTP step) arvZipper
            where step = failTP `adhocTP` mutateToNEqual
    in fromZipper listaNova






-- mutante para expressões lógicas
mutateLogic :: Exp -> Maybe Exp
mutateLogic (And a b) = Just (Or a b)
mutateLogic (Or a b) = Just (And a b)
mutateLogic e = Nothing

mutateLogicZipper :: Grammar -> Grammar 
mutateLogicZipper l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (once_tdTP step) arvZipper
            where step = failTP `adhocTP` mutateLogic
    in fromZipper listaNova



-- mutante para o operador negação '!'
mutateNot :: Exp -> Maybe Exp
mutateNot (Not e) = Just e
mutateNot e = Nothing

mutateNotZipper :: Grammar -> Grammar 
mutateNotZipper l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (once_tdTP step) arvZipper
            where step = failTP `adhocTP` mutateNot
    in fromZipper listaNova