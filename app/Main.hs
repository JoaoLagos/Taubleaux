import Data.List (nub, intersect)
import qualified Data.Set as Set
import Data.Set (Set)

-- Definição de um tipo de dado para representar uma fórmula na Lógica Proposicional
data Expression = Var String
                | Not Expression
                | And Expression Expression
                | Or Expression Expression
                | Imp Expression Expression
                deriving (Show, Eq) -- Show: permite que instâncias do tipo Expression sejam convertidos para string (através do comando "show"); Eq: Permite comparação de igualdade entre duas intância de Expression

-- Definição do nós da árvore
data TableauNode = TableauNode -- Nó composto pela fórmula(Expressão) e se é verdadeiro ou falso
    { formula  :: Expression 
    , isTrue   :: Bool
    } deriving (Show, Eq)

-- Cria um nó inicial a partir de uma fórmula
createInitialNode :: Expression -> TableauNode
createInitialNode expr = TableauNode expr False -- False, pois queremos provar através de uma contradição

-- Expande nó através das REGRAS citadas
expandNode :: TableauNode -> [[TableauNode]]
expandNode (TableauNode (Imp a b) False) = [[TableauNode a True], [TableauNode b False]]
expandNode (TableauNode (Imp a b) True)  = [[TableauNode a False, TableauNode b True]]
expandNode (TableauNode (And a b) True)  = [[TableauNode a True, TableauNode b True]]
expandNode (TableauNode (And a b) False) = [[TableauNode a False], [TableauNode b False]]
expandNode (TableauNode (Or a b) True)   = [[TableauNode a True], [TableauNode b True]]
expandNode (TableauNode (Or a b) False)  = [[TableauNode a False, TableauNode b False]]
expandNode (TableauNode (Not a) True)    = [[TableauNode a False]]
expandNode (TableauNode (Not a) False)   = [[TableauNode a True]]
expandNode node                          = [[node]]

-- Função para verificar se um nó é uma variável simples ou já foi expandido completamente
isSimpleNode :: TableauNode -> Bool
isSimpleNode (TableauNode (Var _) _) = True
isSimpleNode _ = False

-- Função para expandir nós recursivamente
expandTableau :: [TableauNode] -> IO [[TableauNode]]
expandTableau [] = return []
expandTableau (node:nodes)
    | isSimpleNode node = do
        restBranches <- expandTableau nodes
        return $ [node : branch | branch <- restBranches]
    | otherwise = do
        let expandedNodes = expandNode node
        putStrLn $ "Expanding node: " ++ show node
        mapM_ (putStrLn . ("Generated nodes: " ++) . show) expandedNodes
        expandedBranches <- mapM expandTableau (map (++ nodes) expandedNodes)
        return $ concat expandedBranches


-- Função principal para iniciar a expansão do tableau
expandInitialTableau :: Expression -> IO [[TableauNode]]
expandInitialTableau expr = expandTableau [createInitialNode expr]

----------- ATÉ AQUI FOI !!! -------------

-- Função para verificar contradições em um ramo
hasContradiction :: [TableauNode] -> Bool
hasContradiction nodes = not . null $ intersect trueFormulas falseFormulas
  where
    trueFormulas = [f | TableauNode f True <- nodes]
    falseFormulas = [f | TableauNode f False <- nodes]

-- Representação da fórmula a → (a → (b → a))
formula1 :: Expression
formula1 = Imp (Var "a") (Imp (Var "a") (Imp (Var "b") (Var "a")))

-- Representação da fórmula b → (a ∧ (b ∨ a))
formula2 :: Expression
formula2 = Imp (Var "b") (And (Var "a") (Or (Var "b") (Var "a")))

-- Representação da fórmula a → (a ∨ a)
formula3 :: Expression
formula3 = Imp (Var "a") (Or (Var "a") (Var "a"))

-- Expressão para representar a fórmula (p∨(q∧r))→((p∨q)∧(p∨r))
formula4 :: Expression
formula4 = Imp
            (Or (Var "p") (And (Var "q") (Var "r")))
            (And (Or (Var "p") (Var "q")) (Or (Var "p") (Var "r")))

-- Exemplo de uso
main :: IO ()
main = do
    let expr = Imp (Or (Var "p") (And (Var "q") (Var "r"))) (And (Or (Var "p") (Var "q")) (Or (Var "p") (Var "r")))
    finalBranches <- expandInitialTableau expr
    putStrLn "Final branches:"
    mapM_ (putStrLn . show) finalBranches
