{-# LANGUAGE FlexibleInstances #-}


module Properties where

import Ast
import Gramatica
import Unparser
import Opt
import OptID
import Generator

import Test.QuickCheck

import Prelude hiding ((<*>),(<$>),True,False)


instance Arbitrary Grammar where
     arbitrary = genGrammar


-- fazer parsing após o pretty printing de uma ast, produz essa mesma ast
prop_ParseAfterPrinting :: Grammar -> Bool
prop_ParseAfterPrinting ast = fst( head( parser(unparser ast) ) ) == ast


-- testar se diferentes estratégias (topdown, bottomup, innermost, etc) usadas na eliminação de smells e otimização de expressões aritméticas são equivalentes
prop_DifferentStrategies :: Grammar -> Bool
prop_DifferentStrategies ast = 
    optGrammar ast == optGrammarOuter ast &&
    optGrammarOuter ast == optGrammarOnceTD ast &&
    optGrammarOnceTD ast == optGrammarOnceBUp ast &&
    optGrammarOnceBUp ast == optGrammarFullBUp ast &&
    optGrammarFullBUp ast == optGrammarFullTDown ast



-- testar se a eliminação de smells e a otimização de expressões aritméticas ́e comutativo
prop_SmellsExp :: Grammar -> Bool
prop_SmellsExp ast = optSmellsBefore ast == optGrammar ast