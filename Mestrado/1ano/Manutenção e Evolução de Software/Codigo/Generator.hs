{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use <$>" #-}
{-# HLINT ignore "Redundant bracket" #-}
{-# HLINT ignore "Use <&>" #-}
{-# HLINT ignore "Redundant return" #-}

module Generator where

import Control.Monad.State
import Control.Monad (replicateM)
import Test.QuickCheck
import Control.Monad.Trans.State (evalStateT)
import Ast
    ( Exp(..),
      Statement(Exp, Atrib, While, If, Function, Decl,Return, For),
      Type(..),
      Grammar(..) )
import Prelude hiding (Bool(..), True, False)
import Data.Set(null)


type Vars = [String]


genGrammar :: Gen Grammar
genGrammar = do 
       lista <- evalStateT (replicateM 1 genStatement) []
       return $ Grammar lista


main :: IO()
main = do (generatedValues,state) <- generate $ runStateT (replicateM 5 genStatement) []
          putStrLn $ "Generated values: " ++ show generatedValues
          putStrLn $ "State: " ++ show state

---------------------------Geradores Básicos----------------------------

genString :: StateT Vars Gen String
genString = lift $ vectorOf 4 (choose('a','z'))


genUniqueString :: StateT Vars Gen String
genUniqueString = do varString <- genString
                     state <- get
                     if varString `elem` state
                     then genUniqueString
                     else do modify (varString :)
                             return varString

genExistingVar :: StateT Vars Gen String
genExistingVar = do state <- get
                    lift $ elements state

genExpString :: StateT Vars Gen Exp
genExpString = do string <- genString
                  return (Str string)

genNumber :: StateT Vars Gen Int
genNumber =  lift $ choose (0, 200)

genBoolean :: StateT Vars Gen Exp
genBoolean = lift $ elements ([True,False])

genType :: StateT Vars Gen Type
genType = lift $ elements ([Int,Float,Double,String])


------------------------- Gerador de Statements ------------------------

--genSizedStat :: Gen [Statement]
--genSizedStat = sized (\n -> resize (n `div` 2) (genListStat n))
--
--genListStat :: Int -> Gen [Statement]
--genListStat n = do size <- choose (0, n)
--                   statements <- vectorOf size genStatement
--                   return statements


genStatement :: StateT Vars Gen Statement
genStatement = do state <- get
                  if Prelude.null state 
                    then genStatementNoAtrib
                    else genStatementFull

genStatementFull :: StateT Vars Gen Statement
genStatementFull = do state <- get
                      (result,finalState) <- lift $ frequency 
                        ([(1, do (math,nextState) <- runStateT genMath state
                                 return (math,nextState)),
                          (10, do (atrib,nextState) <- runStateT genAtrib state
                                  return (atrib,nextState)),
                          (1, do (decl,nextState) <- runStateT genDecl state
                                 return (decl,nextState)),
                          (1, do (func,nextState) <- runStateT genFuntion state
                                 return (func,nextState)),
                          (1, do (funcCall,nextState) <- runStateT genFunCall state
                                 return (funcCall,nextState)),
                          (1, do (while,nextState) <- runStateT genWhile state
                                 return (while,nextState)),
                          (1, do (iff,nextState) <- runStateT genIf state
                                 return (iff,nextState)),
                          (1, do (for,nextState) <- runStateT genFor state
                                 return (for,nextState))
                        ])
                      put finalState
                      return result


genStatementNoAtrib :: StateT Vars Gen Statement
genStatementNoAtrib = do state <- get
                         (result,finalState) <- lift $ frequency 
                           ([(1, do (math,nextState) <- runStateT genMath state
                                    return (math,nextState)),
                             (1, do (decl,nextState) <- runStateT genDecl state
                                    return (decl,nextState)),
                             (1, do (func,nextState) <- runStateT genFuntion state
                                    return (func,nextState)),
                             (1, do (funcCall,nextState) <- runStateT genFunCall state
                                    return (funcCall,nextState)),
                             (1, do (while,nextState) <- runStateT genWhile state
                                    return (while,nextState)),
                             (1, do (iff,nextState) <- runStateT genIf state
                                    return (iff,nextState))
                            ])
                         put finalState
                         return result
    
    
    
    
------------------- Gerador Statments Dentro de Funções ----------------


genStatementFunc ::  StateT Vars Gen Statement
genStatementFunc = do state <- get
                      if Prelude.null state 
                        then genStatementFuncNoAtrib
                        else genStatementFuncFull

genStatementFuncFull :: StateT Vars Gen Statement
genStatementFuncFull = do state <- get
                          (result,finalState) <- lift $ frequency 
                              ([(1, do (math,nextState) <- runStateT  genMath state
                                       return (math,nextState)),
                                (1, do (decl,nextState) <- runStateT genDecl state
                                       return (decl,nextState)),
                                (1, do (atrib,nextState) <- runStateT  genAtrib state
                                       return (atrib,nextState)),
                                (1, do (while,nextState) <- runStateT genWhile state
                                       return (while,nextState)),
                                (2, do (iff,nextState) <- runStateT genIf state
                                       return (iff,nextState)),
                                (1, do (funcCall,nextState) <- runStateT genFunCall state
                                       return (funcCall,nextState)),
                                (1 ,do (returnn,nextState) <- runStateT genReturn state
                                       return (returnn,nextState))
                                ])
                          put finalState
                          return result


genStatementFuncNoAtrib :: StateT Vars Gen Statement
genStatementFuncNoAtrib = do state <- get
                             (result,finalState) <- lift $ frequency 
                                 ([(1, do (math,nextState) <- runStateT genMath state
                                          return (math,nextState)),
                                   (1, do (decl,nextState) <- runStateT genDecl state
                                          return (decl,nextState)),
                                   (1, do (while,nextState) <- runStateT genWhile state
                                          return (while,nextState)),
                                   (2, do (iff,nextState) <- runStateT genIf state
                                          return (iff,nextState)),
                                   (1, do (funcCall,nextState) <- runStateT genFunCall state
                                          return (funcCall,nextState)),
                                   (1 ,do (returnn,nextState) <- runStateT genReturn state
                                          return (returnn,nextState))
                                   ])
                             put finalState
                             return result
    

---------------------------- Gerador Atribuição -------------------------


genAtrib ::  StateT Vars Gen Statement
genAtrib = do var <- genExistingVar
              exp <- genExp
              return(Atrib var exp)


------------------------------ Gerador While -------------------------

genWhile :: StateT Vars Gen Statement
genWhile = do exp <- genLogic  
              stateList <- replicateM 2 genStatementFunc
              return (While exp stateList)



------------------------------- Gerador For -------------------------


genFor :: StateT Vars Gen Statement
genFor = do argumentos <- replicateM 1 genForArg
            statesList <- replicateM 1 genStatement
            return (For argumentos statesList)

genForArg :: StateT Vars Gen Statement
genForArg = do exp <- genExp
               atrib <- genAtrib
               lift $ frequency ([(20, return atrib),
                                  (1, return (Exp exp))])


------------------------------- Gerador If -------------------------


genIf :: StateT Vars Gen Statement
genIf = do logic <- genLogic
           ifState <- replicateM 1 genStatementFunc 
           elseState <- replicateM 2 genStatementFunc
           return (If logic ifState ifState)


---------------------------- Gerador Function -------------------------


genFuntion :: StateT Vars Gen Statement
genFuntion = do state <- get
                name <- genString
                (args,nextState) <- lift $ runStateT (replicateM 1 genDecl) state
                content <- replicateM 1  genStatementFunc
                put nextState
                return (Function name args content)


------------------------- Gerador Function Call -----------------------


genFunCall :: StateT Vars Gen Statement
genFunCall = do name <- genString
                state <- get
                args <- replicateM 3 genFunCallArgs  -- nao exatamente como os argumentos que queriamos
                return(Exp (FunCall name args))


genFunCallArgs :: StateT Vars Gen Exp
genFunCallArgs = do state <- get
                    lift $ frequency ([(20, do expString <- evalStateT genExpString state
                                               return expString),
                                       (1,  do exp <- evalStateT genExp state
                                               return exp)])          


----------------------------- Gerador Declaração -------------------------

genDecl :: StateT Vars Gen Statement
genDecl = do t <- genType
             var <- genUniqueString
             return(Decl t var)


------------------------------ Gerador Lógica -------------------------

genLogic :: StateT Vars Gen Exp
genLogic = do state <- get
              lift $ frequency ([(1, do generatedValues <- evalStateT genLogic state
                                        return (Not generatedValues)),
                                 
                                 (1, do logic1 <- evalStateT genLogic state
                                        logic2 <- evalStateT genLogic state
                                        return (And logic1 logic2)),
                                 
                                 (1, do logic1 <- evalStateT genLogic state
                                        logic2 <- evalStateT genLogic state
                                        return (Or logic1 logic2)),
                                 
                                 (20, do boolean <- evalStateT genBoolean state
                                         return boolean),
                                         
                                 (1,  do ineq <- evalStateT genInequation state
                                         return ineq)])


---------------------------- Gerador Inequação -------------------------


genInequation :: StateT Vars Gen Exp
genInequation = do a <- genExp
                   b <- genExp
                   lift $ elements ([Less a b,
                                     More a b,
                                     LEqual a b,
                                     MEqual a b,
                                     Equal a b,
                                     NotEqual a b])

------------------------------ Gerador Exp -------------------------


genExp :: StateT Vars Gen Exp
genExp = do term1 <- genTerm
            term2 <- genTerm
            lift $ elements ([Add term1 term2,
                              Minus term1 term2,
                              term1])


genTerm :: StateT Vars Gen Exp
genTerm = do factor1 <- genFactor
             factor2 <- genFactor
             lift $ elements ([Mul factor1 factor2,
                               Div factor1 factor2])


genFactor ::  StateT Vars Gen Exp
genFactor = do state <- get
               if Prelude.null state 
                 then genFactorNoAtrib
                 else genFactorFull


genFactorNoAtrib :: StateT Vars Gen Exp
genFactorNoAtrib = do state <- get
                      lift $ frequency ([(10, do num <- evalStateT genNumber state
                                                 return (Const num)),
                                         (1,  do exp <- evalStateT genExp state
                                                 return exp)
                                         ])

genFactorFull :: StateT Vars Gen Exp
genFactorFull = do state <- get
                   lift $ frequency ([(1,  do num <- evalStateT genNumber state
                                              return (Const num)),
                                      (20, do var <- evalStateT genExistingVar state
                                              return (Var var)),
                                      (1,  do exp <- evalStateT genExp state
                                              return exp)])


------------------------- Gerador Return -----------------------

genReturn :: StateT Vars Gen Statement
genReturn = do math <- genMath
               return (Return math)

------------------------- Gerador Math -----------------------


genMath :: StateT Vars Gen Statement
genMath = do state <- get
             lift $ frequency ([(1,do exp <- evalStateT genExp state
                                      return (Exp exp)),
                                (1,do logic <- evalStateT genLogic state
                                      return (Exp logic)),
                                (1,do ineq <- evalStateT genInequation state
                                      return (Exp ineq))])
