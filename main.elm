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
    let
        step =
            10
    in
    case msg of
        Increase Red ->
            { model | red = model.red + step }

        Increase Green ->
            { model | green = model.green + step }

        Increase Blue ->
            { model | blue = model.blue + step }

        Decrease Red ->
            { model | red = model.red - step }

        Decrease Green ->
            { model | green = model.green - step }

        Decrease Blue ->
            { model | blue = model.blue - step }

        Decrease Alpha ->
            { model | alpha = model.alpha - step }

        Increase Alpha ->
            { model | alpha = model.alpha + step }


type alias Markup =
    Html.Html Msg


getColorPropertyString : ColorProperty -> String
getColorPropertyString colorProp =
    case colorProp of
        Red ->
            "Red"

        Green ->
            "Green"

        Blue ->
            "Blue"

        Alpha ->
            "Alpha"


colorControl : Int -> ColorProperty -> Markup
colorControl colorValue colorProp =
    let
        colorText =
            getColorPropertyString colorProp
    in
    Html.div []
        [ Html.button [ Html.Events.onClick (Decrease colorProp) ] [ Html.text "-" ]
        , Html.span [] [ Html.text (toString colorValue ++ " " ++ colorText) ]
        , Html.button [ Html.Events.onClick (Increase colorProp) ] [ Html.text "+" ]
        ]


getStyle : Model -> Html.Attribute Msg
getStyle model =
    let
        values =
            { r = toString model.red
            , g = toString model.green
            , b = toString model.blue
            , a = toString (toFloat model.alpha / 100)
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
