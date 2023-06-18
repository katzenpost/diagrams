{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE TypeFamilies              #-}

import Diagrams.Prelude
import Diagrams.Backend.SVG.CmdLine

-- Create an envelope shape
drawEnvelope :: Diagram B
drawEnvelope = fromVertices [p2 (0,0), p2 (2,0), p2 (2,1), p2 (1,1.5), p2 (0,1)]
    # closeTrail
    # strokeTrail
    # lw medium
    # fc lightsteelblue
    # lc steelblue

main = mainWith drawEnvelope