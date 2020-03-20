module HelloWorldTest exposing (..)

import Expect exposing (..)
import Fuzz exposing (..)
import HelloWorld.HelloWorld as HelloWorld exposing (..)
import Test exposing (..)


suite : Test
suite =
    let
        model : HelloWorld.Model
        model =
            { name = "Test", counter = 0 }
    in
    describe "Msg"
        [ test "Increment adds 1 to the counter" <|
            \_ ->
                Expect.equal
                    (update HelloWorld.Increment model)
                    ( { model | counter = 1 }, Cmd.none )
        , test "Decrement subtracts 1 from the counter" <|
            \_ ->
                Expect.equal
                    (update HelloWorld.Decrement model)
                    ( { model | counter = -1 }, Cmd.none )
        ]
