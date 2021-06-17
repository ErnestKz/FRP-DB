module BlueTeam  where

data ButtonClick = ButtonClick User ButtonId
  deriving Show

newtype User = User String
  deriving Show

newtype ButtonId = ButtonId Integer
  deriving Show

