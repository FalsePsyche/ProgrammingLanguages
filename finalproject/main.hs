-- haskell 4 lif

import Codec.Picture

-- main
-- > y wudi ly
main = putStrLn "y wudi ly"

-- 'imageCreator "test1.png"
imageCreator :: String -> IO ()
imageCreator path = writePng path $ generateImage pixelRenderer 250 300
   where pixelRenderer x y = PixelRGB8 (fromIntegral x) (fromIntegral y) 128