import qualified LogicExpressionValidator as LEV

-- Definição de um tipo de dado para representar uma fórmula na Lógica Proposicional
data Expression = Var String
             | Not Expression
             | And Expression Expression
             | Or Expression Expression
             | Imp Expression Expression
             deriving (Show, Eq)  -- Adicionando a instância Eq

main :: IO ()
main = do
    putStrLn "Digite uma fórmula lógica:"
    formula <- getLine
    if LEV.isValidLogicExpression formula
        then putStrLn "Fórmula lógica válida!"
        else putStrLn "Fórmula lógica inválida!"
