module Taubleaux where

import Data.List (nub, intersect)
import qualified Data.Set as Set
import Data.Set (Set)

import qualified LogicExpressionValidator as LEV

-- Definição de um tipo de dado para representar uma fórmula na Lógica Proposicional
{-
data LEV.Expression = LEV.Var String
                | LEV.Not LEV.Expression
                | LEV.And LEV.Expression LEV.Expression
                | LEV.Or LEV.Expression LEV.Expression
                | LEV.Imp LEV.Expression LEV.Expression
                deriving (Show, Eq) -- Show: permite que instâncias do tipo LEV.Expression sejam convertidos para string (através do comando "show"); Eq: Permite comparação de igualdade entre duas intância de LEV.Expression
-}

-- Definição do nós da árvore
data TableauNode = TableauNode -- Nó composto pela fórmula(Expressão) e se é verdadeiro ou falso
    { formula  :: LEV.Expression 
    , isTrue   :: Bool
    } deriving (Show, Eq)

-- Cria um nó inicial a partir de uma fórmula
createInitialNode :: LEV.Expression -> TableauNode
createInitialNode expr = TableauNode expr False -- False, pois queremos provar através de uma contradição

-- Expande nó através das REGRAS citadas
expandNode :: TableauNode -> [[TableauNode]]
expandNode (TableauNode (LEV.Imp a b) True) = [[TableauNode a True], [TableauNode b False]]
expandNode (TableauNode (LEV.Imp a b) False)  = [[TableauNode a False, TableauNode b True]]
expandNode (TableauNode (LEV.And a b) True)  = [[TableauNode a True, TableauNode b True]]
expandNode (TableauNode (LEV.And a b) False) = [[TableauNode a False], [TableauNode b False]]
expandNode (TableauNode (LEV.Or a b) True)   = [[TableauNode a True], [TableauNode b True]]
expandNode (TableauNode (LEV.Or a b) False)  = [[TableauNode a False, TableauNode b False]]
expandNode (TableauNode (LEV.Not a) True)    = [[TableauNode a False]]
expandNode (TableauNode (LEV.Not a) False)   = [[TableauNode a True]]
expandNode node                          = [[node]]

-- Função para verificar se um nó é uma variável simples ou já foi expandido completamente
isSimpleNode :: TableauNode -> Bool
isSimpleNode (TableauNode (LEV.Var _) _) = True
isSimpleNode _ = False

-- Função para expandir nós recursivamente
-- NÃO ENTENDI ESSA FUNÇÃO --
expandTableau :: [TableauNode] -> IO [[TableauNode]]
expandTableau [] = return []
expandTableau (node:nodes)
    |isSimpleNode node = do
        restBranches <- expandTableau nodes
        return $ if null restBranches
                 then [[node]]
                 else [node : branch | branch <- restBranches]
    |otherwise = do
        let expandedNodes = expandNode node
        putStrLn $ "Expanding node: " ++ show node
        mapM_ (putStrLn . ("Generated nodes: " ++) . show) expandedNodes
        expandedBranches <- mapM expandTableau (map (++nodes)expandedNodes)
        return $ concat expandedBranches


-- Função principal para iniciar a expansão do tableau
expandInitialTableau :: LEV.Expression -> IO [[TableauNode]]
expandInitialTableau expr = expandTableau [createInitialNode expr]

----------- ATÉ AQUI FOI !!! -------------

-- Função para verificar se há pelo menos um par com contradição em uma lista
check :: [TableauNode] -> Bool
check [] = False  -- Lista vazia não tem contradição
check nodes = any hasContradictionPair [(x, y) | x <- nodes, y <- nodes, x /= y]
    where
        hasContradictionPair (x, y) = formula x == formula y && isTrue x /= isTrue y

-- Função para verificar se há pelo menos uma lista com contradição em uma lista de listas
hasContradiction :: [[TableauNode]] -> IO Bool
hasContradiction [] = return False  -- Lista de listas vazia não tem contradição
hasContradiction (x:xs) = do
    if check x
        then hasContradiction xs  -- Se há contradição, continuar verificando o restante da lista
        else do
            putStrLn $ "Contraexemplo: " ++ show x  -- Se não há contradição, imprimir o contraexemplo
            return True  -- Retornar True indicando que encontrou contradição


-- Representação da fórmula a → (a → (b → a))
formula1 :: LEV.Expression
formula1 = LEV.Imp (LEV.Var "a") (LEV.Imp (LEV.Var "a") (LEV.Imp (LEV.Var "b") (LEV.Var "a")))

-- Representação da fórmula b → (a ∧ (b ∨ a))
formula2 :: LEV.Expression
formula2 = LEV.Imp (LEV.Var "b") (LEV.And (LEV.Var "a") (LEV.Or (LEV.Var "b") (LEV.Var "a")))

-- Representação da fórmula a → (a ∨ a)
formula3 :: LEV.Expression
formula3 = LEV.Imp (LEV.Var "a") (LEV.Or (LEV.Var "a") (LEV.Var "a"))

-- Expressão para representar a fórmula (p∨(q∧r))→((p∨q)∧(p∨r))
formula4 :: LEV.Expression
formula4 = LEV.Imp
            (LEV.Or (LEV.Var "p") (LEV.And (LEV.Var "q") (LEV.Var "r")))
            (LEV.And (LEV.Or (LEV.Var "p") (LEV.Var "q")) (LEV.Or (LEV.Var "p") (LEV.Var "r")))

-- Exemplo de uso
main :: IO ()
main = do
    let expr = LEV.Imp (LEV.Or (LEV.Var "p") (LEV.And (LEV.Var "q") (LEV.Var "r"))) (LEV.And (LEV.Or (LEV.Var "p") (LEV.Var "q")) (LEV.Or (LEV.Var "p") (LEV.Var "r")))
    finalBranches <- expandInitialTableau expr
    putStrLn "Final branches:"
    mapM_ (putStrLn . show) finalBranches
