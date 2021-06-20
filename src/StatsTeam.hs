module StatsTeam where

import qualified Data.Map                    as Map
import           Reactive.Banana.Combinators

import qualified BlueTeam                    as B
import qualified RedTeam                     as R

type UserStats = Map.Map User PageClicks
type User = String

data PageClicks = PageClicks RedPage BluePage
  deriving Show

newtype RedPage = RedPage Integer
  deriving Show

newtype BluePage = BluePage Integer
  deriving Show


initialStats :: UserStats
initialStats = Map.empty

blueButtonToStat :: B.ButtonClick -> UserStats
blueButtonToStat b = Map.fromList [(B.getUserString b, PageClicks (RedPage 0) (BluePage 1))]

redButtonToStat :: R.ButtonClick -> UserStats
redButtonToStat r = Map.fromList [(R.getUserString r, PageClicks (RedPage 1) (BluePage 0))]

-- lens library would be useful here
sumStats :: UserStats -> UserStats -> UserStats
sumStats = Map.unionWith addClicks
  where
    addClicks (PageClicks (RedPage r1) (BluePage b1)) (PageClicks (RedPage r2) (BluePage b2)) =
      PageClicks (RedPage (r1 + r2)) (BluePage (b1 + b2))

accumulateSums :: MonadMoment m => Event B.ButtonClick -> Event R.ButtonClick -> m (Behavior UserStats)
accumulateSums blueEvents redEvents =
  let
    blueClickStat = blueButtonToStat <$> blueEvents
    redClickStat = redButtonToStat <$> redEvents
    statEvents = unionWith sumStats blueClickStat redClickStat
  in
    accumB initialStats $ fmap sumStats statEvents


-- every time either event occurs, the behaviour will be updated with the count
-- pageEventCount :: Behavior UserStats
-- pageEventCount =
