# A class to represent a Flight
class Flight:

  # Member properties:
  #   id:      Integer id
  #   source: String source
  #   destination: String destination
  #   departure:  Datetime departure
  #   arrival: Datetime arrival
  #   tickets_count: Integer tickets_count
  #   price: Integer price
  #   carrier: String carrier

  # Note that these property names match the column names
  def __init__(self, id, source, destination, departure, arrival, tickets_count, price, carrier):
    self.id = id
    self.source = source
    self.destination = destination
    self.departure = departure
    self.arrival = arrival
    self.tickets_count = tickets_count
    self.price = price
    self.carrier = carrier

# Gets a single flight with the given id from the database, or None if it does not exist.
def getFlight(db, id):
  # Open a database connection
  with db.cursor() as cur:
    # Fetch the row.  %(id)s is filled in with 'id' from the parameters dictionary.
    cur.execute('SELECT * FROM flights WHERE id = %(id)s', { 'id': id })
    # See if we got any rows back
    if cur.rowcount == 0:
      # We didn't, so return None
      return None

    # We did, so build a Flight from it.  Note that we can pass the row directly into the
    # Flight constructor because the column names match with the constructor arguments, so
    # the splat (**row) maps the named properties in the row dictionary to the named kwargs
    # in the Flight constructor.
    row = cur.fetchone()
    return Flight(**row)


def book_flights(db, destination, start, end, tickets_count):
  query_search: str = """
  SELECT * FROM flights
  WHERE destination = %(destination)s 
  AND tickets_count > %(tickets_count)s
  AND departure >= %(departure)s
  AND arrival <= %(arrival)s
  ORDER By price ASC
  """
  with db.cursor() as cur:
    cur.execute(query_search, {
      'destination': destination, 
      'tickets_count': tickets_count,
      'departure': start,
      'arrival': end
      })
    if cur.rowcount == 0:
      return None
    row = cur.fetchone()
    result = Flight(**row)
    update_booking(cur, tickets_count, result.id)
    insert_order(cur, result, tickets_count)
    return result

  
def update_booking(cur, tickets_count, id):
  query_modify: str = """
  UPDATE flights
  SET tickets_count = tickets_count - %(tickets_count)s
  WHERE id = %(id)s
  """
  cur.execute(query_modify, {
    'tickets_count': tickets_count,
    'id': id
    })


def insert_order(cur, flight, tickets_count):
  query_insert: str = """
  INSERT INTO orders (id, source, destination, departure, arrival, tickets_count, price, carrier)
  VALUES (%(id)s, %(source)s, %(destination)s, %(departure)s, %(arrival)s, %(tickets_count)s, %(price)s, %(carrier)s);
  """
  cur.execute(query_insert, {
    'id': flight.id,
    'source': flight.source,
    'destination': flight.destination,
    'departure': flight.departure,
    'arrival': flight.arrival,
    'tickets_count': tickets_count,
    'price': flight.price,
    'carrier': flight.carrier
  })
