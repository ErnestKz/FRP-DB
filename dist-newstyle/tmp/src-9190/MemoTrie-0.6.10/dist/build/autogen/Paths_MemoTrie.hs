{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_MemoTrie (
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
version = Version [0,6,10] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/ek/.cabal/store/ghc-8.10.4/MemoTrie-0.6.10-1a11ef8bcfb4c1faa34b5f4a0a9cf732aa1c305cc8873364d5abc17d68647f68/bin"
libdir     = "/home/ek/.cabal/store/ghc-8.10.4/MemoTrie-0.6.10-1a11ef8bcfb4c1faa34b5f4a0a9cf732aa1c305cc8873364d5abc17d68647f68/lib"
dynlibdir  = "/home/ek/.cabal/store/ghc-8.10.4/MemoTrie-0.6.10-1a11ef8bcfb4c1faa34b5f4a0a9cf732aa1c305cc8873364d5abc17d68647f68/lib"
datadir    = "/home/ek/.cabal/store/ghc-8.10.4/MemoTrie-0.6.10-1a11ef8bcfb4c1faa34b5f4a0a9cf732aa1c305cc8873364d5abc17d68647f68/share"
libexecdir = "/home/ek/.cabal/store/ghc-8.10.4/MemoTrie-0.6.10-1a11ef8bcfb4c1faa34b5f4a0a9cf732aa1c305cc8873364d5abc17d68647f68/libexec"
sysconfdir = "/home/ek/.cabal/store/ghc-8.10.4/MemoTrie-0.6.10-1a11ef8bcfb4c1faa34b5f4a0a9cf732aa1c305cc8873364d5abc17d68647f68/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "MemoTrie_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "MemoTrie_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "MemoTrie_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "MemoTrie_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "MemoTrie_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "MemoTrie_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
