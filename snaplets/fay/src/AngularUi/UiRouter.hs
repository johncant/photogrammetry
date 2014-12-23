module AngularUi.UiRouter where

import FFI
import Angular.Auto.Injector
import Angular.Ng.Controller (NgController)

data StateProvider
data UrlRouterProvider

otherwise :: String -> UrlRouterProvider -> Fay UrlRouterProvider
otherwise = ffi "%2.otherwise(%1)"

state :: String
      -> String
      -> String
      -> Defined NgController
      -> StateProvider
      -> Fay StateProvider
state = ffi "%5.state(%1, {url: %2, templateUrl: %3, controller: %4})"
