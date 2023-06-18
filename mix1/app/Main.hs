{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE TypeFamilies              #-}

import Diagrams.Prelude
import Diagrams.Backend.SVG.CmdLine

-- Create a small circle labeled with a given string
circleDiagram :: String -> Diagram B
circleDiagram s = (text s # fontSizeL 0.1 # fc white)
                 <> circle 0.2 # fc blue # named s

-- Create a horizontal row of circles with given labels
row :: [String] -> Diagram B
row labels = hsep 1 $ map circleDiagram labels

-- Create a diagram with specified clients and 1 mix
diagram :: Diagram B
diagram = position [(zero, clientRow), (p2 (width clientRow / 2, -1), mix)]
    where
        clientRow = row ["Tom", "Dick", "Harry", "George", "Nancy"]
        mix = circleDiagram "mix"

-- Create a full mesh of arrows from all clients to the mix
mesh :: Diagram B
mesh = applyAll [connectOutside' arrowOpts client "mix" | client <- ["Tom", "Dick", "Harry", "George", "Nancy"]] diagram
  where
    arrowOpts = with & gaps .~ small & headLength .~ local 0.1

main = mainWith mesh
