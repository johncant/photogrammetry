{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE PackageImports #-}

module RouteHelpers where

import "base" Prelude


root :: String
root = "/"

about :: String
about = "/about"

newReconstruction :: String
newReconstruction = "/reconstructions/new"

reconstructions :: String
reconstructions = "/reconstructions"

reconstructionImages :: (Show a, Integral a) => a -> String
reconstructionImages id = "/reconstructions/" ++ (show id) ++ "/images"

reconstructionImage :: (Show a, Integral a) => a -> a -> String
reconstructionImage id imageId = "/reconstructions/" ++ (show id) ++ "/images" ++ (show imageId)

