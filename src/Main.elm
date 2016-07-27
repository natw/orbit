import Platform.Cmd as Cmd
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes as Attributes
import Html.Events exposing (..)
import Platform.Sub as Sub
import Html.App as App
import String
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time


main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
  }

tickResolution = 0.01
tickInterval = Time.millisecond

type alias Model =
  { msg : String
  , center_xpos : Float
  , center_ypos : Float
  , time: Float
  }


type Msg =
  Tick Time.Time | UpdateMessage String | UpdateXPos String | UpdateYPos String


init : (Model, Cmd Msg)
init =
    Model "" 0 0 0 ! []


view : Model -> Html Msg
view model =
  let
    xpos =
      toString (model.center_xpos + 20 * (cos model.time))
    ypos =
      toString (model.center_ypos + 20 * (sin model.time))
  in
    div [ Html.Attributes.class "container" ]
    [ Svg.svg [ Svg.Attributes.width "200", Svg.Attributes.height "200", viewBox "-100 -100 200 200" ]
      [ circle [cx xpos, cy ypos, r "2" ] []
      ]
    , br [] []
    , label [ for "xpos" ]
      [ Html.text "xpos"
      , input [ Attributes.type' "range", Attributes.name "xpos", Attributes.max "100", Attributes.min "-100", onInput UpdateXPos ] [] ]
    , br [] []
    , label [ for "ypos" ]
      [ Html.text "ypos"
      , input [ Attributes.type' "range", Attributes.name "ypos", Attributes.max "100", Attributes.min "-100", onInput UpdateYPos ] [] ]
    , br [] []
    , input [ placeholder "type here", onInput UpdateMessage ] []
    , span [] [ Html.text model.msg ]
    ]


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick time ->
      { model | time = model.time + tickResolution } ! []
    UpdateMessage str ->
      { model | msg = str } ! []
    UpdateXPos pos ->
      case String.toFloat pos of
        Err msg ->
          model ! []
        Ok pos ->
          { model | center_xpos = pos } ! []
    UpdateYPos pos ->
      case String.toFloat pos of
        Err msg ->
          model ! []
        Ok pos ->
          { model | center_ypos = pos } ! []


subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every tickInterval Tick
