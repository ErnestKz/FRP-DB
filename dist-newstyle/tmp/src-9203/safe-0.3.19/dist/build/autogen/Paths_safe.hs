{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_safe (
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
version = Version [0,3,19] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/ek/.cabal/store/ghc-8.10.4/safe-0.3.19-4c69cfea575d59a49323ee46a0934999f5a2fcaa530be88104aee196b05cff58/bin"
libdir     = "/home/ek/.cabal/store/ghc-8.10.4/safe-0.3.19-4c69cfea575d59a49323ee46a0934999f5a2fcaa530be88104aee196b05cff58/lib"
dynlibdir  = "/home/ek/.cabal/store/ghc-8.10.4/safe-0.3.19-4c69cfea575d59a49323ee46a0934999f5a2fcaa530be88104aee196b05cff58/lib"
datadir    = "/home/ek/.cabal/store/ghc-8.10.4/safe-0.3.19-4c69cfea575d59a49323ee46a0934999f5a2fcaa530be88104aee196b05cff58/share"
libexecdir = "/home/ek/.cabal/store/ghc-8.10.4/safe-0.3.19-4c69cfea575d59a49323ee46a0934999f5a2fcaa530be88104aee196b05cff58/libexec"
sysconfdir = "/home/ek/.cabal/store/ghc-8.10.4/safe-0.3.19-4c69cfea575d59a49323ee46a0934999f5a2fcaa530be88104aee196b05cff58/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "safe_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "safe_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "safe_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "safe_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "safe_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "safe_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
