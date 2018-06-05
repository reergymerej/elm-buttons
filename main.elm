module Main exposing (..)

import Html
import Html.Events


type alias Model =
    { red : Int
    , yellow : Int
    , green : Int
    , blue : Int
    }


model : Model
model =
    { red = 0
    , yellow = 0
    , green = 0
    , blue = 0
    }


type Color
    = Red
    | Green
    | Blue
    | Yellow


type Msg
    = Increase Color
    | Decrease Color


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increase Red ->
            { model | red = model.red + 1 }

        Increase Green ->
            { model | green = model.green + 1 }

        Increase Blue ->
            { model | blue = model.blue + 1 }

        Decrease Red ->
            { model | red = model.red - 1 }

        Decrease Green ->
            { model | green = model.green - 1 }

        Decrease Blue ->
            { model | blue = model.blue - 1 }

        Decrease Yellow ->
            { model | yellow = model.yellow - 1 }

        Increase Yellow ->
            { model | yellow = model.yellow + 1 }


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

        Yellow ->
            "Yellow"


colorControl : Int -> Color -> Markup
colorControl colorValue color =
    let
        colorText =
            getColorString color
    in
    Html.div []
        [ Html.button [ Html.Events.onClick (Decrease color) ] [ Html.text "-" ]
        , Html.span [] [ Html.text (toString colorValue ++ " " ++ colorText) ]
        , Html.button [ Html.Events.onClick (Increase color) ] [ Html.text "+" ]
        ]


view : Model -> Markup
view model =
    Html.div []
        [ Html.h1 [] [ Html.text "Buttons" ]
        , colorControl model.red Red
        , colorControl model.yellow Yellow
        , colorControl model.green Green
        , colorControl model.blue Blue
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }
