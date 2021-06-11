{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_semigroups (
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
version = Version [0,19,1] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/ek/.cabal/store/ghc-8.10.4/semigroups-0.19.1-9bd2a5a836db517f37cc75e4855c48fac208d217260aee35dd472bf6367f488b/bin"
libdir     = "/home/ek/.cabal/store/ghc-8.10.4/semigroups-0.19.1-9bd2a5a836db517f37cc75e4855c48fac208d217260aee35dd472bf6367f488b/lib"
dynlibdir  = "/home/ek/.cabal/store/ghc-8.10.4/semigroups-0.19.1-9bd2a5a836db517f37cc75e4855c48fac208d217260aee35dd472bf6367f488b/lib"
datadir    = "/home/ek/.cabal/store/ghc-8.10.4/semigroups-0.19.1-9bd2a5a836db517f37cc75e4855c48fac208d217260aee35dd472bf6367f488b/share"
libexecdir = "/home/ek/.cabal/store/ghc-8.10.4/semigroups-0.19.1-9bd2a5a836db517f37cc75e4855c48fac208d217260aee35dd472bf6367f488b/libexec"
sysconfdir = "/home/ek/.cabal/store/ghc-8.10.4/semigroups-0.19.1-9bd2a5a836db517f37cc75e4855c48fac208d217260aee35dd472bf6367f488b/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "semigroups_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "semigroups_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "semigroups_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "semigroups_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "semigroups_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "semigroups_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
