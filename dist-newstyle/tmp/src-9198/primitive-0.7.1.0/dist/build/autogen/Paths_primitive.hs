{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_primitive (
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
version = Version [0,7,1,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/ek/.cabal/store/ghc-8.10.4/primitive-0.7.1.0-57016f0038ed9bc68ae4ba8a0bf5334da1a65f93f4331980931e581cdbba846c/bin"
libdir     = "/home/ek/.cabal/store/ghc-8.10.4/primitive-0.7.1.0-57016f0038ed9bc68ae4ba8a0bf5334da1a65f93f4331980931e581cdbba846c/lib"
dynlibdir  = "/home/ek/.cabal/store/ghc-8.10.4/primitive-0.7.1.0-57016f0038ed9bc68ae4ba8a0bf5334da1a65f93f4331980931e581cdbba846c/lib"
datadir    = "/home/ek/.cabal/store/ghc-8.10.4/primitive-0.7.1.0-57016f0038ed9bc68ae4ba8a0bf5334da1a65f93f4331980931e581cdbba846c/share"
libexecdir = "/home/ek/.cabal/store/ghc-8.10.4/primitive-0.7.1.0-57016f0038ed9bc68ae4ba8a0bf5334da1a65f93f4331980931e581cdbba846c/libexec"
sysconfdir = "/home/ek/.cabal/store/ghc-8.10.4/primitive-0.7.1.0-57016f0038ed9bc68ae4ba8a0bf5334da1a65f93f4331980931e581cdbba846c/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "primitive_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "primitive_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "primitive_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "primitive_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "primitive_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "primitive_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
