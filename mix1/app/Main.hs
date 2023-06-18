{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE TypeFamilies              #-}

import Diagrams.Prelude
import Diagrams.Backend.SVG.CmdLine

-- Create a small circle labeled with a given string
circleDiagram :: String -> Diagram B
circleDiagram s = (text s # fontSizeL 0.1 # fc white)
                 <> circle 0.2 # fc lightcoral # named s

-- Create a vertical column of circles with given labels
column :: [String] -> Diagram B
column labels = vsep 0.3 $ map circleDiagram labels

-- Create a diagram with specified clients and 1 mix
diagram :: Diagram B
diagram = position [(zero, clientColumn), (p2 (width clientColumn + 1, -(height clientColumn / 2)), mix)]
    where
        clientColumn = column ["Tom", "Dick", "Harry", "George", "Nancy"]
        mix = circleDiagram "mix"

-- Create a full mesh of arrows from all clients to the mix
mesh :: Diagram B
mesh = applyAll [connectOutside' arrowOpts client "mix" | client <- ["Tom", "Dick", "Harry", "George", "Nancy"]] diagram
  where
    arrowOpts = with & gaps .~ small & headLength .~ local 0.1

main = mainWith mesh
