drop view vpcontas;

/*==============================================================*/
/* View: vpcontas                                               */
/*==============================================================*/
create or replace view vpcontas as
WITH RECURSIVE cte(id, cia_id, descricao, path, pai_id, codigo, codcompleto, depth) AS (
        ( SELECT pcontas.id,
            pcontas.cia_id,
            pcontas.descricao,
            ARRAY[pcontas.id] AS path,
            pcontas.pai_id,
            pcontas.codigo,
            ARRAY[pcontas.codigo] AS codcompleto,
            1 AS depth
           FROM pcontas
          WHERE pcontas.pai_id IS NULL
          ORDER BY pcontas.descricao)
        UNION ALL
         SELECT pcontas.id,
            pcontas.cia_id,
            pcontas.descricao,
            cte_1.path || pcontas.id,
            pcontas.pai_id,
            pcontas.codigo,
            cte_1.codcompleto || pcontas.codigo,
            cte_1.depth + 1 AS depth
           FROM pcontas
             JOIN cte cte_1 ON pcontas.pai_id = cte_1.id
        )
 SELECT cte.id,
    cte.cia_id,
    cte.descricao,
    cte.path,
    cte.pai_id,
    cte.codigo,
    array_to_json(cte.codcompleto) AS codcompleto,
    cte.depth,
        CASE
            WHEN (( SELECT count(pcontas.id) AS count
               FROM pcontas
              WHERE pcontas.id = cte.id AND pcontas.pai_id IS NOT NULL AND NOT (pcontas.id IN ( SELECT pcontas_1.pai_id
                       FROM pcontas pcontas_1
                      WHERE pcontas_1.pai_id IS NOT NULL)))) > 0 THEN 'A'::text
            ELSE 'S'::text
        END AS tipo
   FROM cte
  ORDER BY cte.path;
