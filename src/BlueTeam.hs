module BlueTeam (createUserEvents) where

import           Control.Concurrent
import           Control.Monad
import           Control.Monad.IO.Class
import           Reflex

data ButtonClick = ButtonClick UserName ButtonId
  deriving Show
type UserName = String
type ButtonId = Integer


createUserEvents :: (MonadIO m, TriggerEvent t m) => m (Event t ButtonClick)
createUserEvents = do
  (events, eventTrigger) <- newTriggerEvent
  liftIO $ forkIO $ fireEvents eventTrigger
  return events

fireEvents :: (ButtonClick -> IO ()) -> IO ()
fireEvents trigger = forever $ do
    trigger $ ButtonClick "Bob" 1
    threadDelay 100000
