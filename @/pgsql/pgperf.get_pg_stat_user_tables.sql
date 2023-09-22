-- 各回の間での差分あるいは変化量でパラメータ調整効果を見る?

-- 途中でstats_resetされている

-- 指定したテーブルのpg_stat_user_tables

-- グラフの傾きで見れば良い?


CREATE OR REPLACE FUNCTION pgperf.get_pg_stat_user_tables(
    _table_name TEXT,
    _start_sid SMALLINT DEFAULT 1,
    _end_sid SMALLINT DEFAULT 32767
) RETURNS TABLE (

    -- pgperf.pg_stat_user_tables + 時刻==>どの時間を?
    -- snap? reset? interval? intervalの積算?

    
) AS $$
DECLARE
    _db_name TEXT;
    _rec RECORD;
    _cnt INTEGER := 0;
    _prev RECORD;

BEGIN

    --出来る? 別途function必要?
    _db_name := SELECT current_database();
    
    FOR _rec IN
        SELECT A.snap_time
            , B.*
            , C.stats_reset
        FROM (
            SELECT *
            FROM pgperf.pg_stat
            WHERE sid BETWEEN _start_sid AND _end_sid
        ) A
        JOIN (
            SELECT
            FROM pgperf.pg_stat_user_tables
            WHERE relname = _table_name
         ) B
            ON B.sid = A.sid
        LEFT JOIN (
            SELECT sid, stats_reset
            FROM pgperf.pg_stat_database
            WHERE datname = _db_name
         ) C
            ON C.sid = A.sid
        ORDER BY sid
    LOOP
        --1行目はreset時間からのデータそのままreturn
        IF _cnt = 0 THEN
            --nop?
            --stats_resetからsnap_timeまでのintervalで


            
        --前回値とstats_reset時刻が同じ
        ELSIF _rec.stats_reset = _prev.stats_reset
            --差分
                --snap_time同士のintervalで

            
        --前回値とstats_reset時刻が異なる
        ELSE
            --どうする?
            --stats_resetからsnap_timeまでのintervalで


            
        END IF;
        
        _cnt := _cnt + 1;
        
        _prev := _rec;

        --RETURN構造に合わせて記述
        RETURN NEXT sid
            , oid, ....
        
    END LOOP;

    RETURN;

EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION '%', MESSAGE_TEXT;
        RETURN;
END;
$$ LANGUAGE plpgsql;
