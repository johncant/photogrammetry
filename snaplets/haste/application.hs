{-# LANGUAGE OverloadedStrings #-}

import qualified Haste.Angular.Ng as Ng
import           Haste.Angular.Providers.LocationProvider
import qualified AngularUi.UiRouter as UI
import Haste.Prim

import Controllers.ImageUploaderController as CI

setupAppRoutes :: (JSString, JSString, JSString, UI.StateProvider -> UI.UrlRouterProvider -> LocationProvider -> IO ())
setupAppRoutes = ("$stateProvider", "$urlRouterProvider", "$locationProvider", \stateProvider urlRouterProvider locationProvider -> do

  html5Mode locationProvider True

  urlRouterProvider <- UI.otherwise urlRouterProvider "/"

  stateProvider <- UI.state stateProvider "index" "/" "/templates/index" Nothing
  stateProvider <- UI.state stateProvider "about" "/about" "/templates/about" Nothing
  stateProvider <- UI.state stateProvider "new_reconstruction" "/reconstructions/new" "/templates/reconstructions/new" Nothing
  stateProvider <- UI.state stateProvider "reconstructions" "/reconstructions" "/templates/reconstructions/index" Nothing

  return ()
  )

main = do
  Ng.runAngular $ do
    Ng.module' "photogrammetryApp" ["ui.router", "angularFileUpload"] (Nothing :: Maybe (IO ())) $ do
      Ng.config setupAppRoutes
      Ng.controller "ImageUploaderController" CI.setup

  return ()

