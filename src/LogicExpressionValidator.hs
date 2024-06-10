module LogicExpressionValidator where

import Text.Regex.TDFA ((=~))

{--
-- Definindo a expressão regular
regex :: String
regex = "^(\\()*~?(\\()*[a-z](\\))*((\\))*(E|OU|<->|->)(\\()*~?(\\()*[a-z])*(\\))*(\\))*$" -- "^~?[a-z]((E|OU|->)~?[a-z])*$"
--} 
-- Apenas passei o "regex" direto para a função isValidLogicExpression

-- Função para validar a expressão lógica
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