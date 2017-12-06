-- haskell 4 lif

-- module main where

import Codec.Picture
import System.Random
-- import meltyIceCream

-- main
-- > y wudi ly
main = do 
    putStrLn "y wudi ly"

defaultWidth = (fromIntegral 255)
defaultHeight = (fromIntegral 128)

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
   where pixelRenderer x y = PixelRGB8 (fromIntegral x) (fromIntegral y) (fromIntegral defaultHeight)

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
experiment path = writePng path $ generateImage renderAlgorithm defaultWidth defaultHeight

experiment2 :: String -> IO ()
experiment2 path = writePng path $ generateImage renderAlgorithmModulo defaultWidth defaultHeight

renderAlgorithm :: Int -> Int -> PixelRGB8
renderAlgorithm x y = PixelRGB8 
                        (fromIntegral (x - defaultHeight)) 
                        (fromIntegral (y + defaultHeight)) 
                        (fromIntegral (x + y + defaultHeight))

-- do something with mod

renderAlgorithmModulo :: Int -> Int -> PixelRGB8
renderAlgorithmModulo x y = PixelRGB8 
                            (fromIntegral (mod (x - defaultHeight) 2) * 128) -- red
                            (fromIntegral (mod (y + defaultHeight) 2) * 128) -- green
                            (fromIntegral (mod x (y + 1))) -- blue

-- Creates an image that fades from black to white (left to right)
blackToWhite :: String -> IO ()
blackToWhite path = writePng path $ generateImage renderBlackToWhite defaultWidth 128

allC :: [Int]
allC = [a | a <- [0..255]]

renderBlackToWhite :: Int -> Int -> PixelRGB8
renderBlackToWhite x y = PixelRGB8
                        (fromIntegral (allC!!(x)))
                        (fromIntegral (allC!!(x)))
                        (fromIntegral (allC!!(x)))


-- one :: String -> IO ()
-- one path = writePng path $ createMutableImage defaultWidth defaultWidth $ (renderAlgorithmone 50 50)

renderAlgorithmone :: Int -> Int -> PixelRGB8
renderAlgorithmone x y = PixelRGB8
                        (fromIntegral (y + x^2 + 127)) -- red
                        (fromIntegral (x^2 + 85)) -- green
                        (fromIntegral (y + x^2)) -- blue

two :: String -> IO ()
two path = writePng path $ generateImage renderAlgorithmtwo defaultWidth defaultWidth

renderAlgorithmtwo :: Int -> Int -> PixelRGB8
renderAlgorithmtwo x y = PixelRGB8
                        (fromIntegral (y)) -- red
                        (fromIntegral (x)) -- green
                        (fromIntegral (y + x + 127)) -- blue

getArray :: Int -> [Int]
getArray x
    | x > 5 = []
    | otherwise = [x..5]

-- create a 'check neighbors' func that will check the next 3 pixels horizontally and vertically

-- allColors :: Int -> [Int]
-- allColors i = take 10 (i+2)

-- takes a seed and reports a pseudo random value
getAdjustedValue :: Int -> Int
getAdjustedValue i = (fromIntegral (3 + (mod (7*i) 2)))

-- NOTE: instead of presorting the list, we should use a get function that will use a random index position to get from, then remove that item from the list
allColorImage :: String -> IO ()
allColorImage path = writePng path $ generateImage renderAllColor defaultWidth 128

-- will return a list of RGB tuples, the list will contain every RGB combination possible. Increments by 8, max is 256 (exclusive)
allColors :: [(Int, Int, Int)]
-- allColors = [(x, y, z) | x <- [255, 223..0], y <- [255, 223..0], z <- [255, 223..0]]
-- allColors = [(r, g, b) | r <- [0, 64..256], g <- [0, 64..256], b <- [0, 64..256]]
allColors = [(r, g, b) | r <- [0, 8..256], g <- [0, 8..256], b <- [0, 8..256]]

-- generates a striped rainbow image
renderAllColor :: Int -> Int -> PixelRGB8
renderAllColor x y = PixelRGB8
                    (fromIntegral $ (getR (allColors!!(x*140))))
                    (fromIntegral $ (getG (allColors!!(x*70))))
                    (fromIntegral $ (getB (allColors!!(x))))

getR :: (Int, Int, Int) -> Int
getR (r, _, _) = r

getG :: (Int, Int, Int) -> Int
getG (_, g, _) = g

getB :: (Int, Int, Int) -> Int
getB (_, _, b) = b

renderAlgorithmPlain :: (Int, Int, Int) -> PixelRGB8
renderAlgorithmPlain (r, g, b) = PixelRGB8
                                (fromIntegral r)
                                (fromIntegral g)
                                (fromIntegral b)
