{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_data_default_instances_old_locale (
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
version = Version [0,0,1] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/ek/.cabal/store/ghc-8.10.4/data-default-instances-old-locale-0.0.1-7c15e6c7c96cf0bc085c7b50dab17e666afa501b74842a47c96d375626a42e25/bin"
libdir     = "/home/ek/.cabal/store/ghc-8.10.4/data-default-instances-old-locale-0.0.1-7c15e6c7c96cf0bc085c7b50dab17e666afa501b74842a47c96d375626a42e25/lib"
dynlibdir  = "/home/ek/.cabal/store/ghc-8.10.4/data-default-instances-old-locale-0.0.1-7c15e6c7c96cf0bc085c7b50dab17e666afa501b74842a47c96d375626a42e25/lib"
datadir    = "/home/ek/.cabal/store/ghc-8.10.4/data-default-instances-old-locale-0.0.1-7c15e6c7c96cf0bc085c7b50dab17e666afa501b74842a47c96d375626a42e25/share"
libexecdir = "/home/ek/.cabal/store/ghc-8.10.4/data-default-instances-old-locale-0.0.1-7c15e6c7c96cf0bc085c7b50dab17e666afa501b74842a47c96d375626a42e25/libexec"
sysconfdir = "/home/ek/.cabal/store/ghc-8.10.4/data-default-instances-old-locale-0.0.1-7c15e6c7c96cf0bc085c7b50dab17e666afa501b74842a47c96d375626a42e25/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "data_default_instances_old_locale_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "data_default_instances_old_locale_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "data_default_instances_old_locale_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "data_default_instances_old_locale_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "data_default_instances_old_locale_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "data_default_instances_old_locale_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
