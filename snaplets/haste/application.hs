{-# LANGUAGE OverloadedStrings, NamedFieldPuns, Rank2Types, TypeFamilies #-}

import Haste.Prim
import Haste.DOM
import React

--import Control.Applicative
--import Control.Monad
--import Prelude hiding (div)
--
--import Haste
--import Haste.Foreign
--import Haste.JSON
--import Haste.Prim
--import Lens.Family2
--import Lens.Family2.Stock
--import React
----
--import System.IO.Unsafe

data Application = Application {
    foo :: JSString
  }

instance ReactKey Application where
  type ClassState Application = JSString
  type AnimationState Application = ()
  type Signal Application = JSString

transition :: JSString -> JSString -> (JSString, [AnimConfig Application])
transition oldState signal = (signal, [])

--imageUploader :: React
--imageUploader = do
--  div_ [ class_ "image_uploader" ] $ do
--    button_ $ do
--      "Upload"

index :: JSString -> React Application ()
index s = do
  h1_ "Reconstruct things"

--about :: React
--about = do
--  h1_ "About this app"
--
--newReconstruction :: React
--newReconstruction = do
--  h2_ "Upload images to begin reconstruction"
--  imageUploader
--
--reconstructions :: React
--reconstructions = do
--  h2_ "Find reconstructions"
--
--layout :: React
--layout = do
--  div_ [ class_ "application_menu" ] $ do
--    ul_ $ do
--      li_ [ a_ "New"] "new_reconstruction"
--      li_ [ a_ "Browse"] "reconstructions"
--      li_ [ a_ "About"] "about"
--  div_ [ class_ "application_menu_spacer"]
--  div_ [ class_ "page"]

main = do
--  withElem "app" $ \elem ->
    mElem <- elemById "app"
    case mElem of
      Nothing -> putStrLn "not found"
      Just elem -> do
        render elem =<< createClass index transition "" () []
        return ()

