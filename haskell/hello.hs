main = do
  print ("My first Haskell program")
  name <- getLine
  print ("Hello," ++ name)