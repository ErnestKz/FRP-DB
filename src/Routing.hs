module Routing where

import           Control.Event.Handler
import           Reactive.Banana

data EventGenerator a = EventGenerator { runEventGenerator :: Handler a -> IO ()
                                       , eventGeneratorName :: String}

