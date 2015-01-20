{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE PackageImports #-}

module Templates where

import "base" Prelude hiding (head, div)
import Text.Blaze.Html5
import Text.Blaze.Html5.Attributes hiding (title, rows)
import qualified RouteHelpers as Path

-- Partials

imageUploader :: Html
imageUploader = do
  div ! class_ "image_uploader"
      ! customAttribute "ng-controller" "ImageUploaderController" $ do
    button
      ! type_ "file"
      ! customAttribute "ng-file-select" ""
      ! customAttribute "ng-model" "uploadingFiles"
      ! customAttribute "ng-file-change" "filesSelected($files, $event)"
      ! customAttribute "ng-multiple" "true"
      ! accept "image/*" $ do
        "Upload"
-- /*Fay$$jsToFay([\"list\", [[\"user\", [[\"File\"]]]]],*/
index :: Html
index = do
  h1 "Reconstruct things"

about :: Html
about = do
  h1 "About this app"

newReconstruction :: Html
newReconstruction = do
  h2 "Upload images to begin reconstruction"
  imageUploader

reconstructions :: Html
reconstructions = do
  h2 "Find reconstructions"
