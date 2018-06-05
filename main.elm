module Main exposing (..)

import Html
import Html.Attributes
import Html.Events


type alias Model =
    { red : Int
    , alpha : Int
    , green : Int
    , blue : Int
    }


model : Model
model =
    { red = 0
    , alpha = 0
    , green = 0
    , blue = 0
    }


type ColorProperty
    = Red
    | Green
    | Blue
    | Alpha


type Msg
    = Increase ColorProperty
    | Decrease ColorProperty


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

        Decrease Alpha ->
            { model | alpha = model.alpha - 1 }

        Increase Alpha ->
            { model | alpha = model.alpha + 1 }


type alias Markup =
    Html.Html Msg


getColorString : ColorProperty -> String
getColorString color =
    case color of
        Red ->
            "Red"

        Green ->
            "Green"

        Blue ->
            "Blue"

        Alpha ->
            "Alpha"


colorControl : Int -> ColorProperty -> Markup
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


getStyle : Model -> Html.Attribute Msg
getStyle model =
    let
        values =
            { r = toString model.red
            , g = toString model.green
            , b = toString model.blue
            , a = toString model.alpha
            }
    in
    Html.Attributes.style
        [ ( "backgroundColor", "rgba(" ++ values.r ++ "," ++ values.g ++ "," ++ values.b ++ "," ++ values.a ++ ")" ) ]


view : Model -> Markup
view model =
    Html.div [ getStyle model ]
        [ Html.h1 [] [ Html.text "Buttons" ]
        , colorControl model.red Red
        , colorControl model.green Green
        , colorControl model.blue Blue
        , colorControl model.alpha Alpha
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }
