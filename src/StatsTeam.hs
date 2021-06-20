module StatsTeam where

import qualified Data.Map                    as Map
import qualified Data.Set                    as Set
import           Reactive.Banana.Combinators

import qualified BlueTeam                    as B
import qualified RedTeam                     as R

type UserStats = Map.Map User UserPageClicks
type User = String

data UserPageClicks = UserPageClicks RedPage BluePage
  deriving Show

newtype RedPage = RedPage Integer
  deriving Show

newtype BluePage = BluePage Integer
  deriving Show


initialStats :: UserStats
initialStats = Map.empty

blueButtonToStat :: B.ButtonClick -> UserStats
blueButtonToStat b = Map.fromList [(B.getUserString b, UserPageClicks (RedPage 0) (BluePage 1))]

redButtonToStat :: R.ButtonClick -> UserStats
redButtonToStat r = Map.fromList [(R.getUserString r, UserPageClicks (RedPage 1) (BluePage 0))]

sumStats :: UserStats -> UserStats -> UserStats
sumStats = Map.unionWith addClicks
  where
    addClicks (UserPageClicks (RedPage r1) (BluePage b1)) (UserPageClicks (RedPage r2) (BluePage b2)) =
      UserPageClicks (RedPage (r1 + r2)) (BluePage (b1 + b2))

accumulateSums :: MonadMoment m => Event B.ButtonClick -> Event R.ButtonClick -> m (Behavior UserStats)
accumulateSums blueEvents redEvents =
  accumB initialStats $ fmap sumStats statEvents
  where
    statEvents = unionWith sumStats blueClickStat redClickStat
    blueClickStat = blueButtonToStat <$> blueEvents
    redClickStat = redButtonToStat <$> redEvents


data TotalPageClicks = TotalPageClicks RedPage BluePage

totalPageClicks :: Behavior UserStats -> Behavior TotalPageClicks
totalPageClicks userStatsBehavior = Map.foldr sumPageClicks zeroPageClicks <$> userStatsBehavior
  where
    zeroPageClicks = TotalPageClicks (RedPage 0) (BluePage 0)
    sumPageClicks :: UserPageClicks -> TotalPageClicks -> TotalPageClicks
    sumPageClicks
      (UserPageClicks (RedPage ru) (BluePage bu))
      (TotalPageClicks (RedPage rt) (BluePage bt)) =
      TotalPageClicks (RedPage (rt + ru)) (BluePage (bu + bt))


data UserNthClick = UserNthClick User Integer

nthClickBetweenRedAndBlue :: Behavior TotalPageClicks -> Event B.ButtonClick -> Event R.ButtonClick -> Event UserNthClick
nthClickBetweenRedAndBlue = undefined





-- accumulateSums2 :: (MonadMoment m) => m (Behavior UserStats)
-- accumulateSums2 = do
--   blueEvents <- B.buttonClickEvents
--   redEvents <- R.buttonClickEvents
--   let
--     blueClickStat = blueButtonToStat <$> blueEvents
--     redClickStat = redButtonToStat <$> redEvents
--     statEvents = unionWith sumStats blueClickStat redClickStat
--   accumB initialStats $ fmap sumStats statEvents



-- every time either event occurs, the behaviour will be updated with the count
-- pageEventCount :: Behavior UserStats
-- pageEventCount =
