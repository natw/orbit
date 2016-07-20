import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Platform.Sub as Sub
import Html.App as App
-- import Html.Events exposing (Cmd)

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
  }


type alias Model =
  { msg : String
  }


type Msg
  = UpdateField String


init : (Model, Cmd Msg)
init =
    Model "initial" ! []


view : Model -> Html Msg
view model =
  div [ class "container" ]
  [ span [] [ text model.msg ]
  , input [ placeholder "something", onInput UpdateField ] []
  ]


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    UpdateField str ->
      { model | msg = str } ! []
