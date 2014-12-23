module Angular.Providers.LocationProvider where

import FFI

data LocationProvider

html5Mode :: Bool -> LocationProvider -> Fay ()
html5Mode = ffi "%2.html5Mode(%1)"
