module RedTeam where

data ButtonClick = ButtonClick User ButtonType
  deriving Show

newtype User = User String
  deriving Show

data ButtonType = ButtonA | ButtonB | ButtonC
  deriving Show


