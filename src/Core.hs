module Core where

import           Control.Concurrent
import           Control.Monad
import           Reactive.Banana
import           Reactive.Banana.Frameworks

data EventGenerator a = EventGenerator { runEventGenerator :: Handler a -> IO ()
                                       , eventGeneratorName :: String}

core :: IO ()
core = do
  let networkDescription :: MomentIO ()
      networkDescription = do
        events <- createEventStream    -- this needs to be in IO as it does newAddHandler and needs to be in MomentIO as it does fromAddHandler
        reactimate $ fmap print events -- fmapping the print on the evnets creates Event (IO ()), needs to be a part of MomentIO probably because it describes a new piece of tthe event network
  network <- compile networkDescription   -- takes the MomentIO built and creates an IO EventNetwork, needs the IO in order to execute the IO stuff in the MomentIO
  actuate network                         -- actuate creates an IO as it needs to listen to the things that produce IO
  print "hello"
  forever $ threadDelay 1000000


createEventStream :: MomentIO (Event String)
createEventStream = do
    (eventStream, eventTrigger) <- liftIO newAddHandler
    liftIO $ forkIO $ eventGenerator eventTrigger
    fromAddHandler eventStream

eventGenerator :: (String -> IO a) -> IO ()
eventGenerator eventTrigger = mapM_ (\x ->
                                       eventTrigger ("Hello.. Iteration: " ++ show x) >>
                                       threadDelay 1000000)
                              [0..]



