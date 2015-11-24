SELECT proname
  FROM pg_proc pr,
       pg_type tp
 WHERE tp.oid = pr.prorettype
   AND pr.proisagg = FALSE
   AND tp.typname <> 'trigger'
   AND pr.pronamespace IN (
       SELECT oid
         FROM pg_namespace
        WHERE nspname NOT LIKE 'pg_%'
          AND nspname != 'information_schema'
);
 
-- with INFORMATION_SCHEMA:
 
SELECT routine_name
  FROM information_schema.routines
 WHERE specific_schema NOT IN
       ('pg_catalog', 'information_schema')
   AND type_udt_name != 'trigger';

