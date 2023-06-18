
import Diagrams.Prelude
import Diagrams.Backend.SVG.CmdLine

node :: Int -> Diagram B
node n = text ("dirauth" ++ show n) # fontSizeL 0.08 # fc white
      <> circle 0.2 # fc mediumaquamarine # named n

arrowOpts = with & gaps       .~ small
                  & headLength .~ local 0.15

tournament :: Int -> Diagram B
tournament n = atPoints (trailVertices $ regPoly n 1) (map node [1..n])
  # applyAll [connectOutside' arrowOpts j k | j <- [1 .. n-1], k <- [j+1 .. n]]

example :: Diagram B
example = tournament 5

main = mainWith example