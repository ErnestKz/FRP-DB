module RedTeam where

import           Control.Concurrent
import           Control.Event.Handler
import           Control.Monad
import           Reactive.Banana

import           Core

data ButtonClick = ButtonClick User ButtonType
  deriving Show

newtype User = User String
  deriving Show

data ButtonType = ButtonA | ButtonB | ButtonC
  deriving Show

buttonClickEvents :: Event ButtonClick-> (Event ButtonClick, EventGenerator ButtonClick)
buttonClickEvents events = (events, eventGenerator)

eventGenerator :: EventGenerator ButtonClick
eventGenerator = EventGenerator
  (\eventTrigger -> forever $ do
      eventTrigger $ ButtonClick (User "Tom") ButtonA
      threadDelay 1000000
      eventTrigger $ ButtonClick (User "Tom") ButtonB
      threadDelay 1000000
      eventTrigger $ ButtonClick (User "Tom") ButtonC
      threadDelay 1000000)
  "RedTeamButtonClickListener"
