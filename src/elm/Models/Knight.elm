module Knight exposing (..)

import Models.Avatar


-- faction true = black


type alias Knight a =
    { a
        | name : String
        , faction : Bool
    }
