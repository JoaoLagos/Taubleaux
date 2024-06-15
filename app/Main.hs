import Data.List (isPrefixOf)
import qualified LogicExpressionValidator as LEV

-- Definição de um tipo de dado para representar uma fórmula na Lógica Proposicional
data Expression = Var String
             | Not Expression
             | And Expression Expression
             | Or Expression Expression
             | Imp Expression Expression
             deriving (Show, Eq)  -- Adicionando a instância Eq

-- Função para dividir a fórmula
splitFormula :: String -> (String, String, String)
splitFormula formula = 
    let (left, midRight) = splitAtOperator formula
        (mid, right) = extractOperator midRight
    in (left, mid, right)

-- Função para encontrar o operador de nível mais alto e dividir a string
splitAtOperator :: String -> (String, String)
splitAtOperator formula = go formula 0 ""
  where
    go [] _ acc = (acc, [])
    go rest@(c:cs) depth acc
        | isOperator rest && depth == 0 = (reverse acc, rest)
        | c == '('  = go cs (depth + 1) (c:acc)
        | c == ')'  = go cs (depth - 1) (c:acc)
        | otherwise = go cs depth (c:acc)

-- Função para verificar se uma string começa com um operador
isOperator :: String -> Bool
isOperator s = any (`isPrefixOf` s) ["<->", "->", "OU", "E"]

-- Função para extrair o operador e o restante da string
extractOperator :: String -> (String, String)
extractOperator s
    | "<->" `isPrefixOf` s = ("<->", drop 3 s)
    | "->"  `isPrefixOf` s = ("->", drop 2 s)
    | "OU"  `isPrefixOf` s = ("OU", drop 2 s)
    | "E"   `isPrefixOf` s = ("E", drop 1 s)
    | otherwise = ([], s)

-- Exemplo de uso
main :: IO ()
main = do
    let formula = "((a)->(b))OU((c)OU(d))"
    let (left, mid, right) = splitFormula formula
    putStrLn $ "Left: " ++ left
    putStrLn $ "Mid: " ++ mid
    putStrLn $ "Right: " ++ right