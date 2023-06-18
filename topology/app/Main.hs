{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE TypeFamilies              #-}

import Diagrams.Prelude
import Diagrams.Backend.SVG.CmdLine

-- Create a small circle labeled with a given string
circleDiagram :: String -> Int -> Diagram B
circleDiagram s n = (text s # fontSizeL 0.1 # fc white
                     <> text (show n) # fontSizeL 0.1 # fc white # translateY (-0.15))
                 <> circle 0.2 # fc lightseagreen # named (s ++ show n)

-- Create a vertical column of circles with space in between
column :: Int -> Diagram B
column n 
  | n == 0 || n == 4 = vsep 1 $ map (\i -> circleDiagram "provider" i) [n*5+1..n*5+5]
  | otherwise        = vsep 1 $ map (\i -> circleDiagram "mix" i) [n*5+1..n*5+5]

-- Create a grid of 5 columns of 5 circles with space in between
grid :: Diagram B
grid = hsep 1 $ map column [0..4]

-- Create a full mesh of arrows between two layers
connectLayers :: Int -> Int -> Diagram B -> Diagram B
connectLayers n1 n2 = applyAll [connectOutside' arrowOpts (prefix1++show i) (prefix2++show j) | i <- [n1*5+1..n1*5+5], j <- [n2*5+1..n2*5+5]]
  where
    prefix1 = if n1 == 0 || n1 == 4 then "provider" else "mix"
    prefix2 = if n2 == 0 || n2 == 4 then "provider" else "mix"
    arrowOpts = with & gaps .~ small & headLength .~ local 0.1

-- Create a full mesh of arrows between all layers
mesh :: Diagram B
mesh = foldr (.) id [connectLayers n (n+1) | n <- [0..3]] grid

main = mainWith mesh
