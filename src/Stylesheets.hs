{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE PackageImports #-}

module Stylesheets where

--import Network.Socket.ByteString (recv, send, sendAll)
--import qualified Network.Socket.ByteString.Lazy as LN (sendAll) 
--import qualified Data.ByteString as SB
--import qualified Data.ByteString.Char8 as SBC
--import qualified Data.ByteString.Lazy as LB

import "base" Prelude hiding (head)
import Clay

application :: Css
application = h1 ? do
  color "#ff0000"

