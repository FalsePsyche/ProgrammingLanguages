-- haskell 4 lif

import Codec.Picture

-- main
-- > y wudi ly
main = do 
    putStrLn "y wudi ly"

defaultWidth = 255
defaultHeight = 128

printer :: IO ()
printer = print (fromIntegral defaultHeight)

-- Creates a png with a cool color gradient
-- 'imageCreator "test1.png"
-- notes: first number is width, second is height
-- wtf why does this create a gradient, but if i replace x and y with a const number the gradient goes away
-- holy shit pixelRenderer is the algorithm for the generateImage?? how does this fucking work WTF there isn't even anything telling to loop or iterate wtffffffff
-- holy shit generateImage takes a function as its first parm, and calls the func with iterated values from 0 to 249 (width - 1) to produce the colors
imageCreator :: String -> IO ()
imageCreator path = writePng path $ generateImage pixelRenderer defaultWidth defaultWidth
   where pixelRenderer x y = PixelRGB8 (fromIntegral x) (fromIntegral y) defaultHeight

-- 'newImage "test1.png" 100 100 128
-- args: filename width height blue
newImage :: String -> Int -> Int -> Pixel8 -> IO ()
newImage path width height blue = writePng path $ generateImage pixelRenderer width height
    where pixelRenderer x y = PixelRGB8 (fromIntegral x) (fromIntegral y) (fromIntegral x)

    
-- 'newImage "test1.png" 100 100 128
-- args: filename width height blue
newImage16 :: String -> Int -> Int -> Pixel16 -> IO ()
newImage16 path width height blue = writePng path $ generateImage pixelRenderer width height
    where pixelRenderer x y = PixelRGB16 (fromIntegral x) (fromIntegral y) (fromIntegral blue)

-- createPixelRGB16 :: Int -> Int -> Int -> PixelRGB16 ()
-- createPixelRGB16 red green blue = PixelRGB16 red green blue

experiment :: String -> IO ()
experiment path = writePng path $ generateImage renderAlgorithm defaultWidth defaultWidth

experiment2 :: String -> IO ()
experiment2 path = writePng path $ generateImage renderAlgorithmModulo defaultWidth defaultHeight

renderAlgorithm :: Int -> Int -> PixelRGB8
renderAlgorithm x y = PixelRGB8 
                        (fromIntegral (x - defaultHeight)) 
                        (fromIntegral (y + defaultHeight)) 
                        (fromIntegral (x+y + defaultHeight))

renderAlgorithmModulo :: Int -> Int -> PixelRGB8
renderAlgorithmModulo x y = PixelRGB8 
                            (fromIntegral (mod (x - defaultHeight) 2) * defaultHeight) -- red
                            (fromIntegral (mod (y^2) 55)) -- green
                            (fromIntegral (mod x (y + 1))) -- blue

meltyIceCream :: String -> IO ()
meltyIceCream path = writePng path $ generateImage renderAlgorithmMeltyIceCream defaultWidth defaultWidth

-- this render algorithm creates a mixed color that looks like it is melting or something weird
renderAlgorithmMeltyIceCream :: Int -> Int -> PixelRGB8
renderAlgorithmMeltyIceCream x y = PixelRGB8 
                        (fromIntegral (y + x^2 + 170)) -- red
                        (fromIntegral (y + x^2 + 85)) -- green
                        (fromIntegral (y + x^2)) -- blue
