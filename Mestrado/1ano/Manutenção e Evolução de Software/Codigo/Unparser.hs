{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant bracket" #-}
module Unparser where


import Prelude hiding ((<*>),(<$>),True,False)
import Gramatica
import Parser
import Opt
import Ast

exampleFor = fst $ head $ parser "for(i=1;i<10;i=i+1){b=4;};"
exampleNot = fst $ head $ parser "!(!(a<1)); 1+1;"

unparser :: Grammar -> String
unparser (Grammar []) = ""
unparser (Grammar l) = unpStatements l


unpStatements :: [Statement] -> String
unpStatements [] = ""
unpStatements (h:t) = (unpStatement h) ++ "; " ++ (unpStatements t)

unpArgs :: [Statement] -> String
unpArgs [] = ""
unpArgs [h] = unpStatement h
unpArgs (h:t) = (unpStatement h) ++ ", " ++ (unpArgs t)

unpStatement :: Statement -> String
unpStatement (Atrib s exp) = s ++ " = " ++ unpExp exp
unpStatement (While exp stats) = "while (" ++ (unpExp exp) ++") {" ++ (unpStatements stats) ++"}"
unpStatement (For listArgs stats) = "for (" ++ (unpListaSemicolonExp listArgs) ++") {" ++ (unpStatements stats) ++"}"
unpStatement (Decl t s) = unpType t ++ s
unpStatement (If exp stats []) = "if (" ++ (unpExp exp) ++ ") {" ++ (unpStatements stats) ++ "}"
unpStatement (If exp stat1 stat2) = "if (" ++ (unpExp exp) ++ ") {" ++ (unpStatements stat1) ++ "} else {" ++ (unpStatements stat2) ++ "}"
unpStatement (Function s stat1 stat2) = "function " ++ s ++ " (" ++ (unpArgs stat1) ++ ") {" ++ (unpStatements stat2) ++ "}"
unpStatement (Exp exp) = unpExp exp
unpStatement (Return s) = "return " ++ unpStatement s

unpListaSemicolonExp :: [Statement] -> String
unpListaSemicolonExp [] = ""
unpListaSemicolonExp [h] = unpStatement h
unpListaSemicolonExp (h:t) = (unpStatement h) ++ ";" ++ (unpListaSemicolonExp t)

unpListaExp :: [Exp] -> String
unpListaExp [] = ""
unpListaExp [h] = unpExp h
unpListaExp (h:t) = (unpExp h) ++ "," ++ (unpListaExp t)

unpExp :: Exp -> String
unpExp (Add e1 e2) = (unpExp e1) ++ " + " ++ unpExp e2
unpExp (Minus e1 e2) = (unpExp e1) ++ " - " ++ unpExp e2
unpExp (Mul e1 e2) = (unpExp e1) ++ " * " ++ unpExp e2
unpExp (Div e1 e2) = (unpExp e1) ++ " / " ++ unpExp e2
unpExp (Const i) = show i
unpExp (True) = "true"
unpExp (False) = "false"
unpExp (Var s) = s
unpExp (Less e1 e2) = (unpExp e1) ++ " < " ++ unpExp e2
unpExp (More e1 e2) = (unpExp e1) ++ " > " ++ unpExp e2
unpExp (LEqual e1 e2) = (unpExp e1) ++ " <= " ++ unpExp e2
unpExp (MEqual e1 e2) = (unpExp e1) ++ " >= " ++ unpExp e2
unpExp (Equal e1 e2) = (unpExp e1) ++ " == " ++ unpExp e2
unpExp (NotEqual e1 e2) = (unpExp e1) ++ " != " ++ unpExp e2
unpExp (Or e1 e2) = (unpExp e1) ++ " || " ++ unpExp e2
unpExp (And e1 e2) = (unpExp e1) ++ " && " ++ unpExp e2
unpExp (FunCall s exp) = "fun " ++ s ++ " (" ++ (unpListaExp exp) ++ ")"
unpExp (Str s) = s
unpExp (Not e) = "!(" ++ (unpExp e) ++ ")"

unpType :: Type -> String
unpType Int = "int "
unpType Float = "float "
unpType Double = "double "
unpType String = "string "