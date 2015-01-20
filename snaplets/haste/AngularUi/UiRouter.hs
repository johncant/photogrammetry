{-# LANGUAGE OverloadedStrings #-}
module AngularUi.UiRouter where

import Haste
import Haste.Foreign
import qualified Haste.Angular.Ng as Ng (Controller)

type StateProvider = Unpacked
type UrlRouterProvider = Unpacked

otherwise :: UrlRouterProvider -> JSString -> IO UrlRouterProvider
otherwise = ffi "(function(u,s){return u.otherwise(s)})"

state :: StateProvider
      -> JSString
      -> JSString
      -> JSString
      -> Maybe Ng.Controller
      -> IO StateProvider
state = ffi "(function(e,a,b,c,d){return e.state(a, {url: b, templateUrl: c, controller: d}) })"
