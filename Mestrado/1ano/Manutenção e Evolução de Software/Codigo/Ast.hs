{-# LANGUAGE DeriveDataTypeable #-}

module Ast where

import Prelude hiding ((<*>),(<$>))

import Data.Data       



data Grammar = Grammar [Statement]
        deriving (Show,Data,Eq)

data Statement = Atrib String Exp                        -- a = 3+2
               | While Exp [Statement]                   -- while (3+a < 10) { int b; }
               | For [Statement] [Statement]             -- for (i=0; i<5; i=i+1) { ... }
               | Decl Type String                        -- double a;
               | If Exp [Statement] [Statement]          -- if (3+a < 10) {a = 2;} else { a = 3; } --> else is opcional
               | Function String [Statement] [Statement] -- function name (arg, args) { int b; b = 4+5;}
               | Exp Exp                                 -- 3 + 1
               | Return Statement                        -- return 3*2
               deriving (Show,Data,Eq)

data Exp = Add Exp Exp      -- +
         | Minus Exp Exp    -- -
         | Mul Exp Exp      --  *
         | Div Exp Exp      -- /
         | Const Int        -- number
         | True             -- true
         | False            -- false
         | Var String       -- string 
         | Less Exp Exp     -- <
         | More Exp Exp     -- > 
         | LEqual Exp Exp   -- <=
         | MEqual Exp Exp   -- = >
         | Equal Exp Exp    -- ==
         | NotEqual Exp Exp -- !=      
         | Or Exp Exp       -- ||
         | And Exp Exp      -- &&
         | FunCall String [Exp]  -- func (a+1, "bbc")
         | Str String       -- "example"
         | Not Exp          -- !(a<2)
        deriving (Show,Data,Eq)

data Type = Int
          | Float
          | Double
          | String
          deriving (Show,Data,Eq)
          