#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"

# Display services
DISPLAY_SERVICES() {
  echo -e "\nWelcome to the Salon, here are our services:"
  $PSQL "SELECT service_id, name FROM services ORDER BY service_id;" | while IFS='|' read ID NAME
  do
    echo "$ID) $NAME"
  done
}

# Ask for valid service
ASK_SERVICE() {
  echo -e "\nWhich service would you like?"
  read SERVICE_ID_SELECTED
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  if [[ -z $SERVICE_NAME ]]
  then
    echo -e "\nI could not find that service. Please select again."
    DISPLAY_SERVICES
    ASK_SERVICE
  fi
}

# Start script
DISPLAY_SERVICES
ASK_SERVICE

# Get customer info
echo -e "\nEnter your phone number:"
read CUSTOMER_PHONE
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
if [[ -z $CUSTOMER_NAME ]]
then
  echo -e "\nI don't have a record for that phone. What's your name?"
  read CUSTOMER_NAME
  $PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')"
fi

# Appointment time
echo -e "\nWhat time would you like your $SERVICE_NAME?"
read SERVICE_TIME
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
$PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')"

# Confirmation
echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
