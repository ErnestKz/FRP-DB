module StatsTeam where

import           Reactive.Banana.Combinators

import qualified BlueTeam                    as B
import qualified RedTeam                     as R

data UserStats = UserStats User PageClicks
  deriving Show

newtype User = User String
  deriving Show

data PageClicks = PageClicks RedPage BluePage
  deriving Show

newtype RedPage = RedPage Integer
  deriving Show

newtype BluePage = BluePage Integer
  deriving Show



-- every time either event occurs, the behaviour will be updated with the count
-- pageEventCount :: Behavior UserStats
-- pageEventCount =
