module Angular.Module where

import FFI
import Angular.Auto.Injector
import Angular.Ng.RootScope

data NgModule
type NgConfigurator = (NgInjector -> Fay())

newNgModule :: String -> [String] -> Fay NgModule
newNgModule = ffi "angular.module(%1, %2)"

ngModule :: String -> Fay NgModule
ngModule = ffi "angular.module(%1)"

ngConfig2 :: (String, String, t1 -> t2 -> Fay ()) -> NgModule -> Fay NgModule
ngConfig2 = (ffi "%2.config(%1)" :: (String, String, t1 -> t2 -> Fay ()) -> NgModule -> Fay NgModule)

ngConfig :: NgInjected -> NgModule -> Fay NgModule
ngConfig = ffi "%2.config(%1)"

ngRun :: NgModule -> Maybe NgConfigurator -> Fay ()
ngRun m (Just f) = (ffi "%1.run(['$injector', %2])" :: NgModule -> NgConfigurator -> Fay ()) m f
ngRun m Nothing = (ffi "%1.run()" :: NgModule -> Fay ()) m
