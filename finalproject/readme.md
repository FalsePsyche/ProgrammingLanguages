# Final Project

An image generator using one of 32,768 for each pixel ([15bit color depth](https://en.wikipedia.org/wiki/High_color)) w/ different algorithms using Haskell.

## Rules

1. Only one color per pixel of the image; an RGB value can not be used more than once.
1. Each of the individual 32,768 possible color values must be used.

## Inspiration

<https://codegolf.stackexchange.com/questions/22144/images-with-all-colors>

## Tools/Resources

- [![Haskell](https://www.haskell.org/static/img/haskell-logo.svg?etag=ukf3Fg7-)](https://www.haskell.org/)
- [![](https://camo.githubusercontent.com/8138e62c7342cc9c34aba722750bddd2f38aa626/68747470733a2f2f7261772e6769746875622e636f6d2f5477696e736964652f4a756963792e506978656c732f6d61737465722f646f63696d616765732f6a756963792e706e67) JuicyPixels package](https://hackage.haskell.org/package/JuicyPixels)

## How to use

Change directory in cmd line to the directory with the `meltyIceCream.hs` file
````cmd
cd finalproject
````
Run the GHC
````cmd
ghc --make meltyIceCream.hs
````
Run the meltyIceCream module
````cmd
meltyIceCream.exe
````

A new image file named `meltyIceCream.png` will be created based on the algorithm within the meltyIceCream function.

## Uniquely Colored Pixels

Creating an image with individually uniquely colored pixels is very easy using Haskell and the hackage JuicyPixels. Within JuicyPixels there is a function called `generateImage` that takes a function and 2 integer values as arguments. It uses the two integer values to determine the width and height of the image and also uses them to determine the inputs to the function argument. By iterating from 0 to `width - 1` for the x value and 0 to `height - 1` for the y value, we can simply make the function argument return the input values for x (width) and y (height). ~~But because this would~~ Since the iteration never repeats the same value, we instantly have an algorithm that creates a uniquely colored pixel that matches no other pixel within the image. But this is no fun, so I am going to explore much more complicated algorithms in hopes of creating some impressive images.

## Un-Aware Algorithms

My first few attempts at creating an interesting image were simple algorithms that were not 'aware' of the other pixels and their colors. [At least not like the winning project of the referenced inspiration.](https://codegolf.stackexchange.com/questions/22144/images-with-all-colors/22326#22326)
Since C# is my primary language it was very easy for me to understand how [fejesjoco](https://codegolf.stackexchange.com/users/14701/fejesjoco)'s solution worked. So I figured trying to convert this solution into Haskell could be an interesting challenge that I could use to further my understanding of Haskell and the functional programming paradigm. Even though C# implements many functional programming aspects from fp languages, including Haskell, it does not make the process of creating the same outcome in Haskell easy. Though this solution is well written in C#, it uses many imperitive paradigms that cannot be used in a functionally pure language such as Haskell.
