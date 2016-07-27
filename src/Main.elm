import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes as Attributes
import Html.Events exposing (..)
import Platform.Sub as Sub
import Html.App as App
import String
import Svg exposing (..)
import Svg.Attributes exposing (..)


main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
  }


type alias Model =
  { msg : String
  , xpos : String
  , ypos : String
  }


type Msg =
  UpdateMessage String | UpdateXPos String | UpdateYPos String


init : (Model, Cmd Msg)
init =
    Model "hey" "0" "0" ! []


view : Model -> Html Msg
view model =
  div [ Html.Attributes.class "container" ]
  [ Svg.svg [ Svg.Attributes.width "200", Svg.Attributes.height "200", viewBox "-100 -100 200 200" ]
    [ circle [cx model.xpos, cy model.ypos, r "2" ] []
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
  , input [ placeholder "something", onInput UpdateMessage ] []
  , span [] [ Html.text model.msg ]
  ]


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    UpdateMessage str ->
      { model | msg = str } ! []
    UpdateXPos pos ->
      { model | xpos = pos } ! []
    UpdateYPos pos ->
      case String.toFloat pos of
        Err msg ->
          model ! []
        Ok ypos ->
          { model | ypos = toString (-1 * ypos) } ! []
