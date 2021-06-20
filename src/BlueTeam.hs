module BlueTeam  where

import           Control.Concurrent
import           Control.Event.Handler
import           Control.Monad
import           Reactive.Banana

import           Core

data ButtonClick = ButtonClick User ButtonId
  deriving Show

newtype User = User String
  deriving Show

newtype ButtonId = ButtonId Integer
  deriving Show

getUserString :: ButtonClick -> String
getUserString (ButtonClick (User userString) _) = userString

buttonClickEvents events = undefined

eventGenerator :: EventGenerator ButtonClick
eventGenerator = EventGenerator
  (\eventTrigger -> forever $ do
      eventTrigger $ ButtonClick (User "Tom") (ButtonId 1)
      threadDelay 1000000
      eventTrigger $ ButtonClick (User "Tom") (ButtonId 2)
      threadDelay 1000000
      eventTrigger $ ButtonClick (User "Tom") (ButtonId 3)
      threadDelay 1000000)
  "BlueTeamButtonClickListener"
