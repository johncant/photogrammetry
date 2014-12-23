module Application where

import Prelude hiding (otherwise)
import Angular.Module
import Angular.Auto.Injector
import Angular.Providers.LocationProvider
import AngularUi.UiRouter
import FFI

newPhotogrammetryApp :: Fay NgModule
newPhotogrammetryApp = newNgModule "photogrammetryApp" ["ui.router"]

photogrammetryApp :: Fay NgModule
photogrammetryApp = ngModule "photogrammetryApp"

setupAppRoutes :: StateProvider -> UrlRouterProvider -> LocationProvider -> Fay ()
setupAppRoutes stateProvider urlRouterProvider locationProvider = do

  html5Mode True locationProvider

  urlRouterProvider <- otherwise "/" urlRouterProvider

  state "index" "/" "/templates/index" Undefined stateProvider
  state "about" "/about" "/templates/about" Undefined stateProvider
  state "new_reconstruction" "/reconstructions/new" "/templates/reconstructions/new" Undefined stateProvider
  state "reconstructions" "/reconstructions" "/templates/reconstructions/index" Undefined stateProvider

  return ()

main :: Fay ()
main = do
  app <- newPhotogrammetryApp
  cj  <- (ngInject3 ("$stateProvider", "$urlRouterProvider", "$locationProvider", setupAppRoutes))
  app <- ngConfig cj app
  return ()

