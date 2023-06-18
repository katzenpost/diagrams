{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE TypeFamilies              #-}

import Diagrams.Prelude
import Diagrams.Backend.SVG.CmdLine

-- Create a small circle labeled with a given string
circleDiagram :: String -> Diagram B
circleDiagram s = (text s # fontSizeL 0.1 # fc white)
                 <> circle 0.2 # fc blue # named s

-- Create an envelope shape
drawEnvelope :: Diagram B
drawEnvelope = fromVertices [p2 (0,0), p2 (2,0), p2 (2,1), p2 (1,1.5), p2 (0,1)]
    # closeTrail
    # strokeTrail
    # lw ultraThin
    # fc lightsteelblue
    # lc steelblue
    # scale 0.1  -- Scale down to a small size

-- Create a horizontal row of circles with given labels, and an envelope beside each circle
row :: [String] -> Diagram B
row labels = hsep 1 $ map (\label -> (circleDiagram label) <> (drawEnvelope # translateX 0.3)) labels

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

main = mainWith (frame 0.07 mesh)  -- Add a frame around the diagram
