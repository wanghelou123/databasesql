SELECT trg.tgname AS trigger_name,
       tbl.relname AS table_name,
       p.proname AS function_name,
       CASE trg.tgtype & cast(2 as int2)
         WHEN 0 THEN 'AFTER'
         ELSE 'BEFORE'
       END AS trigger_type,
       CASE trg.tgtype & cast(28 as int2)
         WHEN 16 THEN 'UPDATE'
         WHEN  8 THEN 'DELETE'
         WHEN  4 THEN 'INSERT'
         WHEN 20 THEN 'INSERT, UPDATE'
         WHEN 28 THEN 'INSERT, UPDATE, DELETE'
         WHEN 24 THEN 'UPDATE, DELETE'
         WHEN 12 THEN 'INSERT, DELETE'
       END AS trigger_event,
       CASE trg.tgtype & cast(1 as int2)
         WHEN 0 THEN 'STATEMENT'
         ELSE 'ROW'
       END AS action_orientation
  FROM pg_trigger trg,
       pg_class tbl,
       pg_proc p
 WHERE trg.tgrelid = tbl.oid
   AND trg.tgfoid = p.oid
   AND tbl.relname !~ '^pg_';
