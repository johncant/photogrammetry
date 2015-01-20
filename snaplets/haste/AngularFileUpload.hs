{-# LANGUAGE OverloadedStrings #-}

module AngularFileUpload where

import Haste
import Haste.Foreign
--import Foreign

type FileSelectEvent = Unpacked
type Upload = Unpacked

-- TODO - handle dates
data File = File { webkitRelativePath :: JSString
                 , lastModified :: Int
                 , lastModifiedDate :: JSString
                 , name :: JSString
                 , type_ :: JSString
                 , size :: Int
                 }

instance Unpack File where
  unpack f = unpack ( webkitRelativePath f
                    , lastModified f
                    , lastModifiedDate f
                    , name f
                    , type_ f
                    , size f
                    )

data UploadOptions dataT headersT =
  UploadOptions { url :: JSString
                , method :: Maybe JSString -- TODO
                , headers :: Maybe headersT
                , withCredentials :: Maybe Bool
                , data_ :: Maybe dataT
                , file :: File
                , fileName :: Maybe JSString
                , fileFormDataName :: Maybe JSString
                , formDataAppAender :: Maybe (JSString -> JSString -> JSString -> IO ())
                }
instance (Unpack d, Unpack h) => Unpack (UploadOptions d h) where
  unpack opt = unpack ( url opt
                      , method opt
                      , headers opt
                      , withCredentials opt
                      , data_ opt
                      , file opt
                      , fileName opt
                      , fileFormDataName opt
                      , formDataAppAender opt)

-- a should be Deferred
upload :: (Pack a, Unpack d, Unpack h) => Upload -> UploadOptions d h -> IO (Maybe a)
upload = ffi "(function(u,o){return u.upload(o)})"

