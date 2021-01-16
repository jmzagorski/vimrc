select
    , name as username,
    , create_date,
    , modify_date,
    , type_desc as type
from
    sys.database_principals
order by
    username;
