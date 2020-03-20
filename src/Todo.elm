module Todo exposing (..)

import Array exposing (..)
import Array.Extra as ArrayExtra
import Browser
import Browser.Dom as Dom
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode
import Task
import Update.Extra as Update



-- Model


type alias Model =
    { todoList : Array String
    , unsavedTodo : String
    }


initialModel : Model
initialModel =
    { todoList =
        Array.fromList
            [ "Write some code"
            , "Make it compile"
            , "Refactor"
            , "Repeat"
            , ".."
            , ".."
            , "Profit"
            ]
    , unsavedTodo = ""
    }



-- Update


onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
    on "keydown" (Decode.map tagger keyCode)


focusNewTodo : Cmd Msg
focusNewTodo =
    Task.attempt (\_ -> NoOp) (Dom.focus "new-todo-input")


type Msg
    = RemoveTodo Int
    | Input String
    | KeyDown Int
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input input ->
            ( { model | unsavedTodo = input }, Cmd.none )

        KeyDown key ->
            if key == 13 then
                ( model, Cmd.none )
                    |> Update.addCmd focusNewTodo

            else
                ( model, Cmd.none )

        RemoveTodo index ->
            ( { model
                | todoList = ArrayExtra.removeAt index model.todoList
              }
            , Cmd.none
            )

        NoOp ->
            ( model, Cmd.none )



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- View


renderTodoList : Array String -> List (Html Msg)
renderTodoList todoList =
    [ div [ class "todo-list" ]
        (todoList
            |> Array.indexedMap
                (\index listItem ->
                    li [ class ("todo-item-" ++ String.fromInt index) ]
                        [ text listItem
                        , button [ class "todo-remove", onClick (RemoveTodo index) ] [ text "X" ]
                        ]
                )
            |> Array.toList
        )
    ]


view : Model -> Html Msg
view model =
    div [ class "todo" ]
        [ ul []
            (renderTodoList model.todoList
                ++ [ div [ class "todo-actions" ]
                        [ li []
                            [ input
                                [ class "todo-input"
                                , onKeyDown KeyDown
                                , onInput Input
                                , value model.unsavedTodo
                                , id "new-todo-input"
                                ]
                                []
                            , button [ class "todo-add" ] [ text "Add" ]
                            ]
                        ]
                   ]
            )
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
