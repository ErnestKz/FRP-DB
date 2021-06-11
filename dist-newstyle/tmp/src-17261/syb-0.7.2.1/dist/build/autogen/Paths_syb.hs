{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_syb (
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
version = Version [0,7,2,1] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/ek/.cabal/store/ghc-8.10.4/syb-0.7.2.1-5ab702592238bc2b73bdc476c2d0f306e172ab0ba542051531523e98f4297ef5/bin"
libdir     = "/home/ek/.cabal/store/ghc-8.10.4/syb-0.7.2.1-5ab702592238bc2b73bdc476c2d0f306e172ab0ba542051531523e98f4297ef5/lib"
dynlibdir  = "/home/ek/.cabal/store/ghc-8.10.4/syb-0.7.2.1-5ab702592238bc2b73bdc476c2d0f306e172ab0ba542051531523e98f4297ef5/lib"
datadir    = "/home/ek/.cabal/store/ghc-8.10.4/syb-0.7.2.1-5ab702592238bc2b73bdc476c2d0f306e172ab0ba542051531523e98f4297ef5/share"
libexecdir = "/home/ek/.cabal/store/ghc-8.10.4/syb-0.7.2.1-5ab702592238bc2b73bdc476c2d0f306e172ab0ba542051531523e98f4297ef5/libexec"
sysconfdir = "/home/ek/.cabal/store/ghc-8.10.4/syb-0.7.2.1-5ab702592238bc2b73bdc476c2d0f306e172ab0ba542051531523e98f4297ef5/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "syb_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "syb_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "syb_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "syb_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "syb_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "syb_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
