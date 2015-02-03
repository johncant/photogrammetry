{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE PackageImports #-}

module Views where

--import Network.Socket.ByteString (recv, send, sendAll)
--import qualified Network.Socket.ByteString.Lazy as LN (sendAll) 
--import qualified Data.ByteString as SB
--import qualified Data.ByteString.Char8 as SBC
--import qualified Data.ByteString.Lazy as LB

import "base" Prelude hiding (head, div, id)
import Text.Blaze.Html5
import Text.Blaze.Html5.Attributes hiding (title, rows, accept)
--import qualified RouteHelpers as Path
--import qualified Text.Blaze.Html5.Attributes as A
--import Text.Blaze.Renderer.Utf8 (renderHtml, renderHtmlToByteStringIO)

root :: Html
root = docTypeHtml $ do
  html ! lang "en" ! customAttribute "ng-app" "photogrammetryApp" $ do
    head $ do
      title "3d reconstructor"
      link ! rel "stylesheet" ! type_ "text/css" ! href "/stylesheets/application.css"
--      script ! type_ "text/javascript" ! src "/javascripts/lib/angular.min.js" $ return ()
--      script ! type_ "text/javascript" ! src "/javascripts/lib/angular-ui-router.min.js" $ return ()
--      script ! type_ "text/javascript" ! src "/javascripts/lib/angular-file-upload-all.min.js" $ return ()
      script ! type_ "text/javascript" ! src "/javascripts/lib/react-0.12.2.js" $ return ()
      script ! type_ "text/javascript" ! src "/javascripts/lib/stubs.js" $ return ()
      script ! type_ "text/javascript" ! src "/javascripts/lib/bezier.js" $ return ()
      script ! type_ "text/javascript" ! src "/javascripts/app/application.js" $ return ()
      base ! href "/"
    body $ do
      div ! id "app" $ do
        "This page requires javascript"
