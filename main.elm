module Main exposing (..)

import Html
import Html.Events


type alias Model =
    { red : Int
    , green : Int
    , blue : Int
    }


model : Model
model =
    { red = 0
    , green = 1
    , blue = 2
    }


type Color
    = Red
    | Green
    | Blue


type Msg
    = Increase Color


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increase Red ->
            { model | red = model.red + 1 }

        Increase Green ->
            { model | green = model.green + 1 }

        Increase Blue ->
            { model | blue = model.blue + 1 }


type alias Markup =
    Html.Html Msg


getColorString : Color -> String
getColorString color =
    case color of
        Red ->
            "Red"

        Green ->
            "Green"

        Blue ->
            "Blue"


buttonControl : Int -> Color -> Markup
buttonControl colorValue color =
    let
        colorText =
            getColorString color
    in
    Html.div []
        [ Html.button [ Html.Events.onClick (Increase color) ] [ Html.text colorText ]
        , Html.div [] [ Html.text (toString colorValue) ]
        ]


view : Model -> Markup
view model =
    Html.div []
        [ Html.h1 [] [ Html.text "Buttons" ]
        , buttonControl model.red Red
        , buttonControl model.green Green
        , buttonControl model.blue Blue
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }
