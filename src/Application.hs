{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE PackageImports #-}

------------------------------------------------------------------------------
-- | This module defines our application's state type and an alias for its
-- handler monad.
module Application where

------------------------------------------------------------------------------
import "base" Prelude
import Control.Lens
import Snap.Snaplet
import Snap.Snaplet.Auth
import Snap.Snaplet.Session
import Snap.Snaplet.Haste

------------------------------------------------------------------------------
data App = App
    { _sess :: Snaplet SessionManager
    , _auth :: Snaplet (AuthManager App)
    , _haste :: Snaplet Haste
    }

makeLenses ''App


------------------------------------------------------------------------------
type AppHandler = Handler App App


