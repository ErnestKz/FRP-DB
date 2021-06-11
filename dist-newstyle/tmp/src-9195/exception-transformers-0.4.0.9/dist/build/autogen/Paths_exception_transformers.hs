{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_exception_transformers (
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
version = Version [0,4,0,9] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/ek/.cabal/store/ghc-8.10.4/exception-transformers-0.4.0.9-ca7b391bbd1d66870429269d56c0b2a289d6af25165ade7370f7ca8828a970ee/bin"
libdir     = "/home/ek/.cabal/store/ghc-8.10.4/exception-transformers-0.4.0.9-ca7b391bbd1d66870429269d56c0b2a289d6af25165ade7370f7ca8828a970ee/lib"
dynlibdir  = "/home/ek/.cabal/store/ghc-8.10.4/exception-transformers-0.4.0.9-ca7b391bbd1d66870429269d56c0b2a289d6af25165ade7370f7ca8828a970ee/lib"
datadir    = "/home/ek/.cabal/store/ghc-8.10.4/exception-transformers-0.4.0.9-ca7b391bbd1d66870429269d56c0b2a289d6af25165ade7370f7ca8828a970ee/share"
libexecdir = "/home/ek/.cabal/store/ghc-8.10.4/exception-transformers-0.4.0.9-ca7b391bbd1d66870429269d56c0b2a289d6af25165ade7370f7ca8828a970ee/libexec"
sysconfdir = "/home/ek/.cabal/store/ghc-8.10.4/exception-transformers-0.4.0.9-ca7b391bbd1d66870429269d56c0b2a289d6af25165ade7370f7ca8828a970ee/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "exception_transformers_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "exception_transformers_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "exception_transformers_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "exception_transformers_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "exception_transformers_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "exception_transformers_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
