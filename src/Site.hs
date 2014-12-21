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
import           Snap.Blaze (blaze)
import Control.Monad.IO.Class (liftIO)
------------------------------------------------------------------------------
import           Application



handleRoot :: Handler App App ()
handleRoot = method GET (blaze Views.root)

handleCss :: Handler App App ()
handleCss = method GET $ do
  liftIO $ putStrLn "Rendering CSS"
  liftIO $ Clay.putCss Stylesheets.application
  liftIO $ putStrLn "Rendered CSS"
  writeLazyText $ Clay.render Stylesheets.application

------------------------------------------------------------------------------
-- | The application's routes.
routes :: [(ByteString, Handler App App ())]
routes = [ ("/",          handleRoot)
         , ("/javascripts", with fay fayServe)
         , ("/stylesheets/application.css", handleCss)
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

