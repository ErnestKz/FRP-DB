module User where

data User = User UserName UserPassword
  deriving Show
newtype UserName = UserName String
  deriving Show
newtype UserPassword = UserPassword String
  deriving Show


-- Registered users coming in

-- Input events, verify username is unique in the behaviour
-- Add to "database" which will be a behaviour of a list of users
