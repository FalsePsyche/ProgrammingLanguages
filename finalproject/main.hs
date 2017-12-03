-- haskell 4 lif

import Codec.Picture

-- main
-- > y wudi ly
main = do 
    putStrLn "y wudi ly"

printer :: IO ()
printer = print (fromIntegral 128)

-- 'imageCreator "test1.png"
-- notes: first number is width, second is height
-- wtf why does this create a gradient, but if i replace x and y with a const number the gradient goes away
-- holy shit pixelRenderer is the algorithm for the generateImage?? how does this fucking work WTF there isn't even anything telling to loop or iterate wtffffffff
-- holy shit generateImage takes a function as its first parm, and iterates from 0 to 249 (width - 1) to produce the colors
imageCreator :: String -> IO ()
imageCreator path = writePng path $ generateImage pixelRenderer 250 250
   where pixelRenderer x y = PixelRGB8 (fromIntegral x) (fromIntegral y) 128

-- 'newImage "test1.png" 100 100 128
-- args: filename width height blue
newImage :: String -> Int -> Int -> Pixel8 -> IO ()
newImage path width height blue = writePng path $ generateImage pixelRenderer width height
    where pixelRenderer x y = PixelRGB8 (fromIntegral x) (fromIntegral y) (fromIntegral blue)

    
-- 'newImage "test1.png" 100 100 128
-- args: filename width height blue
newImage16 :: String -> Int -> Int -> Pixel16 -> IO ()
newImage16 path width height blue = writePng path $ generateImage pixelRenderer width height
    where pixelRenderer x y = PixelRGB16 (fromIntegral x) (fromIntegral y) (fromIntegral blue)

-- createPixelRGB16 :: Int -> Int -> Int -> PixelRGB16 ()
-- createPixelRGB16 red green blue = PixelRGB16 red green blue
