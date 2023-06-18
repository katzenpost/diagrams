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

-- Create an arrow from one point to another point with a space at the end
arrowWithSpace :: P2 Double -> P2 Double -> Diagram B
arrowWithSpace from to = arrowBetween from (lerp 0.7 to from) <> strutX 0.1

-- Create a single arrow
singleArrow :: Diagram B
singleArrow = arrowWithSpace (p2 (0, 0)) (p2 (1, 0))

-- Create a cascade of 5 circles with arrows in between
cascade :: Diagram B
cascade = singleArrow ||| (hcat $ concatMap (\i -> [circleDiagram "mix" i, arrowWithSpace (p2 (0, 0)) (p2 (1, 0))]) [1..4]
            ++ [circleDiagram "mix" 5]) ||| singleArrow  -- Add the last circle without an arrow

main = mainWith cascade
