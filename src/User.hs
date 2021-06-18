module User where

import           Control.Concurrent
import           Control.Event.Handler
import           Control.Monad
import           Reactive.Banana

import           Core

data User = User UserName UserPassword
  deriving Show

newtype UserName = UserName String
  deriving Show

newtype UserPassword = UserPassword String
  deriving Show

buttonClickEvents :: Event User -> (Event User, EventGenerator User)
buttonClickEvents events = (events, eventGenerator)

eventGenerator :: EventGenerator User
eventGenerator = EventGenerator
  (\eventTrigger -> forever $ do
      eventTrigger $ User (UserName "Tom") (UserPassword "123")
      threadDelay 1000000)
  "UserRegisterListener"






-- Registered users coming in

-- Input events, verify username is unique in the behaviour
-- Add to "database" which will be a behaviour of a list of users
