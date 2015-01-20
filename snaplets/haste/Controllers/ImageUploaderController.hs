{-# LANGUAGE OverloadedStrings #-}

module Controllers.ImageUploaderController where

import Haste
import qualified Haste.Angular.Ng as Ng
import Haste.Foreign
import AngularFileUpload

type UploadResponse = Unpacked

data UploadingFile = UploadingFile { angularFile :: File
                                   , promise :: Maybe JSString --Deferred UploadResponse
                                   , progress :: Double
                                   }


attachHandlers :: Maybe JSString -> IO (Maybe JSString)
attachHandlers a = return Nothing

--attachHandlers :: Deferred UploadResponse -> IO (Deferred UploadResponse)
--attachHandlers dr = do
--  done (\response -> do
--    putStrLn (show response)
--    ) dr
--  fail_ (do
--    putStrLn "Failed") dr
--  return dr

filesSelected :: Upload -> [File] -> FileSelectEvent -> IO [UploadingFile]
filesSelected uploader files event = do
  sequence $ map (\f -> do
    promise <- (upload
      uploader $
      UploadOptions
        "/images"
        Nothing
        (Nothing :: Maybe JSString)
        Nothing
        (Nothing :: Maybe JSString)
        f
        Nothing
        Nothing
        Nothing)
    promise <- attachHandlers promise
    return $ (UploadingFile
      f
      (Just "foo") --promise
      0
          )) files

imageUploaderController :: Ng.Scope -> Upload -> IO ()
imageUploaderController scope upload = do
  --attachFunc scope "filesSelected" $ filesSelected upload
  return ()

--  ngAttachFunc3AA scope "fileDropped" (\files event rejectedFiles -> do
--    return ()
--    )

--setup :: (Ng.Injectable i) => i
setup = ( "$scope"::JSString
        , "$upload"::JSString
        , imageUploaderController
        )

