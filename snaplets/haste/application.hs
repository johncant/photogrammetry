{-# LANGUAGE OverloadedStrings #-}

import Haste.Prim
import Haste.DOM
import Haste.Foreign
import React

import qualified Upload as U

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

data ApplicationState = ApplicationState {
    foo :: JSString
  }

transition :: JSString -> ApplicationState -> (ApplicationState, [AnimConfig JSString ()])
transition signal oldState = (oldState, [])
--imageUploader :: React
--imageUploader = do
--  div_ [ class_ "image_uploader" ] $ do
--    button_ $ do
--      "Upload"

index :: ReactClass a b c -> ApplicationState -> React ApplicationState JSString () ()
index uploadClass s = do
  div_ $ do
    h1_ "Reconstruct things"
    h1_ "Reconstruct moar things"
    reactClass_ uploadClass []

--index' :: JSString -> React () ()
--index' s = do
--  h1_ "Reconstruct things"
--  h1_ "Reconstruct moar things"

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

isFileAPISupported :: IO Bool
isFileAPISupported = ffi "(function() { return !!(window.File && window.FileReader && window.FileList && window.Blob); })"

main = do
--  withElem "app" $ \elem ->
    mElem <- elemById "app"
    case mElem of
      Nothing -> putStrLn "not found"
      Just elem -> do
        fileAPISupported <- isFileAPISupported
        case fileAPISupported of
          False -> do
            klass <- U.noUploadClass
            render klass elem
          True -> do
            uploadClass <- U.uploadClass
            klass <- createClass (index uploadClass) transition (ApplicationState "") () []
            render klass elem
        return ()

