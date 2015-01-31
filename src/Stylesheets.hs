{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE PackageImports #-}

module Stylesheets where

--import Network.Socket.ByteString (recv, send, sendAll)
--import qualified Network.Socket.ByteString.Lazy as LN (sendAll) 
--import qualified Data.ByteString as SB
--import qualified Data.ByteString.Char8 as SBC
--import qualified Data.ByteString.Lazy as LB

import "base" Prelude hiding (head, div)
import Clay

upload :: Css
upload = do
  div # ".upload_drag" ? do
    border dashed (px 2) "#0000FF"
    backgroundColor "#CCCCCC"
    width (px 400)
    height (px 100)

applicationMenu :: Css
applicationMenu = div # ".application_menu" ? do
  backgroundColor "#AAAAAA"
  position fixed
  top (px 0)
  left (px 0)
  right (px 0)
  height (px 40)
  ul ? do
    sym margin (px 0)
    sym padding (px 0)
    li ? do
      sym margin (px 0)
      marginLeft (px 0)
      marginRight (px 0)
      listStyleType none
      float floatLeft
      sym2 padding (px 10) (px 0)
      a ? do
        sym2 padding (px 12) (px 15)
        textDecoration none
        color "#FFFFFF"
        hover & do
          backgroundColor "#666666"
    li # lastChild ? do
      float floatRight

applicationMenuSpacer :: Css
applicationMenuSpacer = div # ".application_menu_spacer" ? do
  width (px 0)
  height (px 40)
  sym margin (px 0)

application :: Css
application = do
  applicationMenu
  applicationMenuSpacer
  upload
  h1 ? do
    color "#ff0000"

