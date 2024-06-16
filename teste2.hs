import Data.List (isPrefixOf)

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
    | otherwise = ([], s)

-- Exemplo de uso
main :: IO ()
main = do
    let formula = "((((a)->(b))->(c))OU(d))OU((e)<->(f))"
    let (left, mid, right) = splitFormula formula
    putStrLn $ "Left: " ++ left
    putStrLn $ "Mid: " ++ mid
    putStrLn $ "Right: " ++ right