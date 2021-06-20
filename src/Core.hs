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
        events <- createEventStream    -- this needs to be in MomentIO as it is a building block for creating a network
        reactimate $ fmap print events -- fmapping the print on the evnets creates Event (IO ()), needs to be a part of MomentIO because it describes the output of the network
  network <- compile networkDescription   -- takes the MomentIO built and creates an IO EventNetwork, needs the IO in order to execute the IO stuff in the MomentIO
  actuate network                         -- actuate creates an IO as it needs to listen to the things that produce IO
  print "hello"
  forever $ threadDelay 1000000


-- Everything that runs a MomentIO should be collected in the new monad and run in the core procedure
-- e.g createEventStream, reactimate

createEventStream :: MomentIO (Event String)
createEventStream = do
    (eventStream, eventTrigger) <- liftIO newAddHandler
    liftIO $ forkIO $ eventGenerator eventTrigger  -- should probably fork these after the network has actuated and is reacting to the inputs
    fromAddHandler eventStream

eventGenerator :: (String -> IO a) -> IO ()
eventGenerator eventTrigger = mapM_ (\x ->
                                       eventTrigger ("Hello.. Iteration: " ++ show x) >>
                                       threadDelay 1000000)
                              [0..]





core2 :: MomentIO ()
core2 = do
    (eventStream, eventTrigger) <- newEvent
    reactimate $ fmap putStrLn eventStream
    liftIO $ forkIO $ threadDelay 10000 >> eventTrigger "Hello!"
    void $ liftIO $ forkIO $ threadDelay 10000 >> eventTrigger "World!"
    -- liftIO $ threadDelay 1000000

