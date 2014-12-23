{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE PackageImports #-}

module Templates where

import "base" Prelude hiding (head, div)
import Text.Blaze.Html5
import Text.Blaze.Html5.Attributes hiding (title, rows, accept)
import qualified RouteHelpers as Path


index :: Html
index = do
  h1 "Reconstruct things"

about :: Html
about = do
  h1 "About this app"

newReconstruction :: Html
newReconstruction = do
  h2 "Upload images to begin reconstruction"

reconstructions :: Html
reconstructions = do
  h2 "Find reconstructions"
