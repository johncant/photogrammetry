{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE PackageImports #-}

------------------------------------------------------------------------------
-- | This module is where all the routes and handlers are defined for your
-- site. The 'app' function is the initializer that combines everything
-- together and is exported by this module.
module Site
  ( app
  ) where

------------------------------------------------------------------------------
import "base" Prelude
import           Control.Applicative
import           Data.ByteString (ByteString)
import qualified Data.Text as T
import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.Auth
import           Snap.Snaplet.Auth.Backends.JsonFile
import           Snap.Snaplet.Session.Backends.CookieSession
import           Snap.Snaplet.Fay
import           Snap.Util.FileServe
import qualified Clay (render, putCss)
import qualified Views
import qualified Stylesheets
import qualified Templates
import Control.Monad.IO.Class (liftIO)
------------------------------------------------------------------------------
import           Application

-- Ripped this out of snap-blaze-clay
import Text.Blaze.Html (Html)
import Text.Blaze.Html.Renderer.Utf8 (renderHtml)

blaze :: MonadSnap m => Html -> m ()
blaze response = do
     modifyResponse $ addHeader "Content-Type" "text/html; charset=UTF-8"
     writeLBS $ renderHtml response

handleRoot :: Handler App App ()
handleRoot = method GET (blaze Views.root)

handleCss :: Handler App App ()
handleCss = method GET $ do
  liftIO $ putStrLn "Rendering CSS"
  liftIO $ Clay.putCss Stylesheets.application
  liftIO $ putStrLn "Rendered CSS"
  writeLazyText $ Clay.render Stylesheets.application

handleTemplate :: Html -> Handler App App ()
handleTemplate h = method GET (blaze h)

------------------------------------------------------------------------------
-- | The application's routes.
routes :: [(ByteString, Handler App App ())]
routes = [ ("/javascripts/lib", serveDirectory "static/javascripts/lib")
         , ("/javascripts/app", with fay fayServe)
         , ("/stylesheets/application.css", handleCss)
         , ("/templates/index", handleTemplate Templates.index)
         , ("/templates/about", handleTemplate Templates.about)
         , ("/templates/reconstructions/new", handleTemplate Templates.newReconstruction)
         , ("/templates/reconstructions/index", handleTemplate Templates.reconstructions)
         , ("/",          handleRoot)
         --, ("",          serveDirectory "static")
         ]


------------------------------------------------------------------------------
-- | The application initializer.
app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application." Nothing $ do
--    h <- nestSnaplet "" heist $ heistInit "templates"
    s <- nestSnaplet "sess" sess $
           initCookieSessionManager "site_key.txt" "sess" (Just 3600)

    -- NOTE: We're using initJsonFileAuthManager here because it's easy and
    -- doesn't require any kind of database server to run.  In practice,
    -- you'll probably want to change this to a more robust auth backend.
    a <- nestSnaplet "auth" auth $
           initJsonFileAuthManager defAuthSettings sess "users.json"
    f <- nestSnaplet "fay" fay initFay
    addRoutes routes
--    addAuthSplices h auth
    return $ App s a f

