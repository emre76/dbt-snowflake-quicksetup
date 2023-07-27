-- Use the `ref` function to select from other models
WITH source AS (
    SELECT * FROM {{ ref('my_first_dbt_model') }}
)

SELECT source.id
FROM source
WHERE source.id = 1
