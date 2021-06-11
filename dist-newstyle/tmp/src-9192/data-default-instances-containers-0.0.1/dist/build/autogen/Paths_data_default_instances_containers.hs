{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_data_default_instances_containers (
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

bindir     = "/home/ek/.cabal/store/ghc-8.10.4/data-default-instances-containers-0.0.1-db40825d81b3c54244fa400a06568c3c06d54afbab6f38749dd4178e5d6ced5c/bin"
libdir     = "/home/ek/.cabal/store/ghc-8.10.4/data-default-instances-containers-0.0.1-db40825d81b3c54244fa400a06568c3c06d54afbab6f38749dd4178e5d6ced5c/lib"
dynlibdir  = "/home/ek/.cabal/store/ghc-8.10.4/data-default-instances-containers-0.0.1-db40825d81b3c54244fa400a06568c3c06d54afbab6f38749dd4178e5d6ced5c/lib"
datadir    = "/home/ek/.cabal/store/ghc-8.10.4/data-default-instances-containers-0.0.1-db40825d81b3c54244fa400a06568c3c06d54afbab6f38749dd4178e5d6ced5c/share"
libexecdir = "/home/ek/.cabal/store/ghc-8.10.4/data-default-instances-containers-0.0.1-db40825d81b3c54244fa400a06568c3c06d54afbab6f38749dd4178e5d6ced5c/libexec"
sysconfdir = "/home/ek/.cabal/store/ghc-8.10.4/data-default-instances-containers-0.0.1-db40825d81b3c54244fa400a06568c3c06d54afbab6f38749dd4178e5d6ced5c/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "data_default_instances_containers_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "data_default_instances_containers_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "data_default_instances_containers_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "data_default_instances_containers_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "data_default_instances_containers_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "data_default_instances_containers_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
