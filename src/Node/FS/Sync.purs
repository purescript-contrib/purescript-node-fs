module Node.FS.Sync
  ( readFile
  , readTextFile
  ) where

import Control.Monad.Eff
import Control.Monad.Eff.Exception
import Data.Function
import Node.Buffer (Buffer(..))
import Node.Encoding
import Node.FS
import Node.FS.Stats
import Node.Path (FilePath())
import Global (Error(..))

foreign import fs "var fs = require('fs');" :: 
  { readFileSync :: forall a opts. Fn2 FilePath { | opts } a
  }

-- |
-- Reads the entire contents of a file returning the result as a raw buffer.
-- 
readFile :: forall eff. FilePath 
                     -> Eff (fs :: FS, err :: Exception Error | eff) Buffer

readFile file = return $ runFn2
  fs.readFileSync file {}

-- |
-- Reads the entire contents of a text file with the specified encoding.
-- 
readTextFile :: forall eff. Encoding 
                         -> FilePath 
                         -> Eff (fs :: FS, err :: Exception Error | eff) String

readTextFile encoding file = return $ runFn2
  fs.readFileSync file { encoding: show encoding }