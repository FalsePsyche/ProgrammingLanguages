-- module meltyIceCream where

import Codec.Picture

main = do 
    meltyIceCream "meltyIceCream.png"

defaultWidth = (fromIntegral 255)
defaultHeight = (fromIntegral 128)

-- Creates an image that looks like metly ice cream?                            
meltyIceCream :: String -> IO ()
meltyIceCream path = writePng path $ generateImage renderAlgorithmMeltyIceCream defaultWidth defaultHeight

-- this render algorithm creates a mixed color that looks like it is melting or something weird
renderAlgorithmMeltyIceCream :: Int -> Int -> PixelRGB8
renderAlgorithmMeltyIceCream x y = PixelRGB8 
                        (fromIntegral (y + x^2 + 170)) -- red
                        (fromIntegral (y + x^2 + 85)) -- green
                        (fromIntegral (y + x^2)) -- blue