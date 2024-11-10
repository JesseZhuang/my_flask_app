-- Add some test flights
INSERT INTO flights (id, source, destination, departure, arrival, tickets_count, price, carrier)
VALUES   (1, 'BOS', 'LAX', '2022-10-1 16:00:00'::timestamp, '2022-10-1 21:05:00'::timestamp, 5, 210, 'Spirit'),
         (2, 'BOS', 'LAX', '2022-10-2 16:00:00'::timestamp, '2022-10-2 21:05:00'::timestamp, 20, 209, 'Spirit'),
         (3, 'BOS', 'LAX', '2022-10-1 14:00:00'::timestamp, '2022-10-1 19:20:00'::timestamp, 1, 200, 'Delta'),
         (4, 'BOS', 'LAX', '2022-10-1 18:00:00'::timestamp, '2022-10-1 22:00:00'::timestamp, 10, 220, 'American'),
         (5, 'BOS', 'JFK', '2022-11-3 10:20:00'::timestamp, '2022-11-3 12:30:00'::timestamp, 1, 199, 'JetBlue');
