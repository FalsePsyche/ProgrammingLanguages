-- haskell 4 lif

import Codec.Picture

-- main
-- > y wudi ly
main = do 
    putStrLn "y wudi ly"

-- 'imageCreator "test1.png"
-- notes: first number is width, second is height
imageCreator :: String -> IO ()
imageCreator path = writePng path $ generateImage pixelRenderer 250 250
   where pixelRenderer x y = PixelRGB8 (fromIntegral x) (fromIntegral y) 255

-- 'newImage "test1.png" 100 100 128
-- args: filename width height rgbDepth
newImage :: String -> Int -> Int -> Pixel8 -> IO ()
newImage path width height depth = writePng path $ generateImage pixelRenderer width height
    where pixelRenderer x y = PixelRGB8 (fromIntegral x) (fromIntegral y) (fromIntegral depth)