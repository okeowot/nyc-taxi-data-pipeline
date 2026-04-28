SELECT
    VendorID AS vendor_id,
    
    -- The magic happens here: Converting microsecond epochs to readable timestamps
    TO_TIMESTAMP_NTZ(tpep_pickup_datetime, 6) AS pickup_datetime,
    TO_TIMESTAMP_NTZ(tpep_dropoff_datetime, 6) AS dropoff_datetime,
    
    passenger_count,
    trip_distance,
    PULocationID AS pickup_location_id,
    DOLocationID AS dropoff_location_id,
    payment_type,
    fare_amount,
    tip_amount,
    total_amount
FROM {{ source('raw', 'yellow_trips_raw') }}
WHERE trip_distance > 0 AND total_amount > 0