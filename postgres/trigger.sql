SELECT trg.tgname AS trigger_name
FROM pg_trigger trg, pg_class tbl
WHERE trg.tgrelid = tbl.oid
AND tbl.relname !~ '^pg_';
-- or
SELECT tgname AS trigger_name
FROM pg_trigger
WHERE tgname !~ '^pg_';

-- with INFORMATION_SCHEMA:

SELECT DISTINCT trigger_name
FROM information_schema.triggers
WHERE trigger_schema NOT IN
('pg_catalog', 'information_schema');

SELECT trg.tgname AS trigger_name
FROM pg_trigger trg, pg_class tbl
WHERE trg.tgrelid = tbl.oid
AND tbl.relname = 'newtable';

-- with INFORMATION_SCHEMA:

SELECT DISTINCT trigger_name
FROM information_schema.triggers
WHERE event_object_table = 'newtable'
AND trigger_schema NOT IN
('pg_catalog', 'information_schema');

