{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_some (
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
version = Version [1,0,2] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/ek/.cabal/store/ghc-8.10.4/some-1.0.2-9cd533ee67c40a7bdd1fa41d1ce8346a61054e44d4c831647800b797e94086fd/bin"
libdir     = "/home/ek/.cabal/store/ghc-8.10.4/some-1.0.2-9cd533ee67c40a7bdd1fa41d1ce8346a61054e44d4c831647800b797e94086fd/lib"
dynlibdir  = "/home/ek/.cabal/store/ghc-8.10.4/some-1.0.2-9cd533ee67c40a7bdd1fa41d1ce8346a61054e44d4c831647800b797e94086fd/lib"
datadir    = "/home/ek/.cabal/store/ghc-8.10.4/some-1.0.2-9cd533ee67c40a7bdd1fa41d1ce8346a61054e44d4c831647800b797e94086fd/share"
libexecdir = "/home/ek/.cabal/store/ghc-8.10.4/some-1.0.2-9cd533ee67c40a7bdd1fa41d1ce8346a61054e44d4c831647800b797e94086fd/libexec"
sysconfdir = "/home/ek/.cabal/store/ghc-8.10.4/some-1.0.2-9cd533ee67c40a7bdd1fa41d1ce8346a61054e44d4c831647800b797e94086fd/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "some_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "some_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "some_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "some_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "some_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "some_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
