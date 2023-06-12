module Gramatica where

import Prelude hiding ((<*>),(<$>),True,False)
import Parser
import Ast



parser :: Parser Grammar
parser =  f <$> parserStats
    where f a = Grammar a


parserStats :: Parser [Statement]
parserStats =  f <$> spaces <*> pStatements <*> symbol' ';' <*> parserStats
      <|>       succeed []
    where f _ a _ c = a : c



pStatements :: Parser Statement
pStatements =  pAtribuicao
           <|> pWhile
           <|> pFor
           <|> pIf
           <|> pFuncaoDef
           <|> pFuncaoCall
           <|> pDeclaracao
           <|> pMath



pAtribuicao :: Parser Statement
pAtribuicao = f <$> ident <*> symbol' '=' <*> pExp
    where f a _ c = Atrib a c


pWhile :: Parser Statement
pWhile = f <$> token' "while" <*> enclosedBy (symbol' '(' ) pLogica (symbol' ')')  <*> enclosedBy (symbol' '{') pInsideFunc (symbol' '}')    
    where f t l c = While l c

pFor :: Parser Statement
pFor = f <$> token' "for" <*> enclosedBy (symbol' '(') pForArgs (symbol' ')') <*> enclosedBy (symbol' '{') pInsideFunc (symbol' '}')
    where f _ args c = For args c

pForArgs :: Parser [Statement]
pForArgs = separatedBy pForArg (symbol' ';')

pForArg :: Parser Statement
pForArg =  pAtribuicao
       <|> g <$> pLogica
    where g a = Exp a

pIf :: Parser Statement
pIf = f <$> token' "if" <*> enclosedBy (symbol' '(' ) pLogica (symbol' ')')  <*> enclosedBy (symbol' '{') pInsideFunc (symbol' '}')  <*> pElse
    where f a l c e = If l c e

pElse :: Parser [Statement]
pElse =  f <$> token' "else" <*> enclosedBy (symbol' '{') pInsideFunc (symbol' '}')      
     <|>       succeed []
    where f t c = c



pFuncaoCall :: Parser Statement
pFuncaoCall = f <$> token' "fun" <*> ident <*> enclosedBy (symbol' '(') pArgumentosCall (symbol' ')') 
    where f t i arg = Exp (FunCall i arg)


pArgumentosCall :: Parser [Exp]
pArgumentosCall =  f <$> pArgumento <*> symbol' ',' <*> pArgumentosCall
           <|> g <$> pArgumento
    where
        f a _ c = a : c
        g a = [a]

pArgumento :: Parser Exp
pArgumento =  f <$> ident
          <|> g <$> pExp
    where 
        f s = Str s
        g e = e



pFuncaoDef :: Parser Statement
pFuncaoDef = f <$> token' "function" <*> ident <*> enclosedBy (symbol' '(') pArgumentosDef (symbol' ')') <*> enclosedBy (symbol' '{') pInsideFunc (symbol' '}')
    where f _ s arg cont = Function s arg cont


pArgumentosDef :: Parser [Statement]
pArgumentosDef =  f <$> pDeclaracao <*> symbol' ',' <*> pArgumentosDef
           <|> g <$> pDeclaracao
    where
        f a _ c = a : c
        g a = [a]

pInsideFunc :: Parser [Statement]
pInsideFunc = f <$> pStatementsFunc <*> symbol' ';' <*> pInsideFunc
           <|> succeed []
    where f a _ b = a : b

pStatementsFunc :: Parser Statement
pStatementsFunc =  pMath
               <|> pAtribuicao 
               <|> pWhile
               <|> pIf
               <|> pFuncaoCall
               <|> pDeclaracao
               <|> pReturn


pReturn :: Parser Statement
pReturn = f <$> token' "return" <*> pMath
    where f a b = Return b


pDeclaracao :: Parser Statement
pDeclaracao =  f <$> pType <*> ident
    where f a b = Decl a b


pMath :: Parser Statement
pMath =  f <$> pLogica
     <|> g <$> pInequacao
     <|> h <$> pExp
    where
        f a = Exp a
        g a = Exp a
        h a = Exp a

-- ---------------------------------------------------------------------------

pLogica :: Parser Exp
pLogica =  h <$> symbol' '!' <*> enclosedBy (symbol' '(') pLogica (symbol' ')')
       <|> f <$> pInequacao <*> token' "||" <*> pLogica
       <|> g <$> pInequacao <*> token' "&&" <*> pLogica
       <|> pBoolean
       <|> pInequacao
    where
        h _ c   = Not c
        f a _ c = Or a c
        g a _ c = And a c


pBoolean :: Parser Exp
pBoolean =  f <$> token' "true"
        <|> g <$> token' "false"
    where
        f a = True
        g a = False


pInequacao :: Parser Exp
pInequacao =  f <$> pExp <*> symbol' '<' <*> pExp
          <|> g <$> pExp <*> symbol' '>' <*> pExp
          <|> h <$> pExp <*> token' "<=" <*> pExp
          <|> z <$> pExp <*> token' ">=" <*> pExp
          <|> e <$> pExp <*> token' "==" <*> pExp
          <|> n <$> pExp <*> token' "!=" <*> pExp
          <|> pBoolean
          <|> pExp
    where
        f a _ c = Less a c
        g a _ c = More a c
        h a _ c = LEqual a c
        z a _ c = MEqual a c
        e a _ c = Equal a c
        n a _ c = NotEqual a c


pExp :: Parser Exp
pExp =  f  <$> pTermo <*> symbol' '+' <*> pExp
    <|> g  <$> pTermo <*> symbol' '-' <*> pExp
    <|> pBoolean
    <|> id <$> pTermo
    where 
        f a _ c = Add a c
        g a _ c = Minus a c
          

pTermo :: Parser Exp
pTermo =  f  <$> pFactor <*> symbol' '*' <*> pTermo
      <|> g  <$> pFactor <*> symbol' '/' <*> pTermo
      <|> pBoolean
      <|> id <$> pFactor
    where 
        f a _ c = Mul a c
        g a _ c = Div a c
 

pFactor :: Parser Exp
pFactor =  f   <$> number
       <|> Var <$> ident
       <|> g   <$> enclosedBy (symbol' '(') pExp (symbol' ')')
       where f a = Const (read a)
             g a = a

pType :: Parser Type
pType =  f <$> token' "int"
     <|> g <$> token' "float"
     <|> h <$> token' "double"
     <|> i <$> token' "string"
    where
        f a = Int
        g a = Float
        h a = Double
        i a = String