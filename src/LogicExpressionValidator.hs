{-
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
-}

module LogicExpressionValidator where

import Data.List (elemIndex)
import Data.Maybe (fromJust)
import Data.List (isPrefixOf)


-- Definição do tipo de dados para representar uma fórmula na Lógica Proposicional
data Expression = Var String
                | Not Expression
                | And Expression Expression
                | Or Expression Expression
                | Imp Expression Expression
                deriving (Show, Eq)

-- Divide a fórmula em três partes: left, mid (operador) e right
splitFormula :: String -> (String, String, String)
splitFormula formula =
    let (left, midRight) = splitAtOperator formula
        (mid, right) = extractOperator midRight 
    in (left, mid, right)

-- Encontra o operador de nível mais alto e dividi a string (esq e midRight)
splitAtOperator :: String -> (String, String)
splitAtOperator formula = go formula 0 ""
  where
    go [] _ acc = (acc, [])
    go rest@(c:cs) depth acc
        | isOperator rest && depth == 0 = (reverse acc, rest)
        | c == '('  = go cs (depth + 1) (c:acc)
        | c == ')'  = go cs (depth - 1) (c:acc)
        | otherwise = go cs depth (c:acc)

-- Verifica se uma string começa com um operador
isOperator :: String -> Bool
isOperator s = any (`isPrefixOf` s) ["<->", "->", "OU", "E"]

-- Extrai o operador e o restante da string (mid e right)
extractOperator :: String -> (String, String)
extractOperator s
    | "<->" `isPrefixOf` s = ("<->", drop 3 s)
    | "->"  `isPrefixOf` s = ("->", drop 2 s)
    | "OU"  `isPrefixOf` s = ("OU", drop 2 s)
    | "E"   `isPrefixOf` s = ("E", drop 1 s)
    | otherwise = ([], s)

-- Converte uma fórmula em uma expressão do tipo Expression Haskell
parseFormula :: String -> Expression
parseFormula formula =
    let (left, mid, right) = splitFormula formula
    in case mid of
        "->"  -> Imp (parseFormula left) (parseFormula right)
        "OU"  -> Or (parseFormula left) (parseFormula right)
        "E"   -> And (parseFormula left) (parseFormula right)
        _     -> parseSimpleExpression formula
  where 
    -- Função auxiliar para converter uma fórmula simples em Expression Haskell
    parseSimpleExpression :: String -> Expression
    parseSimpleExpression f
        | head f == '(' && last f == ')' = parseFormula (init (tail f))
        | head f == '~' = Not (parseSimpleExpression (tail f))
        | otherwise = Var f

-- Exemplo de uso:
main :: IO ()
main = do
    putStrLn "Digite a fórmula na lógica proposicional:"
    formula <- getLine
    let expression = parseFormula formula
    putStrLn $ "Expressão Haskell equivalente: " ++ show expression
