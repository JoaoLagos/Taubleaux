module LogicExpressionValidator where

import Text.Regex.TDFA ((=~))

isValidLogicExpression :: String -> Bool
isValidLogicExpression expr = expr =~ "^(\\()*~?(\\()*[a-z](\\))*((\\))*(E|OU|<->|->)(\\()*~?(\\()*[a-z])*(\\))*(\\))*$"


loop :: IO()
loop = do
    putStrLn "Digite uma fórmula lógica:"
    formula <- getLine
    if isValidLogicExpression formula
        then putStrLn "Fórmula lógica válida!"
        else putStrLn "Fórmula lógica inválida!"
    loop

-- Função main para executar o programa
main :: IO ()
main = loop