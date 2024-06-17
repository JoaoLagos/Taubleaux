import Data.List (elemIndex)
import Data.Maybe (fromJust)
import Data.List (isPrefixOf)

import qualified LogicExpressionValidator as LEV 
import qualified Taubleaux 


-- Exemplo de uso:
main :: IO ()
main = do
    -- Responsável por converter a Fórmula Lógica Proposicional (string) em uma expressão Haskell equivalente
    putStrLn "Digite a fórmula na lógica proposicional:"
    formula <- getLine
    let expression = LEV.parseFormula formula
    putStrLn $ "Expressão Haskell equivalente: " ++ show expression ++ "\n"

    -- Até o momento, responsável por mostrar os nós expandidos/gerados.
    finalBranches <- Taubleaux.expandInitialTableau expression
    putStrLn "Final branches: "
    mapM_ (putStrLn . show) finalBranches
