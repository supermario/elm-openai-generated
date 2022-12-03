module OpenAI.Chat exposing (query)

import Http
import Json.Decode as Decode
import Json.Encode as Encode
import OpenAI.HumanCode
import Task



-- Define the type of the response data


type alias OpenaiResponse =
    { response : String }



-- Define the decoder for the response data


openaiResponseDecoder : Decode.Decoder OpenaiResponse
openaiResponseDecoder =
    Decode.map OpenaiResponse (Decode.field "response" Decode.string)



-- Query OpenAI API


query :
    { apiKey : String
    , queryString : String
    , maxTokens : Int
    , temperature : Float
    }
    -> Task.Task Http.Error OpenaiResponse
query { apiKey, queryString, maxTokens, temperature } =
    let
        endpoint =
            "https://api.openai.com/v1/completions"

        headers =
            [ Http.header "Content-Type" "application/json"
            , Http.header "Authorization" ("Bearer " ++ apiKey)
            ]

        body =
            Encode.object
                [ ( "prompt", Encode.string queryString )
                , ( "max_tokens", Encode.int maxTokens )
                , ( "temperature", Encode.float temperature )
                ]

        request =
            Http.task
                { method = "POST"
                , headers = headers
                , body = Http.jsonBody body
                , timeout = Nothing
                , resolver = OpenAI.HumanCode.jsonResolver openaiResponseDecoder
                , url = endpoint
                }
    in
    request
