#! /usr/bin/env nix-shell
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/18.03.tar.gz -p z3 -p "pkgs.haskellPackages.ghcWithPackages (pkgs: with pkgs; [sbv])"
{-# LANGUAGE PackageImports #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
module SBV where

import "base" GHC.Generics  (Generic)
import "base" Data.Data (Data)
import "base" Data.Typeable (Typeable)
import "sbv"  Data.SBV
import        SBV2

deriving instance SymWord Metres
deriving instance HasKind Metres
deriving instance SIntegral Metres
deriving instance SatModel Metres
deriving instance IEEEFloatConvertable Metres

--instance IEEEFloatConvertableMetres where
    --fromSFloat = genericFromFloat
    --fromSDouble m sf    = undefined
    --toSFloat m a  = undefined
    --toSDouble m a = undefined

type SMetres  = SBV Metres

formula :: Symbolic SBool
formula = do
    x :: SInteger <- exists "x"
    y :: SInteger <- exists "y"
    w :: SMetres <- exists "length"
    -- Exponents must be unsigned words
    constrain $ x.^(literal 2 :: SWord8) + y.^(literal 2 :: SWord8) .== (literal 25 :: SInteger)
    constrain $ w .< (literal $ Metres 13)
    return $ (literal 3) * x + 4 * y .== (literal 0)

main :: IO ()
main = do
   result <- sat formula
   print result
