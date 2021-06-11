{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_reflection (
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
version = Version [2,1,6] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/ek/.cabal/store/ghc-8.10.4/reflection-2.1.6-bc119d9927a405dbd42187799cc5f636fb8aa5fee9b009c5d1a56c21bac6f5ab/bin"
libdir     = "/home/ek/.cabal/store/ghc-8.10.4/reflection-2.1.6-bc119d9927a405dbd42187799cc5f636fb8aa5fee9b009c5d1a56c21bac6f5ab/lib"
dynlibdir  = "/home/ek/.cabal/store/ghc-8.10.4/reflection-2.1.6-bc119d9927a405dbd42187799cc5f636fb8aa5fee9b009c5d1a56c21bac6f5ab/lib"
datadir    = "/home/ek/.cabal/store/ghc-8.10.4/reflection-2.1.6-bc119d9927a405dbd42187799cc5f636fb8aa5fee9b009c5d1a56c21bac6f5ab/share"
libexecdir = "/home/ek/.cabal/store/ghc-8.10.4/reflection-2.1.6-bc119d9927a405dbd42187799cc5f636fb8aa5fee9b009c5d1a56c21bac6f5ab/libexec"
sysconfdir = "/home/ek/.cabal/store/ghc-8.10.4/reflection-2.1.6-bc119d9927a405dbd42187799cc5f636fb8aa5fee9b009c5d1a56c21bac6f5ab/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "reflection_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "reflection_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "reflection_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "reflection_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "reflection_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "reflection_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
