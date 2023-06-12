
module Opt where

import Prelude hiding (True,False)

import Ast
import Gramatica

import Data.Generics.Zipper
import Library.Ztrategic 
import Library.StrategicData (StrategicData)

instance StrategicData Int
instance StrategicData Statement
instance StrategicData Grammar
instance StrategicData a => StrategicData [a]



example = fst $ head $ parser "a + 2 ; while (2*1 < 5) { b = 2*0; };"
exampleLogica = fst $ head $ parser  "a + 2 < 1 && 20 / 1 >= 0;"
exampleFunc = fst $ head $ parser "fun grammar(2+0, arg);"
exampleAritmetic = fst $ head $ parser "2*1; 0/5; a = 0*3;"
exampleFor = fst $ head $ parser "for(i=1;i<10;i=i+1){b=4;};"
exampleIfTrueFalse = fst $ head $ parser "if(i==1){return true;} else {return false;};2*1;"
exampleExpAndStat = fst $ head $ parser "if(i==1){return true;} else {return false;};2*1;"
exampleNotLogica = fst $ head $ parser "!(true); !(a < 1);"
exampleNotEncadeado = fst $ head $ parser "!( !( !(true) ) );"


optGrammar :: Grammar -> Grammar
optGrammar l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (innermost step) arvZipper
            where step = failTP `adhocTP` optExp `adhocTP` optSmellsStat
    in fromZipper listaNova

optGrammarOuter :: Grammar -> Grammar
optGrammarOuter l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (outermost step) arvZipper
            where step = failTP `adhocTP` optExp `adhocTP` optSmellsStat
    in fromZipper listaNova




optGrammarOnceTD :: Grammar -> Grammar
optGrammarOnceTD l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (once_tdTP step) arvZipper
            where step = failTP `adhocTP` optExp `adhocTP` optSmellsStat 
    in fromZipper listaNova

optGrammarOnceBUp :: Grammar -> Grammar
optGrammarOnceBUp l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (once_buTP step) arvZipper
            where step = failTP `adhocTP` optExp `adhocTP` optSmellsStat 
    in fromZipper listaNova



optSmellsBefore :: Grammar -> Grammar
optSmellsBefore l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (innermost step) arvZipper
            where step = failTP `adhocTP` optSmellsStat `adhocTP` optExp
    in fromZipper listaNova
    





optExp :: Exp -> Maybe Exp
optExp (Add (Const 0) e) = Just e
optExp (Add e (Const 0)) = Just e
optExp (Add (Const a) (Const b)) = Just (Const (a+b))

optExp (Minus (Const 0) (Const e)) = Just (Const (-e))
optExp (Minus (Const 0) e) = Just e
optExp (Minus e (Const 0)) = Just e
optExp (Minus (Const a) (Const b)) = Just (Const (a-b))

optExp (Mul (Const 0) e) = Just (Const 0)
optExp (Mul e (Const 0)) = Just (Const 0)
optExp (Mul (Const 1) e) = Just e
optExp (Mul e (Const 1)) = Just e

optExp (Div (Const 0) e) = Just (Const 0)
optExp (Div e (Const 1)) = Just e
-- optExp (Div e (Const 0)) = ERRO?

optExp (Less (Const c1) (Const c2)) = if (c1 < c2) then Just True else Just False
optExp (More (Const c1) (Const c2)) = if (c1 < c2) then Just True else Just False
optExp (LEqual (Const c1) (Const c2)) = if (c1 < c2) then Just True else Just False
optExp (MEqual (Const c1) (Const c2)) = if (c1 < c2) then Just True else Just False
optExp (Equal (Const c1) (Const c2)) = if (c1 == c2) then Just True else Just False
optExp (NotEqual (Const c1) (Const c2)) = if (c1 /= c2) then Just True else Just False

optExp (Or True exp) = Just True
optExp (Or exp True) = Just True
optExp (And False exp) = Just False
optExp (And exp False) = Just False

optExp (Not (True)) = Just False
optExp (Not (False)) = Just True
optExp (Not (Less e1 e2)) = Just (MEqual e1 e2)
optExp (Not (More e1 e2)) = Just (LEqual e1 e2)
optExp (Not (LEqual e1 e2)) = Just (More e1 e2)
optExp (Not (MEqual e1 e2)) = Just (Less e1 e2)
optExp (Not (Equal e1 e2)) = Just (NotEqual e1 e2)
optExp (Not (NotEqual e1 e2)) = Just (Equal e1 e2)

optExp _ = Nothing


optSmellsStat :: Statement -> Maybe Statement
optSmellsStat (If e [Return (Exp True)] [Return (Exp False)]) = Just (Return (Exp e))
optSmellsStat _ = Nothing