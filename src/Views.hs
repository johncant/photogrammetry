{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE PackageImports #-}

module Views where

--import Network.Socket.ByteString (recv, send, sendAll)
--import qualified Network.Socket.ByteString.Lazy as LN (sendAll) 
--import qualified Data.ByteString as SB
--import qualified Data.ByteString.Char8 as SBC
--import qualified Data.ByteString.Lazy as LB

import "base" Prelude hiding (head)
import Text.Blaze.Html5
import Text.Blaze.Html5.Attributes hiding (title, rows, accept)
--import qualified Text.Blaze.Html5.Attributes as A
--import Text.Blaze.Renderer.Utf8 (renderHtml, renderHtmlToByteStringIO)

root :: Html
root = docTypeHtml $ do
  head $ do
    title "3d reconstructor"
    link ! rel "stylesheet" ! type_ "text/css" ! href "/stylesheets/application.css"
  body $ do
    h1 "looool!!!!!"
