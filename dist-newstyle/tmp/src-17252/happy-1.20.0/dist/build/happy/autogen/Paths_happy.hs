{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_happy (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [1,20,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/ek/.cabal/store/ghc-8.10.4/happy-1.20.0-e-happy-e86d5ed3e520d0cb8050e9948a12109d4f9ce6c5330aab0f388764d3d1a6e33e/bin"
libdir     = "/home/ek/.cabal/store/ghc-8.10.4/happy-1.20.0-e-happy-e86d5ed3e520d0cb8050e9948a12109d4f9ce6c5330aab0f388764d3d1a6e33e/lib"
dynlibdir  = "/home/ek/.cabal/store/ghc-8.10.4/happy-1.20.0-e-happy-e86d5ed3e520d0cb8050e9948a12109d4f9ce6c5330aab0f388764d3d1a6e33e/lib"
datadir    = "/home/ek/.cabal/store/ghc-8.10.4/happy-1.20.0-e-happy-e86d5ed3e520d0cb8050e9948a12109d4f9ce6c5330aab0f388764d3d1a6e33e/share"
libexecdir = "/home/ek/.cabal/store/ghc-8.10.4/happy-1.20.0-e-happy-e86d5ed3e520d0cb8050e9948a12109d4f9ce6c5330aab0f388764d3d1a6e33e/libexec"
sysconfdir = "/home/ek/.cabal/store/ghc-8.10.4/happy-1.20.0-e-happy-e86d5ed3e520d0cb8050e9948a12109d4f9ce6c5330aab0f388764d3d1a6e33e/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "happy_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "happy_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "happy_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "happy_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "happy_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "happy_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
