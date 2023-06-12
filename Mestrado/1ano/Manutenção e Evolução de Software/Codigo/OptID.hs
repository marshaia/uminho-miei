
module OptID where

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



optGrammarFullBUp :: Grammar -> Grammar
optGrammarFullBUp l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (full_buTP step) arvZipper
            where step = idTP `adhocTP` optExpID `adhocTP` optSmellsStatID
    in fromZipper listaNova

optGrammarFullTDown :: Grammar -> Grammar
optGrammarFullTDown l =
    let arvZipper    = toZipper l
        Just listaNova = applyTP (full_tdTP step) arvZipper
            where step = idTP `adhocTP` optExpID `adhocTP` optSmellsStatID
    in fromZipper listaNova






optExpID :: Exp -> Maybe Exp
optExpID (Add (Const 0) e) = Just e
optExpID (Add e (Const 0)) = Just e
optExpID(Add (Const a) (Const b)) = Just (Const (a+b))

optExpID (Minus (Const 0) (Const e)) = Just (Const (-e))
optExpID (Minus (Const 0) e) = Just e
optExpID (Minus e (Const 0)) = Just e
optExpID (Minus (Const a) (Const b)) = Just (Const (a-b))

optExpID (Mul (Const 0) e) = Just (Const 0)
optExpID (Mul e (Const 0)) = Just (Const 0)
optExpID (Mul (Const 1) e) = Just e
optExpID (Mul e (Const 1)) = Just e

optExpID (Div (Const 0) e) = Just (Const 0)
optExpID (Div e (Const 1)) = Just e
-- optExp (Div e (Const 0)) = ERRO?

optExpID (Less (Const c1) (Const c2)) = if (c1 < c2) then Just True else Just False
optExpID (More (Const c1) (Const c2)) = if (c1 < c2) then Just True else Just False
optExpID (LEqual (Const c1) (Const c2)) = if (c1 < c2) then Just True else Just False
optExpID (MEqual (Const c1) (Const c2)) = if (c1 < c2) then Just True else Just False
optExpID (Equal (Const c1) (Const c2)) = if (c1 == c2) then Just True else Just False
optExpID (NotEqual (Const c1) (Const c2)) = if (c1 /= c2) then Just True else Just False

optExpID (Or True exp) = Just True
optExpID (Or exp True) = Just True
optExpID (And False exp) = Just False
optExpID (And exp False) = Just False

optExpID (Not (True)) = Just False
optExpID (Not (False)) = Just True
optExpID (Not (Less e1 e2)) = Just (MEqual e1 e2)
optExpID (Not (More e1 e2)) = Just (LEqual e1 e2)
optExpID (Not (LEqual e1 e2)) = Just (More e1 e2)
optExpID (Not (MEqual e1 e2)) = Just (Less e1 e2)
optExpID (Not (Equal e1 e2)) = Just (NotEqual e1 e2)
optExpID (Not (NotEqual e1 e2)) = Just (Equal e1 e2)
optExpID (Not (Not e)) = Just e

optExpID e = Just e



optSmellsStatID :: Statement -> Maybe Statement
optSmellsStatID (If e [Return (Exp True)] [Return (Exp False)]) = Just (Return (Exp e))
optSmellsStatID e = Just e