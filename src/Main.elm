module Main exposing (..)

import Browser exposing (Document)
import Browser.Navigation as Nav
import Html exposing (div, text)
import Page.Login as Login
import Page.NotFound as NotFound
import Skeleton
import Url exposing (Url)

-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url
    , page : Page
    }


type Page
    = NotFound
    | Login Login.Model


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    stepUrl url
        { key = key
        , url = url
        , page = Login Login.init
        }



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | LoginMsg Login.Msg
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )

        LoginMsg msg ->
            case model.page of
                Login login -> stepLogin model ( Login.update msg login, Cmd.none )
                _ -> ( model, Cmd.none )




stepLogin : Model -> ( Login.Model, Cmd Login.Msg ) -> ( Model, Cmd Msg )
stepLogin model ( login, cmds ) =
    ( { model | page = Login login }
    , Cmd.map LoginMsg cmds
    )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    case model.page of
        Login login ->
            Skeleton.view LoginMsg (Login.view login)

        NotFound ->
            Skeleton.view never NotFound.view


stepUrl : Url.Url -> Model -> ( Model, Cmd Msg )
stepUrl url model =
    ( model, Cmd.none )
