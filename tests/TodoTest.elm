module TodoTest exposing (..)

import Array exposing (..)
import Expect exposing (..)
import Fuzz exposing (..)
import Test exposing (..)
import Todo.Todo as Todo exposing (..)


suite : Test
suite =
    let
        model : Todo.Model
        model =
            { todoList = Array.fromList [ "Test" ]
            , unsavedTodo = ""
            }
    in
    describe "Msg"
        [ test "Input updates model.unsavedTodo" <|
            \_ ->
                Expect.equal
                    (update (Todo.Input "TEST") model)
                    ( { model | unsavedTodo = "TEST" }, Cmd.none )
        , test "RemoveTodo removes the todo list item" <|
            \_ ->
                Expect.equal
                    (update (Todo.RemoveTodo 0) model)
                    ( { model | todoList = Array.fromList [] }, Cmd.none )
        ]
