#!/usr/bin/env python3

import traceback

import flask
import psycopg2
import psycopg2.extras
from flask import request, Response
from datetime import datetime

from flights import flights
from configs import configs

# Load the configuration
config = configs.parseConfig()

# Start up the database connection, by default returning dictionaries with property names from queries
db = psycopg2.connect(**config['database'], cursor_factory=psycopg2.extras.RealDictCursor)
# Run the session in autocommit (ie, non-transactional) mode by default.  Do not change this setting.
db.set_session(autocommit=True)

# Build a basic Flask app
app = flask.Flask(__name__)

# TODO: Consider pulling some logic out of this big file.

# Basic ping endpoint
@app.route('/ping')
def ping():
  flights.hello()
  app.logger.debug(f'pinged: {datetime.now()}')
  return {
    'message': 'pong'
  }

# Single flight endpoint
@app.route('/flights/<int:id>')
def getFlight(id):
  # Try to fetch the Flight object from the database
  flight = None
  try:
    # Do the fetch
    flight = flights.getFlight(db, id)
  except Exception:
    # Something went wrong, so log it and return a 500
    traceback.print_exc()
    return { 'message': 'Unknown error' }, 500

  # Couldn't find the Flight
  if flight is None:
    return { 'message': 'Unable to find the requested flight' }, 404

  # Found the Flight, so return it.  __dict__ gives us the default serialization of all properties.
  return { 'data': flight.__dict__ }


@app.route('/flights/book')
def flight_book():
  dest: str = request.args.get("dest")
  start: str = request.args.get("start")
  end: str = request.args.get("end")   # optional
  tickets_count: str = request.args.get('tickets')  # optional
  
  if not dest or not start or not end:
    return {'message': 'Required parameters not included!'}, 400
  if not tickets_count:
    tickets_count = 1
  else:
    tickets_count = int(tickets_count)
  start_date = parse_datetime(start)
  end_date = parse_datetime(end)

  try:
    flight = flights.book_flights(db, dest, start_date, end_date, tickets_count)
  except Exception:
    traceback.print_exc()
    return {'message': 'Unknown error'}, 500
  if flight is None:
    return {'message': 'Unable to find the requested flight'}, 404

  return {'data': flight.__dict__}


def parse_datetime(date: str):
  return datetime.fromisoformat(date)

# Start the app listening.
if __name__ == '__main__':
  app.run(port=config['server']['port'])
