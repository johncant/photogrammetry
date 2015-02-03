{-# LANGUAGE OverloadedStrings, NamedFieldPuns, Rank2Types, TypeFamilies #-}

module Upload where

import Control.Monad
import Haste.Prim
import Haste.DOM
import React
--import Data.Lens

data UploadFileState =
  UploadFileState { _name :: JSString
  }

data UploadState =
  UploadState { _files :: [UploadFileState]
              }


---- Lenses
---- TODO installing lenses breaks ATM
--files = Lens' UploadState [UploadFileState]
--files :: f (UploadState fi) = UploadState $ f fi
--
--name = Lens' UploadFileState JSString
--name :: f (UploadFileState n) = UploadState $ f n

data Signal = AddFileSignal JSString
            | RemoveFileSignal Int
-- Markup

uploadingFileView :: Int -> UploadFileState -> React UploadState Signal () ()
uploadingFileView n file = do
  div_ [class_ "upload_file"] $ do
    text_ (_name file)
    div_ $ do
      a_ [href_ "#", onClick $ handleFileUnselect n] "x"

uploadView :: UploadState -> React UploadState Signal () ()
uploadView uploadState = do
  div_ [class_ "upload" ] $ do
    input_ [ type_ "file"
           , class_ "upload_button"
           , onChange handleFileSelect]
--    button_ [class_ "upload_button"] "Upload images"
    div_ [class_ "upload_drag"] "Drag files here"
    div_ [class_ "upload_progress"] $
      zipWithM_ uploadingFileView [0..] (_files uploadState)

-- Transitions

uploadTransition :: Signal -> UploadState -> (UploadState, [AnimConfig Signal ()])
uploadTransition (AddFileSignal fn) (UploadState files) = (newState, [])
  where newState = UploadState $ files ++ [UploadFileState fn]
uploadTransition (RemoveFileSignal n) (UploadState files) = (newState, [])
  where newState = UploadState $ (let (l,r) = splitAt n files in l ++ (tail r))

noTransition :: () -> () -> ((), [AnimConfig () ()])
noTransition signal state = (state, [])

-- Handlers

handleFileSelect :: ChangeEvent -> Maybe Signal
handleFileSelect (ChangeEvent fn)  = Just $ AddFileSignal fn

handleFileUnselect :: Int -> MouseEvent -> Maybe Signal
handleFileUnselect n evt = Just $ RemoveFileSignal n

uploadClass :: IO (ReactClass UploadState Signal ())
uploadClass = createClass uploadView uploadTransition (UploadState []) () []

noUploadClass :: IO (ReactClass () () ())
noUploadClass = createClass (\_ -> text_ "Please upgrade your browser") noTransition () () []
