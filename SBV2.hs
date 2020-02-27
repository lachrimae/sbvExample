{-# LANGUAGE PackageImports #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module SBV2 where

import "base" GHC.Generics  (Generic)
import "base" Data.Data (Data)
import "base" Data.Typeable (Typeable)
import "base" Data.Bits

newtype Metres = Metres Integer
    deriving (Num, Real, Enum, Bits, Integral, Show, Read, Eq, Ord, Data, Typeable, Generic)
