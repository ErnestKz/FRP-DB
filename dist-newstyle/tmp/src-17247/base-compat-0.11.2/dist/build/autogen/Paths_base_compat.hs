{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_base_compat (
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
version = Version [0,11,2] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/ek/.cabal/store/ghc-8.10.4/base-compat-0.11.2-7b66297a21dbcdaeb313bb6c4bf210761a72eeb81195a8c6cfe9cdcc747bf2e1/bin"
libdir     = "/home/ek/.cabal/store/ghc-8.10.4/base-compat-0.11.2-7b66297a21dbcdaeb313bb6c4bf210761a72eeb81195a8c6cfe9cdcc747bf2e1/lib"
dynlibdir  = "/home/ek/.cabal/store/ghc-8.10.4/base-compat-0.11.2-7b66297a21dbcdaeb313bb6c4bf210761a72eeb81195a8c6cfe9cdcc747bf2e1/lib"
datadir    = "/home/ek/.cabal/store/ghc-8.10.4/base-compat-0.11.2-7b66297a21dbcdaeb313bb6c4bf210761a72eeb81195a8c6cfe9cdcc747bf2e1/share"
libexecdir = "/home/ek/.cabal/store/ghc-8.10.4/base-compat-0.11.2-7b66297a21dbcdaeb313bb6c4bf210761a72eeb81195a8c6cfe9cdcc747bf2e1/libexec"
sysconfdir = "/home/ek/.cabal/store/ghc-8.10.4/base-compat-0.11.2-7b66297a21dbcdaeb313bb6c4bf210761a72eeb81195a8c6cfe9cdcc747bf2e1/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "base_compat_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "base_compat_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "base_compat_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "base_compat_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "base_compat_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "base_compat_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
