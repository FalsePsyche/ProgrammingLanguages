-- Tanner Bornemann
-- CS4003 Programming Languages
-- 07 Dec 2017

import Codec.Picture
import System.Random
import Data.Function
import Data.List

main = do 
    putStrLn "y wudi ly"

defaultWidth = (fromIntegral 256)
defaultHeight = (fromIntegral 128)

printer :: IO ()
printer = print (fromIntegral defaultHeight)

-- Creates a png with a cool color gradient
-- 'imageCreator "test1.png"
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

-- Creates an image that fades from black to white (left to right)
blackToWhite :: String -> IO ()
blackToWhite path = writePng path $ generateImage renderBlackToWhite defaultWidth 128

allC :: [Int]
allC = [a | a <- [0,8..255]]

renderBlackToWhite :: Int -> Int -> PixelRGB8
renderBlackToWhite x y = PixelRGB8
                        (fromIntegral (allC!!(x)))
                        (fromIntegral (allC!!(x)))
                        (fromIntegral (allC!!(x)))

-- takes a seed and reports a pseudo random value
getAdjustedValue :: Int -> Int
getAdjustedValue i = (fromIntegral (3 + (mod (7*i) 2)))

-- NOTE: instead of presorting the list, we should use a get function that will use a random index position to get from, then remove that item from the list
allColorImage :: String -> IO ()
allColorImage path = writePng path $ generateImage renderAllColor defaultWidth defaultHeight

allColorImageSplit :: String -> IO ()
allColorImageSplit path = do
                        let testList = recursiveSplitReverse allColors
                        let allColors = testList  -- overwrite allColors with itself after a split and concat
                        writePng path $ generateImage renderAllColor defaultWidth defaultHeight

recursiveSplitReverse :: [(Int, Int, Int)] -> [(Int, Int, Int)]
recursiveSplitReverse [] = []
recursiveSplitReverse (x:[]) = [x]
recursiveSplitReverse (x:y:xs) = [y,x] ++ recursiveSplitReverse xs

-- will return a list of RGB tuples, the list will contain every RGB combination possible. Increments by 8, max is 256 (exclusive)
allColors :: [(Int, Int, Int)]
-- allColors = [(x, y, z) | x <- [255, 223..0], y <- [255, 223..0], z <- [255, 223..0]]
-- allColors = [(r, g, b) | r <- [0, 64..256], g <- [0, 64..256], b <- [0, 64..256]]
allColors = [(r, g, b) | r <- [0, 8..255], g <- [0, 8..255], b <- [0, 8..255]]

-- sortAllColors :: [(Int, Int, Int)] -> [(Int, Int, Int)]
-- sortAllColors [] = [(-1,0,-1)]
-- -- sortAllColors ((r, g, b):_:_) =  [(r,2,2)]
-- sortAllColors (x:y) = sortBy (compare `on` (getColorSum x)) [(r, g, b)]

-- generates a striped rainbow image
renderAllColor :: Int -> Int -> PixelRGB8
renderAllColor x y = PixelRGB8
                    (fromIntegral $ (getR (allColors!!(x*y)))) -- can't go higher than 140, or index too large
                    (fromIntegral $ (getG (allColors!!(x*y))))
                    (fromIntegral $ (getB (allColors!!(x*y))))
                    -- (fromIntegral 0)


getR :: (Int, Int, Int) -> Int
getR (r, _, _) = r

getG :: (Int, Int, Int) -> Int
getG (_, g, _) = g

getB :: (Int, Int, Int) -> Int
getB (_, _, b) = b

getColorSum :: (Int, Int, Int) -> Int
getColorSum (r, g, b) = (r + g + b)

colorTestList :: [(Int, Int, Int)] -- a smaller list for testing and debugging
colorTestList = [(r, g, b) | r <- [0, 128..255], g <- [0, 128..255], b <- [0, 128..255]]
