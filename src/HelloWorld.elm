module HelloWorld exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)



-- Model


type alias Model =
    { name : String
    , counter : Int
    }


initialModel : Model
initialModel =
    { name = "Franklin Anderson"
    , counter = 0
    }



-- Update


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | counter = model.counter + 1 }, Cmd.none )

        Decrement ->
            ( { model | counter = model.counter - 1 }, Cmd.none )



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- View


view : Model -> Html Msg
view model =
    div []
        [ text ("Hello " ++ model.name)
        , div []
            [ button [ onClick Decrement ] [ text "Decrement" ]
            , text <|
                String.fromInt <|
                    model.counter
            , button [ onClick Increment ] [ text "Increment" ]
            ]
        ]



-- Main


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialModel, Cmd.none )


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
