module Core where

import           Reactive.Banana.Frameworks

data EventGenerator a = EventGenerator { runEventGenerator :: Handler a -> IO ()
                                       , eventGeneratorName :: String}

core :: IO ()
core = print "hello"




