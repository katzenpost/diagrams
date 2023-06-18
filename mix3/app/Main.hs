{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE TypeFamilies              #-}

import Diagrams.Prelude
import Diagrams.Backend.SVG.CmdLine

-- Create a circle labeled with a given string
circleDiagram :: String -> Diagram B
circleDiagram s = (text s # fontSizeL 0.1 # fc black # translateY 0.3)
                 <> circle 0.5 # named s

-- Create an envelope shape
drawEnvelope :: Diagram B
drawEnvelope = fromVertices [p2 (0,0), p2 (2,0), p2 (2,1), p2 (1,1.5), p2 (0,1)]
    # closeTrail
    # strokeTrail
    # lw ultraThin
    # fc lightsteelblue
    # lc steelblue
    # scale 0.07  -- Scale down to a small size

-- Create a pile of envelopes
pileOfEnvelopes :: Diagram B
pileOfEnvelopes = vcat . replicate 1 $ drawEnvelope

-- Create a mix with 5 envelopes inside
mixWithEnvelopes :: Diagram B
mixWithEnvelopes = circleDiagram "mix" <> (hsep 0.04 . replicate 5 $ drawEnvelope) # centerX


-- Create a diagram with 2 arrows, one mix in the center, and piles of envelopes on both sides
diagram :: Diagram B
diagram = pileOfEnvelopes ||| strutX 0.07 ||| arrow1 ||| strutX 0.03 ||| mixDiagram ||| strutX 0.03 ||| arrow2 ||| strutX 0.07 ||| pileOfEnvelopes
    where
        arrow1 = arrowAt' (with & arrowHead .~ dart) (p2 (0, 0)) (r2 (0.5, 0))
        arrow2 = arrowAt' (with & arrowHead .~ dart) (p2 (0, 0)) (r2 (0.5, 0))
        mixDiagram = mixWithEnvelopes # centerX


main :: IO ()
main = mainWith (frame 0.07 diagram)  -- Add a frame around the diagram
