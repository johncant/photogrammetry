module Angular.Auto.Injector where

import FFI

data NgInjector
data NgInjected

ngInject1 :: (String,  t1 -> Fay ()) -> Fay NgInjected
ngInject1 = ffi "(function() { return %1 })()"

ngInject2 :: (String, String, t1 -> t2 -> Fay ()) -> Fay NgInjected
ngInject2 = ffi "(function() { return %1 })()"

ngInject3 :: (String, String, String, t1 -> t2 -> t3 -> Fay ()) -> Fay NgInjected
ngInject3 = ffi "(function() { return %1 })()"
