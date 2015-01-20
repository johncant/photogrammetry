module Angular.Ng.Controller where

import FFI
import Angular.Ng.RootScope
import Angular.Auto.Injector
import Angular.Module
import Fay.Text

type NgController = (NgScope -> NgInjector -> Fay())

ngController :: Text -> NgInjected -> NgModule -> Fay NgController
ngController = ffi "%3.controller(%1, %2)"

ngConfig :: NgInjected -> NgController -> Fay NgController
ngConfig = ffi "%2.config(%1)"


