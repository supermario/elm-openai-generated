# Human notes

This is a bit of a meta experiment to see if OpenAI can write (and maintain!) some Elm software.

Spoiler: it can't quite do it by itself yet.

The original transcripts can be found under `transcripts`.

## Things GPT struggled with

Sometimes it struggles to integrate feedback into prior almost-correct examples, so some of its output has been selectively chosen to save time trying to convince GPT of the specifics.

The more involved struggles were:

- Swapping `--` comments with `{-| ... -}` comments required for exposed function documentation in Elm packages – just seemed to not understand what was being asked of it
- Some incorrect API derivation, not sure where it invented the non-existent `RequestOptions` type from, maybe someone else's github code?
  ```
  -- NAMING ERROR ------------------------------------------------ OpenAI/Chat.elm

  I cannot find a `Http.RequestOptions` type:

  38| openaiOptions : Http.RequestOptions -> Http.RequestOptions
                                             ^^^^^^^^^^^^^^^^^^^
  The `Http` module does not expose a `RequestOptions` type. These names seem
  close though:

      Http.Response
      Http.Resolver
      Http.Expect
      Http.Progress
  ```
- GPT really struggled to figure out the `Task` definition instead of the `Cmd` definition for the HTTP query. Had to give it some help on the JSON resolver, which to be fair is a bit trisky anyway.

