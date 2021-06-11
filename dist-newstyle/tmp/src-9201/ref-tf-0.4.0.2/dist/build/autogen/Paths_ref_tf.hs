{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_ref_tf (
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
version = Version [0,4,0,2] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/ek/.cabal/store/ghc-8.10.4/ref-tf-0.4.0.2-d0b6ee897c6ebfb83e3a83ddceecc44df43fe1a5751badc962b3a34dfb3950e6/bin"
libdir     = "/home/ek/.cabal/store/ghc-8.10.4/ref-tf-0.4.0.2-d0b6ee897c6ebfb83e3a83ddceecc44df43fe1a5751badc962b3a34dfb3950e6/lib"
dynlibdir  = "/home/ek/.cabal/store/ghc-8.10.4/ref-tf-0.4.0.2-d0b6ee897c6ebfb83e3a83ddceecc44df43fe1a5751badc962b3a34dfb3950e6/lib"
datadir    = "/home/ek/.cabal/store/ghc-8.10.4/ref-tf-0.4.0.2-d0b6ee897c6ebfb83e3a83ddceecc44df43fe1a5751badc962b3a34dfb3950e6/share"
libexecdir = "/home/ek/.cabal/store/ghc-8.10.4/ref-tf-0.4.0.2-d0b6ee897c6ebfb83e3a83ddceecc44df43fe1a5751badc962b3a34dfb3950e6/libexec"
sysconfdir = "/home/ek/.cabal/store/ghc-8.10.4/ref-tf-0.4.0.2-d0b6ee897c6ebfb83e3a83ddceecc44df43fe1a5751badc962b3a34dfb3950e6/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "ref_tf_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "ref_tf_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "ref_tf_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "ref_tf_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ref_tf_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ref_tf_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
