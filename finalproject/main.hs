-- haskell 4 lif

import Codec.Picture

-- main
-- > y wudi ly
-- main = putStrLn "y wudi ly"
main = do
    imageCreator "test4.png"

-- 'imageCreator "test1.png"
-- notes: first number is width, second is height
imageCreator :: String -> IO ()
imageCreator path = writePng path $ generateImage pixelRenderer 250 250
   where pixelRenderer x y = PixelRGB8 (fromIntegral x) (fromIntegral y) 255

-- 'newImage "test1.png" 100 100
newImage :: String -> Int -> Int -> IO ()
newImage path width height = writePng path $ generateImage pixelRenderer width height
    where pixelRenderer x y = PixelRGB8 (fromIntegral x) (fromIntegral y) 255