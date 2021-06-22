module RedTeam where

import           Control.Concurrent
import           Control.Event.Handler
import           Control.Monad
import           Reactive.Banana

import           Routing

data ButtonClick = ButtonClick User ButtonType
  deriving Show

newtype User = User String
  deriving Show

data ButtonType = ButtonA | ButtonB | ButtonC
  deriving Show

getUserString :: ButtonClick -> String
getUserString (ButtonClick (User userString) _) = userString

buttonClickEvents :: Event ButtonClick -> Event ButtonClick
buttonClickEvents = id

eventGenerator :: EventGenerator ButtonClick
eventGenerator = EventGenerator
  (\eventTrigger -> forever $ do
      eventTrigger $ ButtonClick (User "Tom") ButtonA
      threadDelay 100000
      eventTrigger $ ButtonClick (User "Tom") ButtonB
      threadDelay 100000
      eventTrigger $ ButtonClick (User "Tom") ButtonC
      threadDelay 100000
      eventTrigger $ ButtonClick (User "Margaret") ButtonC
      threadDelay 100000)

  "RedTeamButtonClickListener"
