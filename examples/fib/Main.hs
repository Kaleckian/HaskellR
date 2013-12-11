{-# LANGUAGE QuasiQuotes #-}
module Main
  where

import Fib

import qualified H.Prelude as H
import           Language.R.QQ
import qualified Language.R
import qualified Language.R.Interpreter
import qualified Foreign.R
import qualified Foreign.R.Interface

import qualified Foreign

io :: IO a -> H.R a
io = Language.R.io

main :: IO ()
main = do
    Language.R.pokeRVariables
        ( Foreign.R.globalEnv
        , Foreign.R.baseEnv
        , Foreign.R.nilValue
        , Foreign.R.unboundValue
        , Foreign.R.missingArg
        , Foreign.R.rInteractive
        , Foreign.R.Interface.rCStackLimit
        , Foreign.R.rInputHandlers
        )
    Foreign.poke Language.R.Interpreter.isRInitializedPtr 0
    renv <- Language.R.Interpreter.initialize Language.R.Interpreter.defaultConfig
    H.runR renv $ do
        H.print =<< [r| "test" |]
        H.print =<< [r| 1+2 |]
        io $ putStrLn "[r| neg_hs(TRUE, 5) |]"
        H.print =<< [r| neg_hs(TRUE, as.integer(5)) |]
        io $ putStrLn "[r| neg_hs(FALSE, 6) |]"
        H.print =<< [r| neg_hs(FALSE, as.integer(6)) |]
        io $ putStrLn "[r| neg_hs(NA, 7) |]"
        H.print =<< [r| neg_hs(NA, as.integer(7)) |]
        io $ putStrLn "[r| fib_hs(1) |]"
        H.print =<< [r| fib_hs(as.integer(1)) |]
        io $ putStrLn "[r| fib_hs(10) |]"
        H.print =<< [r| fib_hs(as.integer(10)) |]
        io $ putStrLn "[r| fact_hs(0) |]"
        H.print =<< [r| fact_hs(as.integer(0)) |]
        io $ putStrLn "[r| fact_hs(7) |]"
        H.print =<< [r| fact_hs(as.integer(7)) |]
        io $ putStrLn "[r| factSexp_hs(7) |]"
        H.print =<< [r| factSexp_hs(as.integer(7)) |]
