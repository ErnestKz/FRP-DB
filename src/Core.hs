{-# LANGUAGE RecursiveDo #-}
module Core where

import           Control.Concurrent
import           Control.Monad
import           Reactive.Banana
import           Reactive.Banana.Frameworks

import           Routing

import qualified BlueTeam                   as B
import qualified PrizeTeam                  as P
import qualified RedTeam                    as R
import qualified StatsTeam                  as S

core :: IO ()
core = do
  network <- compile networkSetup
  actuate network
  forever $ threadDelay 10000000

networkSetup :: MomentIO ()
networkSetup = mdo
  let (EventGenerator redRunEvent _) = R.eventGenerator
      (EventGenerator blueRunEvent _) = B.eventGenerator
  (redStream, redTrigger) <- newEvent
  (blueStream, blueTrigger) <- newEvent

  -- should delay running the events until the network is actuated
  liftIO $ forkIO $ redRunEvent redTrigger
  liftIO $ forkIO $ blueRunEvent blueTrigger

  userStatsState <- S.accumulateSums blueStream redStream
  -- statsChanges <- changes $ fmap print userStatsState
  -- reactimate' statsChanges

  let pageClicks = S.totalPageClicks userStatsState
  -- statsChanges <- changes $ fmap print userStatsState
  -- reactimate' statsChanges

  let nthClick = S.nthClickBetweenRedAndBlue pageClicks blueStream redStream
  -- reactimate $ fmap print nthClick

  let win = P.congratulateUser nthClick prizesTaken
  prizesTaken <- P.prizesTaken win

  reactimate $ fmap print win
  statsChanges <- changes $ fmap print prizesTaken
  reactimate' statsChanges
  return ()
